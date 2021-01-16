{ pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowBroken = true;
  nixpkgs.config.allowUnsupportedSystem = true; 
  nixpkgs.config.permittedInsecurePackages = [
    "p7zip-16.02"
  ];
  nixpkgs.overlays = [
    (import (builtins.fetchTarball {
      url = https://github.com/nubank/nixpkgs/archive/master.tar.gz;
    }))
  ];
  # imports = [
  #  ./emacs
  # ];
  home.packages = with pkgs; [
    pkgs.zip
    pkgs.atom
    pkgs.slack
    pkgs.discord
    pkgs.thunderbird
    pkgs.skypeforlinux
    pkgs.google-cloud-sdk
    pkgs.unetbootin
    pkgs.spectacle
    pkgs.glxinfo
    pkgs.jmeter   
    pkgs.libpng
    pkgs.android-studio
    pkgs.mongodb-tools
    pkgs.vokoscreen
    pkgs.vlc
    pkgs.awscli
    pkgs.openssl
    pkgs.libreoffice
    # pkgs.notable
    pkgs.postman
    pkgs.bridge-utils
    pkgs.upx
    pkgs.telnet
    pkgs.circleci-cli
    pkgs.lm_sensors
    pkgs.openvpn
    pkgs.x2goclient
    pkgs.freerdp
    pkgs.yarn
    pkgs.nomacs
    pkgs.purescript
    pkgs.spago
    pkgs.gox
    pkgs.qt5.qttools
    pkgs.protobuf
    pkgs.nixnote2
    
    # nubank.flutter
    # nubank.dart
    # nubank.hover
    pkgs.cocoapods
    pkgs.gradle
    pkgs.lua
    pkgs.luaPackages.luacheck
    pkgs.terraform
    pkgs.skaffold
    pkgs.kustomize
  ];

  services.gpg-agent = {
    enable = true;
    defaultCacheTtl = 1800;
    enableSshSupport = true;
  };
  
  programs = {
    chromium = {
      enable = true;
    };

    google-chrome = {
      enable = true;
    };

    # firefox = {
    #   enable = true;
    #   # enableAdobeFlash = true;
    # };

    home-manager = {
      enable = true;
      path = "…";
    };

    termite = {
      enable = true;
      font = "Hasklig 13";
      allowBold = true;
      mouseAutohide = true;
      scrollOnKeystroke = true;
      dynamicTitle = true;
      urgentOnBell = true;
      clickableUrl = true;

      scrollbackLines = 1000;
      searchWrap = true;
      cursorColor = "#d8dee9";
      cursorForegroundColor = "#2e3440";
      cursorBlink = "system";
      cursorShape = "block";

      foregroundColor = "#d8dee9";
      foregroundBoldColor = "#d8dee9";
      backgroundColor = "#2e3440";
      # highlightColor = "#4c566a";
      colorsExtra = ''
        color0  = #3b4252
        color1  = #bf616a
        color2  = #a3be8c
        color3  = #ebcb8b
        color4  = #81a1c1
        color5  = #b48ead
        color6  = #88c0d0
        color7  = #e5e9f0
        color8  = #4c566a
        color9  = #bf616a
        color10 = #a3be8c
        color11 = #ebcb8b
        color12 = #81a1c1
        color13 = #b48ead
        color14 = #8fbcbb
        color15 = #eceff4
        '';

    };
    
    vscode = {
      enable = true;
      extensions = [
      ];

      userSettings = {
        "eslint.autoFixOnSave" = true;
        "yaml.format.enable" = true;
        # "yaml.schemas" = {
        #   "Kubernetes" = "*.yaml";
        # };

        # "python.linting.pylintPath" = "/run/current-system/sw/bin/pylint";
        "editor.codeActionsOnSave" = {
          "source.fixAll.tslint" = true;
          "source.fixAll.eslint" = true;
          "source.fixAll.stylelint" = true;
        };

        "editor.fontSize" = 15;
        "editor.tabSize" = 2;
        "files.insertFinalNewline" = true;
        "files.trimFinalNewlines" = true;
        "files.associations" = {
          "*.tfvars" = "terraform";
          "*.tf" = "terraform";
        };
        "go.useLanguageServer" = true;
        "go.gopath" = "/go";
        "go.toolsEnvVars" = {
          "GO111MODULE" = "auto";
        };
        "go.testFlags" = ["-v"];

        "python.venvPath" = "/data/projects/pyenv";
        "[python]" = {
          "editor.tabSize" = 4;
        };
        "[terraform]" = {
          "editor.formatOnSave" = true;
        };
        "prettier-eslint.eslintIntegration" = true;
        "stylishHaskell.commandLine" =  "/home/hgiasac/.nix-profile/bin/stylish-haskell";
        "editor.rulers" = [80 120];
        "update.mode" = "none"; 
        "python.linting.pylintPath" = "/run/current-system/sw/bin/pylint";
        
        "reason.path.bsb" = "./node_modules/bs-platform/lib/bsb.linux";
        
        "purescript.pursExe" = "/home/hgiasac/.nix-profile/bin/purs";
        "purescript.addSpagoSources" = true;
        "purescript.addNpmPath" = true;
        "purescript.buildCommand" = "spago build --purs-args --json-errors";
        "css.validate" = false;
        "less.validate" = false;
        "scss.validate" = false;  
        "editor.fontFamily" = "Hasklig, 'Droid Sans Mono', monospace, 'Droid Sans Fallback'";
        "lua.targetVersion" = "5.2";
        "lua.luacheckPath" = "/home/hgiasac/.nix-profile/bin/luacheck";

        
      };
    };

    emacs = {
      enable = true;
      extraPackages = epkgs: [

        # there's a bug in the current source of evil-escape that causes it to
        # fail to build. We'll patch it out for now and hope it gets fixed in a
        # future version.
        (epkgs.evil-escape.overrideAttrs (attrs: {
          patches = (attrs.patches or []) ++ [
            (pkgs.fetchpatch {
              url = https://github.com/BrianHicks/evil-escape/commit/b548e8450570a0c8dea47b47221b728c047a9baf.patch;
              sha256 = "1a2qrf4bpj7wm84qa3haqdg3pd9d8nh5vrj8v1sc0j1a9jifsbf6";
            })
          ];
        }))
        epkgs.avy # jump to word
        epkgs.magit
        epkgs.ivy # I think the M-x thing
        epkgs.counsel # seach?
        epkgs.swiper # other search?
        epkgs.which-key # space menu
        epkgs.ranger # nav file system
        epkgs.undo-tree   
        epkgs.rainbow-delimiters
        epkgs.aggressive-indent

        epkgs.company # completion
        epkgs.company-nginx
        epkgs.company-quickhelp
        epkgs.company-shell
        epkgs.flycheck # squegely lines??
        epkgs.powerline # beter status bar (col count, cur line)
        epkgs.nix-mode
        epkgs.yaml-mode
        epkgs.markdown-mode
        epkgs.rjsx-mode # better js
        epkgs.flx # fuzzy matching
        epkgs.counsel-projectile
        epkgs.fill-column-indicator # 80 char
        epkgs.haskell-mode
        epkgs.paradox
        epkgs.general # keybindings
        epkgs.monokai-theme
        epkgs.use-package # lazy package loading TODO downgrade to stable (custom wan't there)
        epkgs.format-all
        epkgs.dante
        epkgs.evil
        epkgs.evil-collection
        epkgs.evil-commentary
        epkgs.evil-goggles
        epkgs.evil-lion
        epkgs.evil-magit
        epkgs.evil-smartparens
        epkgs.evil-surround
        epkgs.typescript-mode

        epkgs.nginx-mode
        epkgs.dockerfile-mode
        epkgs.exec-path-from-shell     
        epkgs.intero
        epkgs.ace-window
     ];
   };
  

 };

 # Using Bluetooth headset buttons to control media player
# systemd.user.services.mpris-proxy = {
#    Unit.Description = "Mpris proxy";
#    Unit.After = [ "network.target" "sound.target" ];
#    Service.ExecStart = "${pkgs.bluez}/bin/mpris-proxy";
#    Install.WantedBy = [ "default.target" ];
#  };
} 
