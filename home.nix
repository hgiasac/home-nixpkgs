{ pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;
  
  # imports = [
  #  ./emacs
  # ];
  home.packages = [
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

    firefox = {
      enable = true;
      enableAdobeFlash = true;
      enableGoogleTalk = true;
    };

    home-manager = {
      enable = true;
      path = "…";
    };

    termite = {
      enable = true;
      font = "Noto Sans Mono 12";
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
        "editor.tabSize" = 2;

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
     ];
   };
  

  }; 
} 
