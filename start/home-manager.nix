# This is your home-manager configuration file
{
  config,
  pkgs,
  ...
}: {
  # Define a user account. Don't forget to set a password with ‘passwd’.
  # move user.users.phil here
  

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
    # Chromium here

    # Desktop stuff

  };
  
}
