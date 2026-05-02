{
  description = "A flake to run feed reader";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    devshell = {
      url = "github:numtide/devshell";
      inputs = {
        nixpkgs.follows = "nixpkgs";
      };
    };
    bundix = {
      url = "github:inscapist/bundix";
      inputs = {
        nixpkgs.follows = "nixpkgs";
      };
    };
  };

  outputs = { self, nixpkgs, flake-utils, devshell, bundix }:
    flake-utils.lib.eachDefaultSystem
      (system:
        let
          version = "0.1.0";
          pkgs = import nixpkgs {
            inherit system;
            overlays = [
              devshell.overlays.default
              (self: super: {
                bundix = bundix;
              })
            ];
          };
          ruby = pkgs.ruby_3_4;
          gems = pkgs.bundlerEnv rec {
            name = "feed-reader-env";
            inherit ruby;
            gemfile = ./Gemfile;
            lockfile = ./Gemfile.lock;
            gemset = ./gemset.nix;
            groups = [ "default" "development" "test" "production" ];
          };
          update-yarn-hash = pkgs.writeShellScriptBin "update-yarn-hash" ''
            nix-hash --type sha256 --to-sri $(${pkgs.prefetch-yarn-deps}/bin/prefetch-yarn-deps 2>/dev/null) > yarn.lock.hash
          '';
        in
        {
          packages = rec {
            default = feed-reader;
            feed-reader = pkgs.stdenv.mkDerivation (finalAttrs: {
              pname = "feed-reader";
              inherit version;
              src = pkgs.lib.cleanSourceWith {
                filter = name: type:
                  !(builtins.elem name [ ".github" "flake.lock" "flake.nix" ]);
                src = ./.;
                name = "source";
              };
              yarnOfflineCache = pkgs.fetchYarnDeps {
                yarnLock = ./yarn.lock;
                hash = builtins.readFile ./yarn.lock.hash;
              };

              buildInputs = [
                pkgs.yarnConfigHook
                pkgs.yarnBuildHook
                pkgs.yarnInstallHook
                pkgs.nodejs_24
              ];

              buildPhase = ''
                # 1. Set revision
                echo ${self.rev or ""} > REVISION

                # 2. Compile bootsnap cache
                ${gems}/bin/bundle exec bootsnap precompile --gemfile app/ lib/

                # 3. Compile assets 
                # We need to compile with the production flag, so vite_rails compiles to the right folder
                RAILS_ENV=production ${gems}/bin/bundle exec vite build

                # 4. Remove the node modules (these aren't needed at runtime)
                rm -r node_modules
              '';

              installPhase = ''
                mkdir $out
                cp -r * $out
              '';

              passthru.env = gems;
            });
          };
          devShells = rec {
            default = feed-reader;
            feed-reader = pkgs.devshell.mkShell {
              name = "Feed Reader";
              packages = [
                gems
                (pkgs.lib.lowPrio gems.wrappedRuby)
                pkgs.nixpkgs-fmt
                pkgs.nodejs_24
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
              serviceGroups.server.services = {
                web.command = "rdbg -O -n -c \"rails s -p 3000\"";
                vite.command = "vite dev";
              };
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
                    ${pkgs.ruby_3_4}/bin/bundle lock --add-checksums
                    ${pkgs.bundix}/bin/bundix
                  '';
                }
                {
                  name = "update:yarn";
                  category = "Dependencies";
                  help = "Update `yarn.lock` and `yarn.lock.hash`";
                  command = ''
                    ${pkgs.yarn}/bin/yarn install
                    ${update-yarn-hash}/bin/update-yarn-hash
                  '';
                }
                {
                  name = "lint:check";
                  category = "Linting";
                  help = "Check for linting errors";
                  command = ''
                    set +e
                    rubocop
                    erb_lint --lint-all
                    brakeman
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
                    erb_lint --lint-all -a
                    brakeman
                    yarn lint:js --fix
                    yarn lint:css --fix
                    nixpkgs-fmt flake.nix module.nix
                  '';
                }
              ];
            };
            # A mini-shell that only includes bundix and yarn2nix.
            # This only meant to have the right version of these dependencies in our workflows
            deps = pkgs.devshell.mkShell {
              packages = [
                ruby
                pkgs.bundix
                update-yarn-hash
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
