{ pkgs, ... }:

{
  home.packages = [
    (pkgs.writeShellScriptBin "fuzzel-askpass" ''
      password=$(echo "" | ${pkgs.fuzzel}/bin/fuzzel --dmenu --password --prompt "Password: ")
      echo "$password"
    '')
  ];
}
