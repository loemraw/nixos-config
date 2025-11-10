{ pkgs, ... }:

{
  # Replace _1password-gui with wrapped version
  home.packages = [
    # 1Password with Wayland wrapper
    (pkgs.writeShellScriptBin "1password" ''
      exec ${pkgs._1password-gui}/bin/1password \
        --enable-features=UseOzonePlatform,WaylandWindowDecorations \
        --ozone-platform=wayland \
        --disable-gpu-compositing \
        "$@"
    '')
  ];

  # Override desktop entry for application launchers like fuzzel
  xdg.desktopEntries."1password" = {
    name = "1Password";
    comment = "Password manager and secure wallet";
    exec = "1password %U";
    icon = "1password";
    type = "Application";
    categories = [ "Office" ];
    mimeType = [ "x-scheme-handler/onepassword" ];
    startupNotify = true;
  };
}