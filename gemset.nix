{
  actioncable = {
    dependencies = ["actionpack" "activesupport" "nio4r" "websocket-driver" "zeitwerk"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "18496axh89kakw5f82mmmac3w9rwb0b0wq4j6la806p9cbgy5k3v";
      type = "gem";
    };
    version = "8.0.2";
  };
  actionmailbox = {
    dependencies = ["actionpack" "activejob" "activerecord" "activestorage" "activesupport" "mail"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1nyfwa1kj0cm1scqsbv723ypv69bzaxh886hliyjbrhk752v73rx";
      type = "gem";
    };
    version = "8.0.2";
  };
  actionmailer = {
    dependencies = ["actionpack" "actionview" "activejob" "activesupport" "mail" "rails-dom-testing"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1l3pnba14p0p7zsh366c31maxap030c97597vjimdv3nhnrnijdh";
      type = "gem";
    };
    version = "8.0.2";
  };
  actionpack = {
    dependencies = ["actionview" "activesupport" "nokogiri" "rack" "rack-session" "rack-test" "rails-dom-testing" "rails-html-sanitizer" "useragent"];
    groups = ["default" "development" "production" "test"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0y2b5ydiqy32jbd9g5bl6v4aw6d7pjn5f3w2rxf2j59q9w307rwk";
      type = "gem";
    };
    version = "8.0.2";
  };
  actiontext = {
    dependencies = ["actionpack" "activerecord" "activestorage" "activesupport" "globalid" "nokogiri"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1grs41yr3nzw7zbnz0vkv8f4qd448a632saxkm3vnbzf68hb63d4";
      type = "gem";
    };
    version = "8.0.2";
  };
  actionview = {
    dependencies = ["activesupport" "builder" "erubi" "rails-dom-testing" "rails-html-sanitizer"];
    groups = ["default" "development" "production" "test"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1fyfyxf2a798lxq6sfpnj94kmnpfp17xlhvjy428zhfzbi0f2f70";
      type = "gem";
    };
    version = "8.0.2";
  };
  activejob = {
    dependencies = ["activesupport" "globalid"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1jjk31di5kvcflc90wmgdd50jzhljhafi166h6hg67kbwd2qn8mh";
      type = "gem";
    };
    version = "8.0.2";
  };
  activemodel = {
    dependencies = ["activesupport"];
    groups = ["default" "development"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0v35y2jzqlfy1wnrzlzj2cxylhnz09vykaa1l2dnkq7sl5zzpq8a";
      type = "gem";
    };
    version = "8.0.2";
  };
  activerecord = {
    dependencies = ["activemodel" "activesupport" "timeout"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "02nrya34qviawdkssyahb3mg08kqdc461b320a6ikr245jwp0d3r";
      type = "gem";
    };
    version = "8.0.2";
  };
  activestorage = {
    dependencies = ["actionpack" "activejob" "activerecord" "activesupport" "marcel"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0xr9cy6h8il61qq6w3rkvl56visms45ljm8f43r3ibh61wg24ggq";
      type = "gem";
    };
    version = "8.0.2";
  };
  activesupport = {
    dependencies = ["base64" "benchmark" "bigdecimal" "concurrent-ruby" "connection_pool" "drb" "i18n" "logger" "minitest" "securerandom" "tzinfo" "uri"];
    groups = ["default" "development" "production" "test"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0pm40y64wfc50a9sj87kxvil2102rmpdcbv82zf0r40vlgdwsrc5";
      type = "gem";
    };
    version = "8.0.2";
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
      sha256 = "0g6ahzpdbybryzlfrbb18pybr4230hw1n6g475hh61mk4nlqgl1y";
      type = "gem";
    };
    version = "4.16.0";
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
      sha256 = "1p2szbr4jdvmwaaj2kxlbv1rp0m6ycbgfyp0kjkkkswmniv5y21r";
      type = "gem";
    };
    version = "3.2.2";
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
      sha256 = "11ip6dgi7147wp8jgwk9g95k07323zh83q699d6wxif6rqdxj0mn";
      type = "gem";
    };
    version = "7.0.2";
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
      sha256 = "0nrhsk7b3sjqbyl1cah6ibf1kvi3v93a7wf4637d355hp614mmyg";
      type = "gem";
    };
    version = "2.5.3";
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
      sha256 = "1lxqxgq71rqwj1lpl9q1mbhhhhhhdkkj7my341f2889pwayk85sz";
      type = "gem";
    };
    version = "1.4.0";
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
      sha256 = "08rc8pzri3g7c85c76x84j05hkk12jvalrm2m3n97k1n7f03j13n";
      type = "gem";
    };
    version = "5.0.1";
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
      sha256 = "04z6zkfxasddw2bq1whyzzj45hxzhw2lcsdhzrqlvhd7h1yzn1s7";
      type = "gem";
    };
    version = "6.5.4";
  };
  factory_bot_rails = {
    dependencies = ["factory_bot" "railties"];
    groups = ["test"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "18n06y5ww7d08w296b6fpzx05yywp5r8p88j0k37r994aiin2ysa";
      type = "gem";
    };
    version = "6.5.0";
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
    dependencies = ["loofah" "sax-machine"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1prrqmj2q9nbmvcwl16wd0727bnx08pb2fkw3v12z877df36wn9y";
      type = "gem";
    };
    version = "3.2.5";
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
      sha256 = "0f0gczqrqwbrk5y5qvvv25g96ljvwxn41qhirz46rzmqpzq1cyff";
      type = "gem";
    };
    version = "4.11.1";
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
      sha256 = "18pgvl7lfjpichdfh1g50rpz0zpaqrpr52ybn9liv1v9pjn9ysnd";
      type = "gem";
    };
    version = "0.8.0";
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
      sha256 = "1x5b8ipv6g0z44wgc45039k04smsyf95h2m5m67mqq35sa5a955s";
      type = "gem";
    };
    version = "2.12.2";
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
      sha256 = "190n2mk8m1l708kr88fh6mip9sdsh339d2s6sgrik3sbnvz4jmhd";
      type = "gem";
    };
    version = "1.0.4";
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
  method_source = {
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1igmc3sq9ay90f8xjvfnswd1dybj1s3fi0dwd53inwsvqk4h24qq";
      type = "gem";
    };
    version = "1.1.0";
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
      sha256 = "1rgva7p9gvns2ndnqpw503mbd36i2skkggv0c0h192k8xr481phy";
      type = "gem";
    };
    version = "0.5.6";
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
      sha256 = "0rb306hbky6cxfyc8vrwpvl40fdapjvhsk62h08gg9wwbn3n8x4c";
      type = "gem";
    };
    version = "1.18.8";
  };
  pagy = {
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1mqgiwzjkj8b54146yj15jds53l1pfawvc9a14n8fvxra0qm3abq";
      type = "gem";
    };
    version = "9.3.5";
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
      sha256 = "0i9w8msil4snx5w11ix9b0wf52vjc3r49khy3ddgl1xk890kcxi4";
      type = "gem";
    };
    version = "3.3.8.0";
  };
  pg = {
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1p2gqqrm895fzr9vi8d118zhql67bm8ydjvgqbq1crdnfggzn7kn";
      type = "gem";
    };
    version = "1.5.9";
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
      sha256 = "11xd3207k5rl6bz0qxhcb3zcr941rhx7ig2f19gxxmdk7s3hcp7j";
      type = "gem";
    };
    version = "6.6.0";
  };
  pundit = {
    dependencies = ["activesupport"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1nmy0nkgayjifi2j38fn55nb7z1xq3ma2wp19d7c7rmz7ynvidjg";
      type = "gem";
    };
    version = "2.5.0";
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
      sha256 = "0da64fq3w671qhp7ji1zs84m5lyhalq4khqhbfw5dz0y6mn61dgg";
      type = "gem";
    };
    version = "3.1.16";
  };
  rack-mini-profiler = {
    dependencies = ["rack"];
    groups = ["development"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "03z02blb8q1c8fiwn249rnvmvrw655s4x36xmpa3mqq1gp5ysyy3";
      type = "gem";
    };
    version = "4.0.0";
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
      sha256 = "1ik4y7c545pb9lf70prv0n4drblwjlaxb22fhq18wf607slabypx";
      type = "gem";
    };
    version = "8.0.2";
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
    dependencies = ["actionpack" "activesupport" "irb" "rackup" "rake" "thor" "zeitwerk"];
    groups = ["default" "development" "production" "test"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1yaw5sw9vxvvkkc335laxv2k34rs2nxx9hdsy604k9wvqi03yz0d";
      type = "gem";
    };
    version = "8.0.2";
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
      sha256 = "0ssi6b33bwr1b1qsssnyjkldwwy087z33yzl58jyz5njdiwzlplh";
      type = "gem";
    };
    version = "6.14.1";
  };
  regexp_parser = {
    groups = ["default" "development" "test"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0qccah61pjvzyyg6mrp27w27dlv6vxlbznzipxjcswl7x3fhsvyb";
      type = "gem";
    };
    version = "2.10.0";
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
      sha256 = "1yvm0svcdk6377ng6l00g39ldkjijbqg4whdg2zcsa8hrgbwkz0s";
      type = "gem";
    };
    version = "0.6.1";
  };
  rexml = {
    groups = ["default" "test"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1jmbf6lf7pcyacpb939xjjpn1f84c3nw83dy3p1lwjx0l2ljfif7";
      type = "gem";
    };
    version = "3.4.1";
  };
  rubocop = {
    dependencies = ["json" "language_server-protocol" "lint_roller" "parallel" "parser" "rainbow" "regexp_parser" "rubocop-ast" "ruby-progressbar" "unicode-display_width"];
    groups = ["development"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1h48rhmp178ppzc4ybfj42a2savs4bxgy3bvw95i4ypgfm2hndhz";
      type = "gem";
    };
    version = "1.77.0";
  };
  rubocop-ast = {
    dependencies = ["parser" "prism"];
    groups = ["default" "development"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0gis8w51k5dsmzzlppvwwznqyfd73fa3zcrpl1xihzy1mm4jw14l";
      type = "gem";
    };
    version = "1.45.1";
  };
  rubocop-minitest = {
    dependencies = ["lint_roller" "rubocop" "rubocop-ast"];
    groups = ["development"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "10bspwnz1bn2n0hvfgydjymw20xdfb4dxx8qp1b1anyl8f0am5zr";
      type = "gem";
    };
    version = "0.38.1";
  };
  rubocop-performance = {
    dependencies = ["lint_roller" "rubocop" "rubocop-ast"];
    groups = ["development"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1h9flnqk2f3llwf8g0mk0fvzzznfj7hsil3qg88m803pi9b06zbg";
      type = "gem";
    };
    version = "1.25.0";
  };
  rubocop-rails = {
    dependencies = ["activesupport" "lint_roller" "rack" "rubocop" "rubocop-ast"];
    groups = ["development"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1404nfa0gw3p0xzmv4b9zg9v1da0nwc4m7796pl73zi2hwy65k4z";
      type = "gem";
    };
    version = "2.32.0";
  };
  ruby-lsp = {
    dependencies = ["language_server-protocol" "prism" "rbs"];
    groups = ["development"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0fpk4fi0pbakdxl6hj4p43i3glvigp2i0jqsgcgl59hnlmz2aazd";
      type = "gem";
    };
    version = "0.25.0";
  };
  ruby-lsp-rails = {
    dependencies = ["ruby-lsp"];
    groups = ["development"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "075ib75jgg629s4i84jnx3miwzpi1dlj23qgjwawzwxapvgsnhyb";
      type = "gem";
    };
    version = "0.4.7";
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
      sha256 = "05an0wz87vkmqwcwyh5rjiaavydfn5f4q1lixcsqkphzvj7chxw5";
      type = "gem";
    };
    version = "2.4.1";
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
      sha256 = "07i7ifp8vpgsn9y9smvndnbx1bkcl9mmxjnq8yrf4vz6rccbfyzc";
      type = "gem";
    };
    version = "4.34.0";
  };
  sentry-rails = {
    dependencies = ["railties" "sentry-ruby"];
    groups = ["production"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "133195jdyn3slgqybj66ig4v8fn3ms6xr60chi02lwlzxinijkdf";
      type = "gem";
    };
    version = "5.26.0";
  };
  sentry-ruby = {
    dependencies = ["bigdecimal" "concurrent-ruby"];
    groups = ["production"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0jsmjh46kpqfvysl5hp9iynxiq4pcvp6f26vrdr72gv89542vf1p";
      type = "gem";
    };
    version = "5.26.0";
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
      sha256 = "00izmp202y48qvmvwrh5x56cc5ivbjhgkkkjklvqmqzj9pik4r9c";
      type = "gem";
    };
    version = "2.1.0";
  };
  simplecov-html = {
    groups = ["default" "test"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0yx01bxa8pbf9ip4hagqkp5m0mqfnwnw2xk8kjraiywz4lrss6jb";
      type = "gem";
    };
    version = "0.12.3";
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
      sha256 = "1nmymd86a0vb39pzj2cwv57avdrl6pl3lf5bsz58q594kqxjkw7f";
      type = "gem";
    };
    version = "1.3.2";
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
      sha256 = "1has87asspm6m9wgqas8ghhhwyf2i1yqrqgrkv47xw7jq3qjmbwc";
      type = "gem";
    };
    version = "3.1.4";
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
    dependencies = ["activesupport" "concurrent-ruby" "method_source"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0aw962shs2x52dy1vhzkw1qc0b5vxmgaab6lld7hggrqkr5ysbrw";
      type = "gem";
    };
    version = "3.23.2";
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
      sha256 = "1d26l4qn55ivzahbc7fwc4k4z3j7wzym05i9n77i4mslrpr9jv85";
      type = "gem";
    };
    version = "0.7.7";
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
