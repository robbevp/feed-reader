{
  description = "A flake to run feed reader";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.05";
    flake-utils.url = "github:numtide/flake-utils";
    devshell = {
      url = "github:numtide/devshell";
      inputs = {
        nixpkgs.follows = "nixpkgs";
      };
    };
  };

  outputs = { self, nixpkgs, flake-utils, devshell }:
    flake-utils.lib.eachDefaultSystem
      (system:
        let
          version = "0.1.0";
          pkgs = import nixpkgs {
            inherit system;
            overlays = [ devshell.overlays.default ];
          };
          gems = pkgs.bundlerEnv rec {
            name = "feed-reader-env";
            ruby = pkgs.ruby_3_2;
            gemfile = ./Gemfile;
            lockfile = ./Gemfile.lock;
            gemset = ./gemset.nix;
            groups = [ "default" "development" "test" "production" ];
          };
          node-modules = pkgs.mkYarnModules {
            pname = "feed-reader-modules";
            inherit version;
            packageJSON = ./package.json;
            yarnLock = ./yarn.lock;
            yarnNix = ./yarn.nix;
          };
        in
        {
          packages = rec {
            default = feed-reader;
            feed-reader = pkgs.stdenv.mkDerivation rec {
              pname = "feed-reader";
              inherit version;
              src = pkgs.lib.cleanSourceWith {
                filter = name: type:
                  !(builtins.elem name [ ".github" "flake.lock" "flake.nix" ]);
                src = ./.;
                name = "source";
              };

              buildInputs = [ pkgs.yarn ];

              buildPhase = ''
                # 1. Set revision
                echo ${self.rev or ""} > REVISION

                # 2. Compile bootsnap cache
                ${gems}/bin/bundle exec bootsnap precompile --gemfile app/ lib/

                # 3. Compile assets 
                ln -s ${node-modules}/node_modules .

                # We need to compile with the production flag, so vite_rails compiles to the right folder
                # We also need to provide rails with _some_ SECRET_KEY_BASE, so we just provide a dummy value
                RAILS_ENV=production ${gems}/bin/bundle exec vite build
                rm node_modules
              '';

              installPhase = ''
                mkdir $out
                cp -r * $out
              '';

              passthru.env = gems;
            };
          };
          devShells = rec {
            default = feed-reader;
            feed-reader = pkgs.devshell.mkShell {
              name = "Feed Reader";
              packages = [
                gems
                (pkgs.lowPrio gems.wrappedRuby)
                pkgs.nixpkgs-fmt
                pkgs.nodejs-18_x
                pkgs.postgresql_15
                pkgs.yarn
              ];
              env = [
                {
                  name = "PGDATA";
                  eval = "$PRJ_DATA_DIR/postgres";
                }
                {
                  name = "DATABASE_HOST";
                  eval = "$PGDATA";
                }
                {
                  name = "BUNDLE_FORCE_RUBY_PLATFORM";
                  eval = "1";
                }
              ];
              commands = [
                {
                  name = "pg:setup";
                  category = "database";
                  help = "Setup postgres in project folder";
                  command = ''
                    initdb --encoding=UTF8 --no-locale --no-instructions -U postgres
                    echo "listen_addresses = ${"'"}${"'"}" >> $PGDATA/postgresql.conf
                    echo "unix_socket_directories = '$PGDATA'" >> $PGDATA/postgresql.conf
                    echo "CREATE USER feed_reader WITH PASSWORD 'feed_reader' CREATEDB;" | postgres --single -E postgres
                  '';
                }
                {
                  name = "pg:start";
                  category = "database";
                  help = "Start postgres instance";
                  command = ''
                    [ ! -d $PGDATA ] && pg:setup
                    pg_ctl -D $PGDATA -U postgres start -l log/postgres.log
                  '';
                }
                {
                  name = "pg:stop";
                  category = "database";
                  help = "Stop postgres instance";
                  command = ''
                    pg_ctl -D $PGDATA -U postgres stop
                  '';
                }
                {
                  name = "pg:console";
                  category = "database";
                  help = "Open database console";
                  command = ''
                    psql --host $PGDATA -U postgres 
                  '';
                }
                {
                  name = "pg:save";
                  category = "database";
                  help = "Saves database to a specified path. Use as `pg:save ~/some/path/db.sql`";
                  command = ''
                    pg_dump -h $PGDATA -U postgres feed_reader_development > $1
                  '';
                }
                {
                  name = "pg:load";
                  category = "database";
                  help = "Loads the database from a specified path. Use as `pg:load ~/some/path/db.sql`";
                  command = ''
                    # Kill active sessions
                    psql -b -o /dev/null \
                         -h $PGDATA -U postgres \
                         -d feed_reader_development \
                         -c "SELECT pg_terminate_backend(pg_stat_activity.pid) FROM pg_stat_activity WHERE datname='feed_reader_development' AND pid <> pg_backend_pid();" \
                         --quiet
                    # Reload database
                    dropdb -h $PGDATA -U postgres feed_reader_development && \
                    createdb -h $PGDATA -U postgres -O feed_reader feed_reader_development && \
                    psql -b -o /dev/null \
                      -h $PGDATA -U postgres \
                      -d feed_reader_development \
                      -f $1 \
                      --quiet
                  '';
                }
                {
                  name = "update:gems";
                  category = "Dependencies";
                  help = "Update `Gemfile.lock` and `gemset.nix`";
                  command = ''
                    ${pkgs.ruby_3_2}/bin/bundle lock
                    ${pkgs.bundix}/bin/bundix
                  '';
                }
                {
                  name = "update:yarn";
                  category = "Dependencies";
                  help = "Update `yarn.lock` and `yarn.nix`";
                  command = ''
                    ${pkgs.yarn}/bin/yarn install
                    ${pkgs.yarn2nix}/bin/yarn2nix > yarn.nix
                  '';
                }
                {
                  name = "lint:check";
                  category = "Linting";
                  help = "Check for linting errors";
                  command = ''
                    set +e
                    rubocop
                    erblint --lint-all
                    yarn lint:js
                    yarn lint:css
                    nixpkgs-fmt --check flake.nix module.nix
                  '';
                }
                {
                  name = "lint:fix";
                  category = "Linting";
                  help = "Fix linting errors";
                  command = ''
                    set +e
                    rubocop -A
                    erblint --lint-all -a
                    yarn lint:js --fix
                    yarn lint:css --fix
                    nixpkgs-fmt flake.nix module.nix
                  '';
                }
              ];
            };
          };

        }
      ) // {
      nixosModules = rec {
        feed-reader = import ./module.nix;
        default = feed-reader;
      };
    };
}
