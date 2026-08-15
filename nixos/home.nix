{ pkgs, ... }:

let
  batteryWarningScript = pkgs.writeShellScript "battery-warning" ''
    set -eu

    battery_dir="$(${pkgs.findutils}/bin/find /sys/class/power_supply -maxdepth 1 -type d -name 'BAT*' | ${pkgs.coreutils}/bin/head -n 1)"
    [ -n "$battery_dir" ] || exit 0

    status="$(${pkgs.coreutils}/bin/cat "$battery_dir/status" 2>/dev/null || echo Unknown)"
    capacity="$(${pkgs.coreutils}/bin/cat "$battery_dir/capacity" 2>/dev/null || echo 0)"

    case "$status" in
      Discharging|Not\ charging) ;;
      *)
        ${pkgs.coreutils}/bin/rm -f "$XDG_RUNTIME_DIR/battery-warning-level"
        exit 0
        ;;
    esac

    level=""
    urgency="normal"
    title="Battery low"
    body="Battery at ''${capacity}%."

    if [ "$capacity" -le 5 ]; then
      level="critical"
      urgency="critical"
      title="Battery critical"
      body="Battery at ''${capacity}%. Plug in now."
    elif [ "$capacity" -le 15 ]; then
      level="low"
    fi

    if [ -z "$level" ]; then
      ${pkgs.coreutils}/bin/rm -f "$XDG_RUNTIME_DIR/battery-warning-level"
      exit 0
    fi

    state_file="$XDG_RUNTIME_DIR/battery-warning-level"
    last_level=""
    if [ -f "$state_file" ]; then
      last_level="$(${pkgs.coreutils}/bin/cat "$state_file")"
    fi

    if [ "$last_level" = "$level" ]; then
      exit 0
    fi

    ${pkgs.libnotify}/bin/notify-send \
      --app-name="battery-monitor" \
      --urgency="$urgency" \
      --icon="battery-caution-symbolic" \
      "$title" \
      "$body"

    printf '%s' "$level" > "$state_file"
  '';
in

{
  home.stateVersion = "26.05";

  programs.zsh = {
    enable = true;
    oh-my-zsh = {
      enable = true;
      theme = "robbyrussell";
      plugins = [ "git" ];
    };
    initContent = ''
      source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
      [[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh
    '';
  };

  xdg.configFile."hypr/hyprland.conf" = {
    force = true;
    text = ''
    $mod = SUPER

    monitor = eDP-1, 1920x1200@60, 0x0, 1
    # Example external 4K monitor:
    # monitor = DP-1, 3840x2160@60, 1920x0, 1.5

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
    bindel = , XF86AudioRaiseVolume, exec, wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%+
    bindel = , XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
    bindl = , XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
    bindel = , XF86MonBrightnessUp, exec, brightnessctl set 5%+
    bindel = , XF86MonBrightnessDown, exec, brightnessctl set 5%-
    bind = $mod, 1, workspace, 1
    bind = $mod, 2, workspace, 2
    bind = $mod, 3, workspace, 3
    bind = $mod, 4, workspace, 4
    bind = $mod, 5, workspace, 5
    bind = $mod, 6, workspace, 6
    bind = $mod, 7, workspace, 7
    bind = $mod, 8, workspace, 8
    bind = $mod, 9, workspace, 9
    bind = $mod, 0, workspace, 10
    bind = $mod SHIFT, 1, movetoworkspace, 1
    bind = $mod SHIFT, 2, movetoworkspace, 2
    bind = $mod SHIFT, 3, movetoworkspace, 3
    bind = $mod SHIFT, 4, movetoworkspace, 4
    bind = $mod SHIFT, 5, movetoworkspace, 5
    bind = $mod SHIFT, 6, movetoworkspace, 6
    bind = $mod SHIFT, 7, movetoworkspace, 7
    bind = $mod SHIFT, 8, movetoworkspace, 8
    bind = $mod SHIFT, 9, movetoworkspace, 9
    bind = $mod SHIFT, 0, movetoworkspace, 10
  '';
  };

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

  systemd.user.services.battery-warning = {
    Unit.Description = "Warn when the battery is low";
    Service = {
      Type = "oneshot";
      ExecStart = batteryWarningScript;
    };
  };

  systemd.user.timers.battery-warning = {
    Unit.Description = "Check battery level periodically";
    Timer = {
      OnBootSec = "2m";
      OnUnitActiveSec = "1m";
      Unit = "battery-warning.service";
    };
    Install.WantedBy = [ "timers.target" ];
  };

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
    chromium
    ghostty
    zed-editor
    _1password-gui
    zsh-powerlevel10k
    wayle
    wofi
    libnotify
    brightnessctl
    nerd-fonts.jetbrains-mono
    font-awesome
  ];
}
