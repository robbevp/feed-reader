{
  description = "Feed Reader development";

  inputs = {
    super = {
      url = "../";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    bundix = {
      url = "github:inscapist/bundix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    devshell = {
      url = "github:numtide/devshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs: {
    devShells = builtins.mapAttrs
      (
        system: pkgs':
          let
            pkgs = pkgs'.appendOverlays [
              (self: super: {
                bundix = inputs.bundix;
              })
              inputs.super.overlays.default
              inputs.devshell.overlays.default
            ];
          in
          {
            default = pkgs.devshell.mkShell {
              name = "Feed Reader";
              packages = [
                pkgs.feed-reader.env
                (pkgs.lib.lowPrio pkgs.feed-reader.env.wrappedRuby)
                pkgs.nixpkgs-fmt
                pkgs.nodejs_24
                pkgs.postgresql_15
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
                    ${pkgs.ruby_4_0}/bin/bundle lock --add-checksums
                    ${pkgs.bundix}/bin/bundix
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
                    npm run lint:js
                    npm run lint:css
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
                    npm run lint:js -- --fix
                    npm run lint:css -- --fix
                    nixpkgs-fmt flake.nix module.nix
                  '';
                }
              ];
            };
            deps = pkgs.devshell.mkShell {
              packages = [
                pkgs.feed-reader.ruby
                pkgs.bundix
              ];
            };
          }
      )
      inputs.nixpkgs.legacyPackages;
  };
}
