{
  actioncable = {
    dependencies = ["actionpack" "activesupport" "nio4r" "websocket-driver" "zeitwerk"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "14vlhzrgfgmz0fvrvd81j9xfw8ig091yiwq496firapgxffd7jpq";
      type = "gem";
    };
    version = "8.0.3";
  };
  actionmailbox = {
    dependencies = ["actionpack" "activejob" "activerecord" "activestorage" "activesupport" "mail"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0bxxqqflmczwl4ivcqjwwsnrhljcalk1i2hj02qisr3wjgw4811a";
      type = "gem";
    };
    version = "8.0.3";
  };
  actionmailer = {
    dependencies = ["actionpack" "actionview" "activejob" "activesupport" "mail" "rails-dom-testing"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "08y7ihafq71879ncq963rwi541b0gafqx8h5ba26zab521qc7h3d";
      type = "gem";
    };
    version = "8.0.3";
  };
  actionpack = {
    dependencies = ["actionview" "activesupport" "nokogiri" "rack" "rack-session" "rack-test" "rails-dom-testing" "rails-html-sanitizer" "useragent"];
    groups = ["default" "development" "production" "test"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1lsspr8nffzn8qpfmj654w1qja1915x6bnzzhpbjj1cy235j2g6n";
      type = "gem";
    };
    version = "8.0.3";
  };
  actiontext = {
    dependencies = ["actionpack" "activerecord" "activestorage" "activesupport" "globalid" "nokogiri"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1x4xd8h5sdwdm3rc8h2pxxmq4a0i0wa0gk6c56zq58pzc3xgsihw";
      type = "gem";
    };
    version = "8.0.3";
  };
  actionview = {
    dependencies = ["activesupport" "builder" "erubi" "rails-dom-testing" "rails-html-sanitizer"];
    groups = ["default" "development" "production" "test"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0rnfn44g217n9hgvn4ga7l0hl149b91djnl07nzra7kxy1pr8wai";
      type = "gem";
    };
    version = "8.0.3";
  };
  activejob = {
    dependencies = ["activesupport" "globalid"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1dm1vc5vvk5pwq4x7sfh3g6qzzwbyac37ggh1mm1rzraharxv7j6";
      type = "gem";
    };
    version = "8.0.3";
  };
  activemodel = {
    dependencies = ["activesupport"];
    groups = ["default" "development"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0z565q17fmhj4b9j689r0xx1s26w1xcw8z0qyb6h8v0wb8j0fsa0";
      type = "gem";
    };
    version = "8.0.3";
  };
  activerecord = {
    dependencies = ["activemodel" "activesupport" "timeout"];
    groups = ["default" "development"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1a6fng58lria02wlwiqjgqway0nx1wq31dsxn5xvbk7958xwd5cv";
      type = "gem";
    };
    version = "8.0.3";
  };
  activestorage = {
    dependencies = ["actionpack" "activejob" "activerecord" "activesupport" "marcel"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0plck0b57b9ni8n52hj5slv5n8i7w3nfwq6r47nkb2hjbpmsskjg";
      type = "gem";
    };
    version = "8.0.3";
  };
  activesupport = {
    dependencies = ["base64" "benchmark" "bigdecimal" "concurrent-ruby" "connection_pool" "drb" "i18n" "logger" "minitest" "securerandom" "tzinfo" "uri"];
    groups = ["default" "development" "production" "test"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "08vqq5y6vniz30p747xa8yfqb3cz8scqd8r65wij62v661gcw4d7";
      type = "gem";
    };
    version = "8.0.3";
  };
  addressable = {
    dependencies = ["public_suffix"];
    groups = ["default" "test"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0cl2qpvwiffym62z991ynks7imsm87qmgxf0yfsmlwzkgi9qcaa6";
      type = "gem";
    };
    version = "2.8.7";
  };
  annotaterb = {
    dependencies = ["activerecord" "activesupport"];
    groups = ["development"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "023j5k73hjykjyd8s7s6nqahl52sjfzl0h9z72pc2flv0midylf9";
      type = "gem";
    };
    version = "4.19.0";
  };
  ast = {
    groups = ["default" "development"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "10yknjyn0728gjn6b5syynvrvrwm66bhssbxq8mkhshxghaiailm";
      type = "gem";
    };
    version = "2.4.3";
  };
  base64 = {
    groups = ["default" "development" "production" "test"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0yx9yn47a8lkfcjmigk79fykxvr80r4m1i35q82sxzynpbm7lcr7";
      type = "gem";
    };
    version = "0.3.0";
  };
  bcrypt = {
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "16a0g2q40biv93i1hch3gw8rbmhp77qnnifj1k0a6m7dng3zh444";
      type = "gem";
    };
    version = "3.1.20";
  };
  benchmark = {
    groups = ["default" "development" "production" "test"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1kicilpma5l0lwayqjb5577bm0hbjndj2gh150xz09xsgc1l1vyl";
      type = "gem";
    };
    version = "0.4.1";
  };
  better_html = {
    dependencies = ["actionview" "activesupport" "ast" "erubi" "parser" "smart_properties"];
    groups = ["default" "development"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0mdgwlc02f43svy92p0k5v1hipibpzxcdjm774lkz2j8s58kav04";
      type = "gem";
    };
    version = "2.1.1";
  };
  bigdecimal = {
    groups = ["default" "development" "production" "test"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "06sfv80bmxfczkqi3pb3yc9zicqhf94adh5f8hpkn3bsqqd1vlgz";
      type = "gem";
    };
    version = "3.2.3";
  };
  bindex = {
    groups = ["default" "development"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0zmirr3m02p52bzq4xgksq4pn8j641rx5d4czk68pv9rqnfwq7kv";
      type = "gem";
    };
    version = "0.8.1";
  };
  bootsnap = {
    dependencies = ["msgpack"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "003xl226y120cbq1n99805jw6w75gcz1gs941yz3h7li3qy3kqha";
      type = "gem";
    };
    version = "1.18.6";
  };
  brakeman = {
    dependencies = ["racc"];
    groups = ["development"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1bs8bm3qj2wfy5h1bp8qi1d3vjw5zabhnq5rr288802kbakhiixv";
      type = "gem";
    };
    version = "7.1.0";
  };
  builder = {
    groups = ["default" "development" "production" "test"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0pw3r2lyagsxkm71bf44v5b74f7l9r7di22brbyji9fwz791hya9";
      type = "gem";
    };
    version = "3.3.0";
  };
  capybara = {
    dependencies = ["addressable" "matrix" "mini_mime" "nokogiri" "rack" "rack-test" "regexp_parser" "xpath"];
    groups = ["test"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1vxfah83j6zpw3v5hic0j70h519nvmix2hbszmjwm8cfawhagns2";
      type = "gem";
    };
    version = "3.40.0";
  };
  concurrent-ruby = {
    groups = ["default" "development" "production" "test"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1ipbrgvf0pp6zxdk5ascp6i29aybz2bx9wdrlchjmpx6mhvkwfw1";
      type = "gem";
    };
    version = "1.3.5";
  };
  connection_pool = {
    groups = ["default" "development" "production" "test"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "02p7l47gvchbvnbag6kb4x2hg8n28r25ybslyvrr2q214wir5qg9";
      type = "gem";
    };
    version = "2.5.4";
  };
  crack = {
    dependencies = ["bigdecimal" "rexml"];
    groups = ["default" "test"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0jaa7is4fw1cxigm8vlyhg05bw4nqy4f91zjqxk7pp4c8bdyyfn8";
      type = "gem";
    };
    version = "1.0.0";
  };
  crass = {
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0pfl5c0pyqaparxaqxi6s4gfl21bdldwiawrc0aknyvflli60lfw";
      type = "gem";
    };
    version = "1.0.6";
  };
  date = {
    groups = ["default" "development" "production" "test"];
    platforms = [{
      engine = "maglev";
    } {
      engine = "mingw";
    } {
      engine = "mingw";
    } {
      engine = "ruby";
    }];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0kz6mc4b9m49iaans6cbx031j9y7ldghpi5fzsdh0n3ixwa8w9mz";
      type = "gem";
    };
    version = "3.4.1";
  };
  debug = {
    dependencies = ["irb" "reline"];
    groups = ["development" "test"];
    platforms = [{
      engine = "maglev";
    } {
      engine = "mingw";
    } {
      engine = "mingw";
    } {
      engine = "ruby";
    }];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1wmfy5n5v2rzpr5vz698sqfj1gl596bxrqw44sahq4x0rxjdn98l";
      type = "gem";
    };
    version = "1.11.0";
  };
  docile = {
    groups = ["default" "test"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "07pj4z3h8wk4fgdn6s62vw1lwvhj0ac0x10vfbdkr9xzk7krn5cn";
      type = "gem";
    };
    version = "1.4.1";
  };
  drb = {
    groups = ["default" "development" "production" "test"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0wrkl7yiix268s2md1h6wh91311w95ikd8fy8m5gx589npyxc00b";
      type = "gem";
    };
    version = "2.2.3";
  };
  dry-cli = {
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0nyrgj4a0ppk0qfp8cny4wb3hsr2cw55ynh2w973brhf54xxz5wc";
      type = "gem";
    };
    version = "1.2.0";
  };
  erb = {
    groups = ["default" "development" "production" "test"];
    platforms = [{
      engine = "maglev";
    } {
      engine = "mingw";
    } {
      engine = "mingw";
    } {
      engine = "ruby";
    }];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "03vcq8g8rxdq8njp9j9k9fxwjw19q4m08c7lxjs0yc6l8f0ja3yk";
      type = "gem";
    };
    version = "5.0.2";
  };
  erb_lint = {
    dependencies = ["activesupport" "better_html" "parser" "rainbow" "rubocop" "smart_properties"];
    groups = ["development"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0cbwr8iv6d9g50w12a7ccvcrqk5clz4mxa3cspqd3s1rv05f9dfz";
      type = "gem";
    };
    version = "0.9.0";
  };
  erubi = {
    groups = ["default" "development" "production" "test"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1naaxsqkv5b3vklab5sbb9sdpszrjzlfsbqpy7ncbnw510xi10m0";
      type = "gem";
    };
    version = "1.13.1";
  };
  et-orbi = {
    dependencies = ["tzinfo"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0r6zylqjfv0xhdxvldr0kgmnglm57nm506pcm6085f0xqa68cvnj";
      type = "gem";
    };
    version = "1.2.11";
  };
  factory_bot = {
    dependencies = ["activesupport"];
    groups = ["default" "test"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1gpgcr5dfrq7hs3wafxaqrkx84zm2rlfwbwamd6p1d71mrfjjnff";
      type = "gem";
    };
    version = "6.5.5";
  };
  factory_bot_rails = {
    dependencies = ["factory_bot" "railties"];
    groups = ["test"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0s3dpi8x754bwv4mlasdal8ffiahi4b4ajpccnkaipp4x98lik6k";
      type = "gem";
    };
    version = "6.5.1";
  };
  faker = {
    dependencies = ["i18n"];
    groups = ["test"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0wy4i4vl3h2v6scffx0zbp74vq1gfgq55m8x3n05kwp3na8h5a7r";
      type = "gem";
    };
    version = "3.5.2";
  };
  feedjira = {
    dependencies = ["logger" "loofah" "sax-machine"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0sp8mh9sslab88rd4rkb0p4dcp7z7ir8spz5ij39kr9j8gnbra04";
      type = "gem";
    };
    version = "4.0.1";
  };
  ffi = {
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0fgwn1grxf4zxmyqmb9i4z2hr111585n9jnk17y6y7hhs7dv1xi6";
      type = "gem";
    };
    version = "1.17.1";
  };
  fugit = {
    dependencies = ["et-orbi" "raabro"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0s4qhq3mjl0gak5wl20w9d5jhq069mk1393dkj76s8i2pvkqb578";
      type = "gem";
    };
    version = "1.11.1";
  };
  globalid = {
    dependencies = ["activesupport"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1sbw6b66r7cwdx3jhs46s4lr991969hvigkjpbdl7y3i31qpdgvh";
      type = "gem";
    };
    version = "1.2.1";
  };
  good_job = {
    dependencies = ["activejob" "activerecord" "concurrent-ruby" "fugit" "railties" "thor"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0jmknhzm28fval2pndb9ic2kql2hsc0k9vp337m535pgf3pbbi93";
      type = "gem";
    };
    version = "4.11.2";
  };
  hashdiff = {
    groups = ["default" "test"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0xqsnx25lm1wwgchvrl5xla5zzk3d6gbkdfj062cwggdsvgfwc1c";
      type = "gem";
    };
    version = "1.1.2";
  };
  i18n = {
    dependencies = ["concurrent-ruby"];
    groups = ["default" "development" "production" "test"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "03sx3ahz1v5kbqjwxj48msw3maplpp2iyzs22l4jrzrqh4zmgfnf";
      type = "gem";
    };
    version = "1.14.7";
  };
  image_processing = {
    dependencies = ["mini_magick" "ruby-vips"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1ys28w0ayq3vl2sl4lpq6jnsy7gd4p9vzimyi449hqn2r5lw2k3m";
      type = "gem";
    };
    version = "1.14.0";
  };
  inline_svg = {
    dependencies = ["activesupport" "nokogiri"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "03x1z55sh7cpb63g46cbd6135jmp13idcgqzqsnzinbg4cs2jrav";
      type = "gem";
    };
    version = "1.10.0";
  };
  io-console = {
    groups = ["default" "development" "production" "test"];
    platforms = [{
      engine = "maglev";
    } {
      engine = "mingw";
    } {
      engine = "mingw";
    } {
      engine = "ruby";
    }];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1jszj95hazqqpnrjjzr326nn1j32xmsc9xvd97mbcrrgdc54858y";
      type = "gem";
    };
    version = "0.8.1";
  };
  irb = {
    dependencies = ["pp" "rdoc" "reline"];
    groups = ["default" "development" "production" "test"];
    platforms = [{
      engine = "maglev";
    } {
      engine = "mingw";
    } {
      engine = "mingw";
    } {
      engine = "ruby";
    }];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1fpxa2m83rb7xlzs57daqwnzqjmz6j35xr7zb15s73975sak4br2";
      type = "gem";
    };
    version = "1.15.2";
  };
  json = {
    groups = ["default" "development"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0s5vklcy2fgdxa9c6da34jbfrqq7xs6mryjglqqb5iilshcg3q82";
      type = "gem";
    };
    version = "2.13.2";
  };
  language_server-protocol = {
    groups = ["default" "development"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1k0311vah76kg5m6zr7wmkwyk5p2f9d9hyckjpn3xgr83ajkj7px";
      type = "gem";
    };
    version = "3.17.0.5";
  };
  lint_roller = {
    groups = ["default" "development"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "11yc0d84hsnlvx8cpk4cbj6a4dz9pk0r1k29p0n1fz9acddq831c";
      type = "gem";
    };
    version = "1.1.0";
  };
  logger = {
    groups = ["default" "development" "production" "test"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "00q2zznygpbls8asz5knjvvj2brr3ghmqxgr83xnrdj4rk3xwvhr";
      type = "gem";
    };
    version = "1.7.0";
  };
  loofah = {
    dependencies = ["crass" "nokogiri"];
    groups = ["default" "development" "production" "test"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0dx316q03x6rpdbl610rdaj2vfd5s8fanixk21j4gv3h5f230nk5";
      type = "gem";
    };
    version = "2.24.1";
  };
  mail = {
    dependencies = ["mini_mime" "net-imap" "net-pop" "net-smtp"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1bf9pysw1jfgynv692hhaycfxa8ckay1gjw5hz3madrbrynryfzc";
      type = "gem";
    };
    version = "2.8.1";
  };
  marcel = {
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1vhb1sbzlq42k2pzd9v0w5ws4kjx184y8h4d63296bn57jiwzkzx";
      type = "gem";
    };
    version = "1.1.0";
  };
  matrix = {
    groups = ["default" "test"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1h2cgkpzkh3dd0flnnwfq6f3nl2b1zff9lvqz8xs853ssv5kq23i";
      type = "gem";
    };
    version = "0.4.2";
  };
  mini_magick = {
    dependencies = ["benchmark" "logger"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0zlsc8dj0ak37snw3icag1jk56iq7j5mdayp3rmzinam5hm12mrc";
      type = "gem";
    };
    version = "5.1.2";
  };
  mini_mime = {
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1vycif7pjzkr29mfk4dlqv3disc5dn0va04lkwajlpr1wkibg0c6";
      type = "gem";
    };
    version = "1.1.5";
  };
  mini_portile2 = {
    groups = ["default" "development" "production" "test"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "12f2830x7pq3kj0v8nz0zjvaw02sv01bqs1zwdrc04704kwcgmqc";
      type = "gem";
    };
    version = "2.8.9";
  };
  minitest = {
    groups = ["default" "development" "production" "test"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0mn7q9yzrwinvfvkyjiz548a4rmcwbmz2fn9nyzh4j1snin6q6rr";
      type = "gem";
    };
    version = "5.25.5";
  };
  msgpack = {
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0cnpnbn2yivj9gxkh8mjklbgnpx6nf7b8j2hky01dl0040hy0k76";
      type = "gem";
    };
    version = "1.8.0";
  };
  mutex_m = {
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0l875dw0lk7b2ywa54l0wjcggs94vb7gs8khfw9li75n2sn09jyg";
      type = "gem";
    };
    version = "0.3.0";
  };
  net-imap = {
    dependencies = ["date" "net-protocol"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "01b21pk68kqn93aa0bn980m0s1cbqdzmc1q5l6ilizvb55m20kgq";
      type = "gem";
    };
    version = "0.5.10";
  };
  net-pop = {
    dependencies = ["net-protocol"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1wyz41jd4zpjn0v1xsf9j778qx1vfrl24yc20cpmph8k42c4x2w4";
      type = "gem";
    };
    version = "0.1.2";
  };
  net-protocol = {
    dependencies = ["timeout"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1a32l4x73hz200cm587bc29q8q9az278syw3x6fkc9d1lv5y0wxa";
      type = "gem";
    };
    version = "0.2.2";
  };
  net-smtp = {
    dependencies = ["net-protocol"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0dh7nzjp0fiaqq1jz90nv4nxhc2w359d7c199gmzq965cfps15pd";
      type = "gem";
    };
    version = "0.5.1";
  };
  nio4r = {
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1a9www524fl1ykspznz54i0phfqya4x45hqaz67in9dvw1lfwpfr";
      type = "gem";
    };
    version = "2.7.4";
  };
  nokogiri = {
    dependencies = ["mini_portile2" "racc"];
    groups = ["default" "development" "production" "test"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1hcwwr2h8jnqqxmf8mfb52b0dchr7pm064ingflb78wa00qhgk6m";
      type = "gem";
    };
    version = "1.18.10";
  };
  pagy = {
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0f77pkbkib8jild1wyzrp4wkw0wd3sl65gkqizqmahb87w22wgyv";
      type = "gem";
    };
    version = "9.4.0";
  };
  parallel = {
    groups = ["default" "development"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0c719bfgcszqvk9z47w2p8j2wkz5y35k48ywwas5yxbbh3hm3haa";
      type = "gem";
    };
    version = "1.27.0";
  };
  parser = {
    dependencies = ["ast" "racc"];
    groups = ["default" "development"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1wl7frfk68q6gsf6q6j32jl5m3yc0b9x8ycxz3hy79miaj9r5mll";
      type = "gem";
    };
    version = "3.3.9.0";
  };
  pg = {
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0xf8i58shwvwlka4ld12nxcgqv0d5r1yizsvw74w5jaw83yllqaq";
      type = "gem";
    };
    version = "1.6.2";
  };
  pgreset = {
    groups = ["development"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0cacxbz10v14g8nqpwggzr2azwfhl15j4xv09rar2jsm4w4y2591";
      type = "gem";
    };
    version = "0.4";
  };
  pp = {
    dependencies = ["prettyprint"];
    groups = ["default" "development" "production" "test"];
    platforms = [{
      engine = "maglev";
    } {
      engine = "mingw";
    } {
      engine = "mingw";
    } {
      engine = "ruby";
    }];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1zxnfxjni0r9l2x42fyq0sqpnaf5nakjbap8irgik4kg1h9c6zll";
      type = "gem";
    };
    version = "0.6.2";
  };
  prettyprint = {
    groups = ["default" "development" "production" "test"];
    platforms = [{
      engine = "maglev";
    } {
      engine = "mingw";
    } {
      engine = "mingw";
    } {
      engine = "ruby";
    }];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "14zicq3plqi217w6xahv7b8f7aj5kpxv1j1w98344ix9h5ay3j9b";
      type = "gem";
    };
    version = "0.2.0";
  };
  prism = {
    groups = ["default" "development"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0gkhpdjib9zi9i27vd9djrxiwjia03cijmd6q8yj2q1ix403w3nw";
      type = "gem";
    };
    version = "1.4.0";
  };
  psych = {
    dependencies = ["date" "stringio"];
    groups = ["default" "development" "production" "test"];
    platforms = [{
      engine = "maglev";
    } {
      engine = "mingw";
    } {
      engine = "mingw";
    } {
      engine = "ruby";
    }];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0vii1xc7x81hicdbp7dlllhmbw5w3jy20shj696n0vfbbnm2hhw1";
      type = "gem";
    };
    version = "5.2.6";
  };
  public_suffix = {
    groups = ["default" "test"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0vqcw3iwby3yc6avs1vb3gfd0vcp2v7q310665dvxfswmcf4xm31";
      type = "gem";
    };
    version = "6.0.1";
  };
  puma = {
    dependencies = ["nio4r"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0yjb2m348l5jb9917x4748iz8000pz1pcla1mbp55025s48sximl";
      type = "gem";
    };
    version = "7.0.4";
  };
  pundit = {
    dependencies = ["activesupport"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1ppjk7i1ifz72jv8d93xxzlkccwy4795m4i1df6n6899zaqj2nhg";
      type = "gem";
    };
    version = "2.5.1";
  };
  raabro = {
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "10m8bln9d00dwzjil1k42i5r7l82x25ysbi45fwyv4932zsrzynl";
      type = "gem";
    };
    version = "1.4.0";
  };
  racc = {
    groups = ["default" "development" "production" "test"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0byn0c9nkahsl93y9ln5bysq4j31q8xkf2ws42swighxd4lnjzsa";
      type = "gem";
    };
    version = "1.8.1";
  };
  rack = {
    groups = ["default" "development" "production" "test"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0cwy1br09dh5fklwf5xna7vabns8c1229kr2v0a0s6y2brz3zbrh";
      type = "gem";
    };
    version = "3.2.1";
  };
  rack-mini-profiler = {
    dependencies = ["rack"];
    groups = ["development"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0y1x4rc7bz8x3zn8p6g21rw6ivbjml6a2vl9dhchiy8i6b110n28";
      type = "gem";
    };
    version = "4.0.1";
  };
  rack-proxy = {
    dependencies = ["rack"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "12jw7401j543fj8cc83lmw72d8k6bxvkp9rvbifi88hh01blnsj4";
      type = "gem";
    };
    version = "0.7.7";
  };
  rack-session = {
    dependencies = ["base64" "rack"];
    groups = ["default" "development" "production" "test"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1sg4laz2qmllxh1c5sqlj9n1r7scdn08p3m4b0zmhjvyx9yw0v8b";
      type = "gem";
    };
    version = "2.1.1";
  };
  rack-test = {
    dependencies = ["rack"];
    groups = ["default" "development" "production" "test"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0qy4ylhcfdn65a5mz2hly7g9vl0g13p5a0rmm6sc0sih5ilkcnh0";
      type = "gem";
    };
    version = "2.2.0";
  };
  rackup = {
    dependencies = ["rack"];
    groups = ["default" "development" "production" "test"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "13brkq5xkj6lcdxj3f0k7v28hgrqhqxjlhd4y2vlicy5slgijdzp";
      type = "gem";
    };
    version = "2.2.1";
  };
  rails = {
    dependencies = ["actioncable" "actionmailbox" "actionmailer" "actionpack" "actiontext" "actionview" "activejob" "activemodel" "activerecord" "activestorage" "activesupport" "railties"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0igxnfy4xckvk2b6x17zrwa8xwnkxnpv36ca4wma7bhs5n1c10sx";
      type = "gem";
    };
    version = "8.0.3";
  };
  rails-dom-testing = {
    dependencies = ["activesupport" "minitest" "nokogiri"];
    groups = ["default" "development" "production" "test"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "07awj8bp7jib54d0khqw391ryw8nphvqgw4bb12cl4drlx9pkk4a";
      type = "gem";
    };
    version = "2.3.0";
  };
  rails-html-sanitizer = {
    dependencies = ["loofah" "nokogiri"];
    groups = ["default" "development" "production" "test"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0q55i6mpad20m2x1lg5pkqfpbmmapk0sjsrvr1sqgnj2hb5f5z1m";
      type = "gem";
    };
    version = "1.6.2";
  };
  railties = {
    dependencies = ["actionpack" "activesupport" "irb" "rackup" "rake" "thor" "tsort" "zeitwerk"];
    groups = ["default" "development" "production" "test"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1lpiazaaq8di4lz9iqjqdrsnha6kfq6k35kd9nk9jhhksz51vqxc";
      type = "gem";
    };
    version = "8.0.3";
  };
  rainbow = {
    groups = ["default" "development"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0smwg4mii0fm38pyb5fddbmrdpifwv22zv3d3px2xx497am93503";
      type = "gem";
    };
    version = "3.1.1";
  };
  rake = {
    groups = ["default" "development" "production" "test"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "14s4jdcs1a4saam9qmzbsa2bsh85rj9zfxny5z315x3gg0nhkxcn";
      type = "gem";
    };
    version = "13.3.0";
  };
  rbs = {
    dependencies = ["logger"];
    groups = ["default" "development"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1mx533jn2nv29xc5faw9g5xj9qbdaiwl9wv2byv98bgw6gqwhhlf";
      type = "gem";
    };
    version = "3.9.4";
  };
  rdoc = {
    dependencies = ["erb" "psych"];
    groups = ["default" "development" "production" "test"];
    platforms = [{
      engine = "maglev";
    } {
      engine = "mingw";
    } {
      engine = "mingw";
    } {
      engine = "ruby";
    }];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "09lj8d16wx5byj0nbcb9wc6v9farsvgn98n91kknm18g2ggl9pcz";
      type = "gem";
    };
    version = "6.14.2";
  };
  regexp_parser = {
    groups = ["default" "development" "test"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "167zy35y4sasqx7wdpv757vigxl1znphfa0xmd9xxn7zhla9qpjy";
      type = "gem";
    };
    version = "2.11.2";
  };
  reline = {
    dependencies = ["io-console"];
    groups = ["default" "development" "production" "test"];
    platforms = [{
      engine = "maglev";
    } {
      engine = "mingw";
    } {
      engine = "mingw";
    } {
      engine = "ruby";
    }];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0ii8l0q5zkang3lxqlsamzfz5ja7jc8ln905isfdawl802k2db8x";
      type = "gem";
    };
    version = "0.6.2";
  };
  rexml = {
    groups = ["default" "test"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "05y4lwzci16c2xgckmpxkzq4czgkyaiiqhvrabdgaym3aj2jd10k";
      type = "gem";
    };
    version = "3.4.2";
  };
  rubocop = {
    dependencies = ["json" "language_server-protocol" "lint_roller" "parallel" "parser" "rainbow" "regexp_parser" "rubocop-ast" "ruby-progressbar" "unicode-display_width"];
    groups = ["development"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1x5bv4yrm02ma8qy5127arz3zx0y7cjmw7mrnffijp6gxw7z71b4";
      type = "gem";
    };
    version = "1.80.2";
  };
  rubocop-ast = {
    dependencies = ["parser" "prism"];
    groups = ["default" "development"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0ar3y8w36am483ynyzg0x8iwhn8h34y8f4agny4lyqcqbfnzd9qd";
      type = "gem";
    };
    version = "1.46.0";
  };
  rubocop-minitest = {
    dependencies = ["lint_roller" "rubocop" "rubocop-ast"];
    groups = ["development"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0s00533085a2zzqyscqjz26vp61rgmimj7m539hd0ww9addgp7as";
      type = "gem";
    };
    version = "0.38.2";
  };
  rubocop-performance = {
    dependencies = ["lint_roller" "rubocop" "rubocop-ast"];
    groups = ["development"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1a8wyz72iwz499nd48q9jns3mjcxrzbnsncsdyzj589fzgcxkc3v";
      type = "gem";
    };
    version = "1.26.0";
  };
  rubocop-rails = {
    dependencies = ["activesupport" "lint_roller" "rack" "rubocop" "rubocop-ast"];
    groups = ["development"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0jzpkb3vx2w8mg25gg18rvxzqvxziaqrwv14cqq2yaf1b0dh3344";
      type = "gem";
    };
    version = "2.33.3";
  };
  ruby-lsp = {
    dependencies = ["language_server-protocol" "prism" "rbs"];
    groups = ["development"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "050qg73g4qs3xza441nafy7610daa3k4ra0pbi3sdlawy9fwfh6i";
      type = "gem";
    };
    version = "0.26.1";
  };
  ruby-lsp-rails = {
    dependencies = ["ruby-lsp"];
    groups = ["development"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1bj4bj35l9jas2yf6w93j5ngw3f24lck2j9h5zmxwqs0dn91z7gh";
      type = "gem";
    };
    version = "0.4.8";
  };
  ruby-progressbar = {
    groups = ["default" "development"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0cwvyb7j47m7wihpfaq7rc47zwwx9k4v7iqd9s1xch5nm53rrz40";
      type = "gem";
    };
    version = "1.13.0";
  };
  ruby-vips = {
    dependencies = ["ffi" "logger"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "14nwdsd73c4ygjb7sfldnndlbzn5yyl02llnlzafmmjwh0d2pla1";
      type = "gem";
    };
    version = "2.2.3";
  };
  rubyzip = {
    groups = ["default" "test"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "19xqyp8ixshf9mv0vy3d5qsi6acffh7849i6rrba3f9xz4pz7fwb";
      type = "gem";
    };
    version = "3.0.1";
  };
  sax-machine = {
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0fhdflwdj8q0gfgz51k3zn1giq24fwvhvji75104rsly0dw2c4d1";
      type = "gem";
    };
    version = "1.3.2";
  };
  securerandom = {
    groups = ["default" "development" "production" "test"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1cd0iriqfsf1z91qg271sm88xjnfd92b832z49p1nd542ka96lfc";
      type = "gem";
    };
    version = "0.4.1";
  };
  selenium-webdriver = {
    dependencies = ["base64" "logger" "rexml" "rubyzip" "websocket"];
    groups = ["test"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "16rmdnc8c779gmphv7n4rcx8bc6yv24i555lzqx2drmrqk721jbg";
      type = "gem";
    };
    version = "4.35.0";
  };
  sentry-rails = {
    dependencies = ["railties" "sentry-ruby"];
    groups = ["production"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1v7mgva4pnm7pxb14rfm8gaq2ydd5j8a07lvhv1x31gi7xrpkxbp";
      type = "gem";
    };
    version = "5.27.1";
  };
  sentry-ruby = {
    dependencies = ["bigdecimal" "concurrent-ruby"];
    groups = ["production"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0rw3fq5r6lvi4bwmsh8gvj4ss59f82cnk88p959q5f731rwyn265";
      type = "gem";
    };
    version = "5.27.1";
  };
  simplecov = {
    dependencies = ["docile" "simplecov-html" "simplecov_json_formatter"];
    groups = ["test"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "198kcbrjxhhzca19yrdcd6jjj9sb51aaic3b0sc3pwjghg3j49py";
      type = "gem";
    };
    version = "0.22.0";
  };
  simplecov-cobertura = {
    dependencies = ["rexml" "simplecov"];
    groups = ["test"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1iaxj8lfcl5cfr4qa64mcapqw4qprf4bvrdjfhhwlrf96am3hzvd";
      type = "gem";
    };
    version = "3.1.0";
  };
  simplecov-html = {
    groups = ["default" "test"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0ikjfwydgs08nm3xzc4cn4b6z6rmcrj2imp84xcnimy2wxa8w2xx";
      type = "gem";
    };
    version = "0.13.2";
  };
  simplecov_json_formatter = {
    groups = ["default" "test"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0a5l0733hj7sk51j81ykfmlk2vd5vaijlq9d5fn165yyx3xii52j";
      type = "gem";
    };
    version = "0.1.4";
  };
  smart_properties = {
    groups = ["default" "development"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0jrqssk9qhwrpq41arm712226vpcr458xv6xaqbk8cp94a0kycpr";
      type = "gem";
    };
    version = "1.17.0";
  };
  stringio = {
    groups = ["default" "development" "production" "test"];
    platforms = [{
      engine = "maglev";
    } {
      engine = "mingw";
    } {
      engine = "mingw";
    } {
      engine = "ruby";
    }];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1yh78pg6lm28c3k0pfd2ipskii1fsraq46m6zjs5yc9a4k5vfy2v";
      type = "gem";
    };
    version = "3.1.7";
  };
  thor = {
    groups = ["default" "development" "production" "test"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0gcarlmpfbmqnjvwfz44gdjhcmm634di7plcx2zdgwdhrhifhqw7";
      type = "gem";
    };
    version = "1.4.0";
  };
  timeout = {
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "03p31w5ghqfsbz5mcjzvwgkw3h9lbvbknqvrdliy8pxmn9wz02cm";
      type = "gem";
    };
    version = "0.4.3";
  };
  tsort = {
    groups = ["default" "development" "production" "test"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "17q8h020dw73wjmql50lqw5ddsngg67jfw8ncjv476l5ys9sfl4n";
      type = "gem";
    };
    version = "0.2.0";
  };
  turbo-rails = {
    dependencies = ["actionpack" "activejob" "railties"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0gm8qzkhnpryqwmddh8kasgjdgghm58ifgwvf9vh555h5xvcq9ml";
      type = "gem";
    };
    version = "1.5.0";
  };
  tzinfo = {
    dependencies = ["concurrent-ruby"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "16w2g84dzaf3z13gxyzlzbf748kylk5bdgg3n1ipvkvvqy685bwd";
      type = "gem";
    };
    version = "2.0.6";
  };
  unicode-display_width = {
    dependencies = ["unicode-emoji"];
    groups = ["default" "development"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0knx0bgwwpwa7wcmknqp2i019jq6b46wxfppvhxfxrsyhlbnhmmz";
      type = "gem";
    };
    version = "3.1.5";
  };
  unicode-emoji = {
    groups = ["default" "development"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0ajk6rngypm3chvl6r0vwv36q1931fjqaqhjjya81rakygvlwb1c";
      type = "gem";
    };
    version = "4.0.4";
  };
  uri = {
    groups = ["default" "development" "production" "test"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "04bhfvc25b07jaiaf62yrach7khhr5jlr5bx6nygg8pf11329wp9";
      type = "gem";
    };
    version = "1.0.3";
  };
  useragent = {
    groups = ["default" "development" "production" "test"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0i1q2xdjam4d7gwwc35lfnz0wyyzvnca0zslcfxm9fabml9n83kh";
      type = "gem";
    };
    version = "0.16.11";
  };
  view_component = {
    dependencies = ["activesupport" "concurrent-ruby"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0rcziqg03xfbxwr0akzh78p1l1wdfjl22j7a58awzx4gry74msw0";
      type = "gem";
    };
    version = "4.0.2";
  };
  vite_rails = {
    dependencies = ["railties" "vite_ruby"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "005mbcprdhjqx27561mb54kssjwxwij157x6wya1yp60gdkl8p0r";
      type = "gem";
    };
    version = "3.0.19";
  };
  vite_ruby = {
    dependencies = ["dry-cli" "logger" "mutex_m" "rack-proxy" "zeitwerk"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0wj9ia0s7vywn66pf2jn49pfsy5h5rncjjwhaymwq32r3f2pq2p1";
      type = "gem";
    };
    version = "3.9.2";
  };
  web-console = {
    dependencies = ["actionview" "activemodel" "bindex" "railties"];
    groups = ["development"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "087y4byl2s3fg0nfhix4s0r25cv1wk7d2j8n5324waza21xg7g77";
      type = "gem";
    };
    version = "4.2.1";
  };
  webmock = {
    dependencies = ["addressable" "crack" "hashdiff"];
    groups = ["test"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "08v374yrqqhjj3xjzmvwnv3yz21r22kn071yr0i67gmwaf9mv7db";
      type = "gem";
    };
    version = "3.25.1";
  };
  websocket = {
    groups = ["default" "test"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0dr78vh3ag0d1q5gfd8960g1ca9g6arjd2w54mffid8h4i7agrxp";
      type = "gem";
    };
    version = "1.2.11";
  };
  websocket-driver = {
    dependencies = ["base64" "websocket-extensions"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0qj9dmkmgahmadgh88kydb7cv15w13l1fj3kk9zz28iwji5vl3gd";
      type = "gem";
    };
    version = "0.8.0";
  };
  websocket-extensions = {
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0hc2g9qps8lmhibl5baa91b4qx8wqw872rgwagml78ydj8qacsqw";
      type = "gem";
    };
    version = "0.1.5";
  };
  xpath = {
    dependencies = ["nokogiri"];
    groups = ["default" "test"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0bh8lk9hvlpn7vmi6h4hkcwjzvs2y0cmkk3yjjdr8fxvj6fsgzbd";
      type = "gem";
    };
    version = "3.2.0";
  };
  zeitwerk = {
    groups = ["default" "development" "production" "test"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "119ypabas886gd0n9kiid3q41w76gz60s8qmiak6pljpkd56ps5j";
      type = "gem";
    };
    version = "2.7.3";
  };
}
