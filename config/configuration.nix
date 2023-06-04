{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    <home-manager/nixos>
  ];

  boot = {
    kernelPackages = pkgs.linuxPackages_zen;
    kernelParams = [ "quiet" ];
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };

  networking.hostName = "askarbink-pcl";

  networking.networkmanager.enable = true;

  time.timeZone = "Asia/Yekaterinburg";

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkbOptions in tty.
  # };

  # Enable the X11 windowing system.
  # services.xserver.enable = true;

  # Configure keymap in X11
  # services.xserver.layout = "us";
  # services.xserver.xkbOptions = "eurosign:e,caps:escape";

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  environment.shells = with pkgs; [ fish ];

  fonts = {
    enableDefaultFonts = true;
    fonts = with pkgs; [
      (nerdfonts.override { fonts = [ "FiraCode" ]; })
    ];
    fontDir.enable = true;
    fontconfig = {
      defaultFonts = {
        monospace = [ "FiraCode Nerd Font Mono" ];
      };
      # localConf = ''
      #   <match target="font">
      #     <test name="fontformat" compare="not_eq">
      #       <string />
      #     </test>
      #     <test name="family">
      #       <string>FiraCode Nerd Font</string>
      #     </test>
      #     <edit name="fontfeatures" mode="assign_replace">
      #       <string>cv02 ss01 ss03 ss04</string>
      #     </edit>
      #   </match>
      # '';
    };
  };

  users = {
    defaultUserShell = pkgs.fish;

    users.askarbink = {
      isNormalUser = true;
      extraGroups = [ "wheel" ];
      # packages = with pkgs; [ ];
    };
  };

  home-manager.users.askarbink = { pkgs, ... }: {
    home.stateVersion = "23.05";

    programs.git = {
      enable = true;
      userName = "Askar Arslanov";
      userEmail = "askarbink29@gmail.com";
      extraConfig.init.defaultBranch = "main";
    };

    xdg.userDirs = {
      enable = true;
      createDirectories = true;
    };
  };

  hardware.bluetooth.enable = true;

  environment.systemPackages = with pkgs; [
    android-tools
    busybox
    cinnamon.nemo
    cinnamon.nemo-fileroller
    cliphist
    exa
    fish
    fortune
    gcc
    google-fonts
    greetd.tuigreet
    grim
    hyprpicker
    jq
    kitty
    lazygit
    libnotify
    libsForQt5.polkit-kde-agent
    lua
    neovim
    nixpkgs-fmt
    nodejs_20
    python311
    python311Packages.pip
    pywal
    rustup
    slurp
    starship
    swappy
    swaynotificationcenter
    swww
    tealdeer
    tmux
    trash-cli
    unzip
    vim
    waybar
    wget
    wl-clipboard
    wlr-randr
    wofi
    xdg-desktop-portal-hyprland
    xplr
  ];

  # Recommended for Pipewire
  security.rtkit.enable = true;

  services = {
    blueman.enable = true;

    cron = {
      enable = true;
      # systemCronJobs = [
      #   ""
      # ];
    };

    flatpak.enable = true;

    greetd = {
      enable = true;
      settings.default_session = {
        command = "tuigreet --remember --cmd Hyprland";
        user = "greeter";
      };
    };

    pipewire = {
      enable = true;
      alsa = { enable = true; support32Bit = true; };
      jack.enable = true;
      pulse.enable = true;
    };

    printing.enable = true;

    openssh.enable = true;
  };

  programs = {
    fish.enable = true;
    hyprland.enable = true;
  };

  nixpkgs.config.allowUnfree = true;
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware = {
    opengl.enable = true;
    nvidia = {
      package = config.boot.kernelPackages.nvidiaPackages.stable;
      modesetting.enable = true;
    };
  };
  programs.hyprland.nvidiaPatches = true;

  systemd.user.services.polkit-kde-authentication-agent-1 = {
    description = "polkit-kde-authentication-agent-1";
    wantedBy = [ "graphical-session.target" ];
    wants = [ "graphical-session.target" ];
    after = [ "graphical-session.target" ];
    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.libsForQt5.polkit-kde-agent}/libexec/polkit-kde-authentication-agent-1";
      Restart = "on-failure";
      RestartSec = 1;
      TimeoutStopSec = 10;
    };
  };

  system.stateVersion = "23.05";
}
