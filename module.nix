{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.services.feed-reader;
  feed-reader = cfg.package;
  migrationScript = pkgs.writeShellScript "feed-reader-migrate" ''
    if ${feed-reader.env}/bin/bundle exec rails db:migrate:status 2>&1 | grep "Schema migrations table does not exist yet"
    then
      ${feed-reader.env}/bin/bundle exec rails db:schema:load
    else
      ${feed-reader.env}/bin/bundle exec rails db:migrate
    fi
  '';
  env = {
    # General
    RAILS_ENV = "production";
    RACK_ENV = "production";
    RAILS_LOG_TO_STDOUT = "yes";
    RUBY_YJIT_ENABLE = "1";
    DATABASE_URL = "postgres://%2Frun%2Fpostgresql/feed_reader";
    DATABASE_NAME = "feed_reader";
    BOOTSNAP_READONLY = "TRUE";
    HOSTNAME = cfg.hostname;

    # Puma
    PIDFILE = "/run/feed_reader/server.pid";
    STATEPATH = "/run/feed_reader/server.state";
    SOCKETFILE = "unix:///run/feed_reader/server.sock";
    WEB_CONCURRENCY = toString cfg.pumaWorkers;

    # Active storage
    RAILS_STORAGE_PATH = "${cfg.home}/storage";

    # Action mailer
    RAILS_MAILER_DEFAULT_FROM = cfg.mailer.defaultFrom;
    RAILS_SMTP_ADDRESS = cfg.mailer.smtpAddress;
    RAILS_SMTP_DOMAIN = cfg.mailer.smtpDomain;
    RAILS_SMTP_USER_NAME = cfg.mailer.smtpUserName;

    # Action mailbox
    RAILS_INBOUND_EMAIL_DOMAIN = cfg.mailer.inboundDomain;

    # Sentry
    SENTRY_DSN = cfg.sentry.DNS;
    SENTRY_TRACES_SAMPLE_RATE = cfg.sentry.tracesSampleRate;
  };
  exports = lib.concatStringsSep "\n"
    (lib.mapAttrsToList (name: value: ''export ${name}="${value}"'') env);

  console = pkgs.writeShellScriptBin "feed-reader-interactive" ''
    ${exports}
    export $(cat ${cfg.environmentFile} | xargs)
    cd ${feed-reader}
    ${feed-reader.env}/bin/bundle exec rails "$@"
  '';
  relayMailScript = pkgs.writeShellScript "feed-reader-mail-relay" ''
    ${exports}
    export $(${pkgs.coreutils}/bin/cat ${cfg.environmentFile} | ${pkgs.findutils}/bin/xargs)
    cd ${feed-reader}
    ${feed-reader.env}/bin/bundle exec rails action_mailbox:ingress:postfix URL='https://${cfg.hostname}/rails/action_mailbox/relay/inbound_emails' INGRESS_PASSWORD=$RAILS_INBOUND_EMAIL_PASSWORD
  '';
in
{
  options.services.feed-reader = {
    enable = mkEnableOption "feed-reader";

    package = mkOption {
      description = ''
        Feed reader package to use
      '';
      default = pkgs.feed-reader;
      defaultText = "pkgs.feed-reader";
      type = types.package;
    };

    home = mkOption {
      description = "The directory where picture it will run.";
      default = "/var/lib/feed_reader";
      type = types.path;
    };

    hostname = mkOption {
      description = ''
        The virtual hostname on which nginx will host the application.
      '';
      example = "reader.example.com";
      type = types.str;
    };

    environmentFile = mkOption {
      description = ''
        Path to a file or a list of filepath containing secret environment variables that
        should be passed to feed reader.
        
        Currently this has to contain the `MASTER_KEY` and `SECRET_KEY_BASE`
        environment variables, which can be generated using rails secret.
        You should also include `RAILS_SMTP_PASSWORD` for the mailer to work.
      '';
      example = "/run/secrets/feed_reader";
      type = types.either types.str (types.listOf types.str);
    };

    backgroundWorkers = mkOption {
      description = ''
        A list of workers, with the queues they should use.

        Each element in the list will spawn a worker with `QUEUES` set to the listitem.
      '';
      default = [ "*" ];
      example = [ "default" "default" ];
      type = types.listOf types.str;
    };

    pumaWorkers = mkOption {
      description = ''
        Specifiy the amount of workers that puma should use.

        If the value is 0, puma will be booted in non-clustered mode.
      '';
      default = 0;
      example = 2;
      type = types.int;
    };

    backupLocation = mkOption {
      description = ''
        Location on filesystem where postgres backup can be created.
      '';
      example = "/mount/backups/smartmonitor";
      type = types.str;
      default = "";
    };

    mailer = {
      defaultFrom = mkOption {
        description = ''
          Email address form which all mails will be sent.
        '';
        example = "noreply@example.org";
        type = types.str;
      };

      smtpAddress = mkOption {
        description = ''
          Address of webserver from which mails will be sent.
        '';
        example = "noreply@example.org";
        default = "localhost";
        type = types.str;
      };

      smtpDomain = mkOption {
        description = ''
          Specify the HELO domain. 
        '';
        example = "noreply@example.org";
        default = cfg.mailer.smtpAddress;
        type = types.str;
      };

      smtpUserName = mkOption {
        description = ''
          The username to login on the SMTP server.

          Note that a password needs to be supplied through the `environmentFile` option.
        '';
        example = "noreply@example.org";
        default = cfg.mailer.smtpAddress;
        type = types.str;
      };

      inboundDomain = mkOption {
        description = ''
          The mail domain on which you want to receive emails. The hostname is used by default.
          
          This will install postfix on mail.DOMAIN.
          You need to add an MX record from DOMAIN to mail.DOMAIN to your DNS settings. 
        '';
        example = "mail.example.com";
        default = cfg.hostname;
        type = types.str;
      };
    };

    sentry = {
      DSN = mkOption {
        description = ''
          Set a Sentry Data Source Name to report issues and performance metrics to.
        '';
        example = "https://abc.ingest.sentry.io/123";
        default = "";
        type = types.str;
      };

      tracesSampleRate = mkOptions {
        description = ''
          Set the sample rate for performance metrics.
        '';
        example = 0.5;
        default = 0;
        type = types.float;
      };
    };

    nginx = mkOption {
      default = { };
      example = { basicAuthFile = ./path/to/basic/auth/file; };
      description = ''
        With this option, you can customize an nginx virtualHost which already
        has sensible defaults for feed reader. Set this to {} to just
        enable the virtualHost if you don't need any customization. If this is
        set to null (the default), no nginx virtualHost will be configured.
      '';
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [
      console
    ];

    services.postgresql = {
      enable = true;
      package = pkgs.postgresql_15;
      ensureDatabases = [ "feed_reader" ];
      ensureUsers = [{
        name = "feed_reader";
        ensurePermissions = { "DATABASE feed_reader" = "ALL PRIVILEGES"; };
      }];
    };

    services.postfix =
      let
        certDir = config.security.acme.certs."${cfg.mailer.inboundDomain}".directory;
      in
      {
        enable = true;
        hostname = "mail.${cfg.mailer.inboundDomain}";
        virtual = ''
          @${cfg.mailer.inboundDomain} feed_reader@${cfg.mailer.inboundDomain}
        '';
        transport = ''
          ${cfg.mailer.inboundDomain} forward_to_feed_reader:
        '';
        relayDomains = [
          cfg.mailer.inboundDomain
        ];
        masterConfig.forward_to_feed_reader = {
          command = "pipe";
          privileged = true;
          args = [
            # See pipe manual for details on these settings https://www.postfix.org/pipe.8.html
            "flags=Xhq"
            "user=feed_reader"
            "argv=${relayMailScript}"
          ];
        };
        sslCert = "${certDir}/cert.pem";
        sslKey = "${certDir}/key.pem";
      };

    networking.firewall.allowedTCPPorts = [ 25 ];

    systemd.tmpfiles.rules = [
      "d /run/feed_reader 0755 feed_reader feed_reader -"
      "d /var/log/feed_reader 0755 feed_reader feed_reader -"
      "d ${cfg.home}/storage 0755 feed_reader feed_reader -"
    ];

    systemd.services = {
      feed-reader = {
        after = [ "network.target" "postgresql.service" ];
        requires = [ "postgresql.service" "feed-reader.socket" ];
        wantedBy = [ "multi-user.target" ];
        environment = env;
        path = [
          feed-reader.env
          feed-reader.env.wrappedRuby
        ];
        serviceConfig = {
          EnvironmentFile = cfg.environmentFile;
          Type = "simple";
          User = "feed_reader";
          Group = "feed_reader";
          Restart = "on-failure";
          WorkingDirectory = feed-reader;
          ExecStartPre = [ migrationScript ];
          ExecStart =
            "${feed-reader.env}/bin/puma -C ${feed-reader}/config/puma.rb";
        };
      };
    } // (builtins.foldl' (x: y: x // y) { } (builtins.genList
      (index: {
        "feed-reader-worker-${toString (index + 1)}" = {
          after = [
            "network.target"
            "feed-reader.service"
            "postgresql.service"
          ];
          requires = [ "postgresql.service" ];
          partOf = [ "feed-reader-workers.service" ];
          wantedBy = [ "multi-user.target" ];
          environment = env // {
            GOOD_JOB_QUEUES = (builtins.elemAt cfg.backgroundWorkers index);
          };
          path = [ feed-reader.env feed-reader.env.wrappedRuby ];
          serviceConfig = {
            EnvironmentFile = cfg.environmentFile;
            Type = "simple";
            User = "feed_reader";
            Group = "feed_reader";
            Restart = "always";
            WorkingDirectory = feed-reader;
            ExecStart = "${feed-reader.env}/bin/bundle exec good_job start";
          };
        };
      })
      (builtins.length cfg.backgroundWorkers)));

    systemd.sockets = {
      feed-reader = {
        wantedBy = [ "sockets.target" ];
        wants = [ "feed-reader.service" ];
        listenStreams = [ "0.0.0.0:3000" "/run/feed_reader/server.sock" ];
        socketConfig = {
          # Socket options matching Puma defaults
          NoDelay = true;
          ReusePort = true;
          Backlog = 1024;
        };
      };
    };

    users.users.feed_reader = {
      group = "feed_reader";
      home = cfg.home;
      createHome = true;
      isSystemUser = true;
    };
    users.groups.feed_reader = { };

    services.nginx.upstreams = {
      "feed_reader_server" = {
        servers = {
          "${env.SOCKETFILE}" = { };
        };
      };
    };

    security.acme.certs."${cfg.mailer.inboundDomain}".webroot = "/var/lib/acme/.challenges";

    services.nginx.virtualHosts = mkIf (cfg.nginx != null) {
      "${cfg.hostname}" = mkMerge [
        cfg.nginx
        {
          root = "${feed-reader}/public";
          enableACME = true;
          forceSSL = true;
          locations = {
            "/" = { tryFiles = "$uri @rails"; };
            "@rails" = {
              proxyPass = "http://feed_reader_server";
              extraConfig = ''
                proxy_set_header X-Forwarded-Ssl on;
              '';
            };
          };
        }
      ];
      "mail.${cfg.mailer.inboundDomain}" = {
        enableACME = true;
      };
    };

    services.postgresqlBackup = {
      enable = (builtins.stringLength cfg.backupLocation) > 0;
      location = cfg.backupLocation;
      databases = [ "feed_reader" ];
    };
  };
}
