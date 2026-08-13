{ pkgs, ... }:

{
  home.stateVersion = "26.05";

  programs.zsh = {
    enable = true;
    oh-my-zsh = {
      enable = true;
      theme = "robbyrussell";
      plugins = [ "git" ];
    };
    initExtra = ''
      source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
      [[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh
    '';
  };

  xdg.configFile."hypr/hyprland.conf".text = ''
    $mod = SUPER

    exec-once = dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=Hyprland
    exec-once = systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
    exec-once = wayle shell

    bind = $mod, Return, exec, ghostty
    bind = $mod, Space, exec, wofi --show drun --normal-window --width 1050 --height 788 --location center --gtk-dark --hide-scroll --insensitive --prompt Apps
    bind = $mod, D, exec, wofi --show drun --normal-window --width 1050 --height 788 --location center --gtk-dark --hide-scroll --insensitive --prompt Apps
    bind = $mod, Q, killactive
    bind = $mod SHIFT, Q, exit
    bind = $mod, Escape, exec, wlogout
    bind = $mod, L, exec, wlogout
    bind = $mod, F, fullscreen
    bind = $mod, V, togglefloating
  '';

  xdg.configFile."wayle/config.toml".text = ''
    [bar]
    location = "top"
    scale = 1.25
    rounding = "sm"

    [[bar.layout]]
    monitor = "*"
    left = ["dashboard", "hyprland-workspaces"]
    center = ["window-title"]
    right = ["cpu", "ram", "battery", "network", "volume", "notifications", "systray", "clock"]

    [modules.clock]
    format = "%H:%M"
    icon-show = true
    label-show = true

    [modules.cpu]
    label-show = true

    [modules.ram]
    label-show = true

    [modules.network]
    label-max-length = 18

    [modules.volume]
    label-show = true
  '';

  xdg.configFile."wofi/style.css".text = ''
    window {
      margin: 0;
      border: 1px solid rgba(255, 255, 255, 0.12);
      border-radius: 18px;
      background: rgba(24, 24, 27, 0.96);
    }

    #outer-box {
      margin: 0;
      padding: 15px;
    }

    #input {
      margin: 0 0 12px 0;
      padding: 12px 18px;
      border: 1px solid rgba(255, 255, 255, 0.10);
      border-radius: 12px;
      background: rgba(255, 255, 255, 0.05);
      color: #f4f4f5;
      font-size: 20px;
    }

    #scroll {
      margin: 0;
    }

    #entry {
      padding: 15px 20px;
      border-radius: 12px;
      color: #e4e4e7;
      font-size: 20px;
    }

    #entry:selected {
      background: rgba(255, 255, 255, 0.12);
    }

    #text {
      margin-left: 8px;
    }
  '';

  programs.wlogout = {
    enable = true;
    layout = [
      {
        label = "lock";
        action = "loginctl lock-session";
        text = "";
        keybind = "l";
        height = 1;
        width = 1;
        circular = true;
      }
      {
        label = "logout";
        action = "hyprctl dispatch exit";
        text = "";
        keybind = "o";
        height = 1;
        width = 1;
        circular = true;
      }
      {
        label = "suspend";
        action = "systemctl suspend";
        text = "";
        keybind = "s";
        height = 1;
        width = 1;
        circular = true;
      }
      {
        label = "hibernate";
        action = "systemctl hibernate";
        text = "";
        keybind = "h";
        height = 1;
        width = 1;
        circular = true;
      }
      {
        label = "reboot";
        action = "systemctl reboot";
        text = "";
        keybind = "r";
        height = 1;
        width = 1;
        circular = true;
      }
      {
        label = "shutdown";
        action = "systemctl poweroff";
        text = "";
        keybind = "s";
        height = 1;
        width = 1;
        circular = true;
      }
    ];
    style = ''
      * {
        background-image: none;
        box-shadow: none;
      }

      window {
      background: rgba(12, 12, 14, 0.72);
    }

      button {
        min-width: 240px;
        min-height: 240px;
        margin: 20px;
        border: 1px solid rgba(255, 255, 255, 0.10);
        border-radius: 30px;
        background-color: rgba(24, 24, 27, 0.96);
        background-repeat: no-repeat;
        background-position: center;
        background-size: 32%;
        color: transparent;
        font-size: 25px;
      }

      button:hover {
        background: rgba(255, 255, 255, 0.10);
      }

      #lock {
        background-image: image(url("${pkgs.wlogout}/share/wlogout/icons/lock.png"), url("${pkgs.wlogout}/share/wlogout/icons/lock.png"));
      }

      #logout {
        background-image: image(url("${pkgs.wlogout}/share/wlogout/icons/logout.png"), url("${pkgs.wlogout}/share/wlogout/icons/logout.png"));
      }

      #suspend {
        background-image: image(url("${pkgs.wlogout}/share/wlogout/icons/suspend.png"), url("${pkgs.wlogout}/share/wlogout/icons/suspend.png"));
      }

      #hibernate {
        background-image: image(url("${pkgs.wlogout}/share/wlogout/icons/hibernate.png"), url("${pkgs.wlogout}/share/wlogout/icons/hibernate.png"));
      }

      #reboot {
        background-image: image(url("${pkgs.wlogout}/share/wlogout/icons/reboot.png"), url("${pkgs.wlogout}/share/wlogout/icons/reboot.png"));
      }

      #shutdown {
        background-image: image(url("${pkgs.wlogout}/share/wlogout/icons/shutdown.png"), url("${pkgs.wlogout}/share/wlogout/icons/shutdown.png"));
      }
    '';
  };

  home.packages = with pkgs; [
    git
    neovim
    codex
    ghostty
    zed-editor
    _1password-gui
    zsh-powerlevel10k
    ripgrep
    wayle
    wofi
    nerd-fonts.jetbrains-mono
    font-awesome
  ];
}
