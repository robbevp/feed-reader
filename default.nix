{ stdenv
, lib
, ruby_4_0
, bundlerEnv
, importNpmLock
, nodejs_24
, revision ? ""
}:

let
  rootFiles = lib.fileset.fileFilter
    (
      file:
      builtins.elem file.name [
        "config.ru"
        "Gemfile"
        "Gemfile.lock"
        "gemset.nix"
        "Rakefile"
        "vite.config.js"
      ]
    ) ./.;
  srcFiles = lib.fileset.unions [
    rootFiles
    ./app
    ./bin
    ./config
    ./db
    ./lib
    ./public
  ];
  ruby = ruby_4_0.override { jemallocSupport = true; };
  gems = bundlerEnv {
    inherit ruby;
    name = "feed-reader-env";
    gemfile = ./Gemfile;
    lockfile = ./Gemfile.lock;
    gemset = ./gemset.nix;
    groups = [
      "default"
      "development"
      "test"
      "production"
    ];
  };
  node-modules = importNpmLock.buildNodeModules {
    npmRoot = ./.;
    nodejs = nodejs_24;
    derivationArgs = {
      npmFlags = [ "--legacy-peer-deps" ];
    };
  };

in
stdenv.mkDerivation {
  pname = "feed-reader";
  version = "0.1.0";
  src = lib.fileset.toSource {
    root = ./.;
    fileset = srcFiles;
  };

  buildInputs = [
    importNpmLock.hooks.linkNodeModulesHook
    nodejs_24
  ];

  npmDeps = node-modules;

  buildPhase = ''
    # 1. Set revision
    echo ${revision} > REVISION

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

  passthru = {
    env = gems;
  };
}
