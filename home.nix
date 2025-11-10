{ pkgs, ... }:

{
  imports = [
    ./niri.nix
    ./nixvim-config.nix
    ./tmux.nix
    ./1password-wayland.nix
    ./askpass.nix
  ];

  home.username = "leomar";
  home.homeDirectory = "/home/leomar";

  # link the configuration file in current directory to the specified location in home directory
  # home.file.".config/i3/wallpaper.jpg".source = ./wallpaper.jpg;

  # link all files in `./scripts` to `~/.config/i3/scripts`
  # home.file.".config/i3/scripts" = {
  #   source = ./scripts;
  #   recursive = true;   # link recursively
  #   executable = true;  # make all files executable
  # };

  # encode the file content in nix configuration file directly
  # home.file.".xxx".text = ''
  #     xxx
  # '';

  # set cursor size and dpi for 4k monitor
  xresources.properties = {
    "Xcursor.size" = 16;
    "Xft.dpi" = 172;
  };

  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [
    # archives
    zip
    unzip

    # utils
    ripgrep
    jq

    # networking tools
    socat
    nmap

    # misc
    which
    gawk

    # monitoring
    btop # replacement of htop/nmon
    iotop # io monitoring
    iftop # network monitoring

    # system call monitoring
    strace
    ltrace
    lsof

    # 1p
    _1password-cli

    # claude-code
    claude-code

    # Development tools (that were managed by mason)
    lua-language-server
    shellcheck
    stylua
    pyright
    nixfmt-classic
    nil

    # Fonts
    nerd-fonts.jetbrains-mono

    # lazygit
    lazygit
  ];

  # basic configuration of git
  programs.git = {
    enable = true;
    userName = "Leo Martins";
    userEmail = "loemra.dev@gmail.com";

    extraConfig = {
      init.defaultBranch = "main";
      credential.helper = "store";
    };
  };

  programs.gh = {
    enable = true;
    settings = { git_protocol = "ssh"; };
  };

  programs.ssh = {
    enable = true;
    matchBlocks = {
      "github.com" = {
        identityFile = "~/.ssh/github";
        identitiesOnly = true;
        extraOptions = { IPQoS = "throughput"; };
      };
    };
  };

  # alacritty
  programs.alacritty = {
    enable = true;
    # custom settings
    settings = {
      env.TERM = "xterm-256color";
      font = {
        size = 12;
        normal = { family = "JetBrainsMono Nerd Font"; };
      };
      scrolling.multiplier = 5;
      selection.save_to_clipboard = true;
    };
  };

  # fuzzel
  home.file.".config/fuzzel/fuzzel.ini".text = ''
    terminal = alacritty -e
  '';

  # This value determines the home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update home Manager without changing this value. See
  # the home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "25.05";
}
