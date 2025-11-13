{ config, pkgs, ... }:

{
  programs.niri = {
    enable = true;
    settings = {
      input = {
        keyboard = {
          xkb = {
            layout = "us";
            options = "ctrl:nocaps";
          };
        };
      };

      layout = {
        gaps = 8;
        center-focused-column = "never";
      };

      spawn-at-startup = [
        { command = ["firefox"]; }
        { command = ["conky"]; }
      ];

      binds = {
        "Mod+Space".action.spawn = [ "fuzzel" ];
        "Mod+Return".action.spawn = [ "alacritty" ];
        "Mod+B".action.spawn = [ "firefox" ];
        "Mod+Q".action.close-window = [ ];
        "Mod+F".action.fullscreen-window = [ ];

        # Navigation
        "Mod+Left".action.focus-column-left = [ ];
        "Mod+Right".action.focus-column-right = [ ];
        "Mod+Up".action.focus-window-up = [ ];
        "Mod+Down".action.focus-window-down = [ ];

        # Move
        "Mod+Shift+Left".action.move-column-left = [ ];
        "Mod+Shift+Right".action.move-column-right = [ ];

        # Workspaces
        "Mod+1".action.focus-workspace = 1;
        "Mod+2".action.focus-workspace = 2;
        "Mod+3".action.focus-workspace = 3;

        # Monitors
        "Mod+Ctrl+Left".action.focus-monitor-left = [ ];
        "Mod+Ctrl+Right".action.focus-monitor-right = [ ];

        # Exit niri
        "Mod+Shift+E".action.quit = [ ];
      };

      prefer-no-csd = true;
    };
  };
}
