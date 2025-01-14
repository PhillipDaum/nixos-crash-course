# This is your home-manager configuration file
{
  config,
  pkgs,
  ...
}: {
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.phil = {
    isNormalUser = true;
    description = "phil";
    extraGroups = ["networkmanager" "wheel"];
    packages = with pkgs; [
      gnomeExtensions.dock-from-dash
    ];
  };

  # Home Manager stuff
  home-manager.users.phil = {
    home.stateVersion = "24.11";
    # programs
    programs.vscode = {
      enable = true;
      package = pkgs.vscodium;
      extensions = with pkgs.vscode-extensions; [
        bbenoist.nix # support for Nix language
        kamadorueda.alejandra # formatting for Nix
      ];
    };
    programs.chromium = {
      enable = true;
      extensions = [
        "nngceckbapebfimnlniiiahkandclblb" # Bitwarden extension ID
      ];
    };

    # Desktop stuff
    gtk = {
      enable = true;
      iconTheme = {
        name = "BeautyLine";
        package = pkgs.beauty-line-icon-theme;
      };
      # almost all apps show up with dark styling, but not all.
      gtk3.extraConfig = {
        Settings = ''
          gtk-application-prefer-dark-theme=1
        '';
      };
      gtk4.extraConfig = {
        Settings = ''
          gtk-application-prefer-dark-theme=1
        '';
      };
    };
    dconf.settings = {
      "org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
      };
      "org/gnome/desktop/wm/preferences" = {
        button-layout = ":minimize,maximize,close";
      };
      "org/gnome/shell" = {
        favorite-apps = [
          "org.gnome.Calendar.desktop"
          "org.gnome.Nautilus.desktop"
          "org.gnome.Console.desktop"
          "chromium-browser.desktop"
          "codium.desktop"
          "guvcview.desktop"
        ];
        disable-user-extensions = false;
        # `gnome-extensions list` for a list
        enabled-extensions = [
          "dock-from-dash@fthx"
        ];
      };
    };
  };
}
