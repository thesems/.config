{ pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = false;

  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Vienna";

  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_AT.UTF-8";
    LC_IDENTIFICATION = "de_AT.UTF-8";
    LC_MEASUREMENT = "de_AT.UTF-8";
    LC_MONETARY = "de_AT.UTF-8";
    LC_NAME = "de_AT.UTF-8";
    LC_NUMERIC = "de_AT.UTF-8";
    LC_PAPER = "de_AT.UTF-8";
    LC_TELEPHONE = "de_AT.UTF-8";
    LC_TIME = "de_AT.UTF-8";
  };

  services.xserver.enable = true;

  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  };
  services.desktopManager.plasma6.enable = true;
  programs.hyprland = {
    enable = true;
    withUWSM = true;
    xwayland.enable = true;
  };
  xdg.portal.enable = true;
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  services.printing.enable = true;

  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  services.blueman.enable = true;

  virtualisation.docker.enable = true;
  virtualisation.docker.enableOnBoot = true;

  users.users.semir = {
    isNormalUser = true;
    description = "Semir Ramovic";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    packages = with pkgs; [
      kdePackages.kate
    ];
  };

  programs.nix-ld.enable = true;

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.android_sdk.accept_license = true;

  environment.systemPackages = with pkgs; [
    wl-clipboard
    fzf
    htop
    neovim
    python314
    brave
    chromium
    dnsutils
    ripgrep
    docker
    git
    ghostty
    unzip
    wget
    zed-editor
    transmission_4-qt
    tmux
    lazygit
    ledger-live-desktop
    evince
  ];

  programs._1password.enable = true;
  programs._1password-gui = {
    enable = true;
    polkitPolicyOwners = [ "semir" ];
  };

  programs.bash = {
    enable = true;
    shellAliases = {
      gs = "git status";
      gaa = "git add --all";
      gc = "git commit -m";
      gca = "git commit --amend";
      gp = "git pull";
      gd = "git diff";
      gds = "git diff --staged";
      gl = "git log --oneline --graph --decorate --all";
      gb = "git branch";
      dc = "docker compose";
      vim = "nvim";
    };
  };

  programs.tmux = {
    enable = true;
    extraConfig = ''
      set -g default-terminal "tmux-256color"
      set -as terminal-overrides ',*:Tc'
      set -g mouse on
    '';
  };

  networking.firewall.allowedTCPPorts = [ 22 8000 8081 19000 19001 19002 ];
  networking.firewall.allowedUDPPorts = [ 19000 19001 19002 5353 ];

  system.stateVersion = "25.11";

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
}
