NixOS
-- Are the basics of NixOS the channels, the config and the....



- start with a fresh istall of NixOS
- Show them the wifi dongle thing -reccomended having one that you know is in the linux kernel. it will usually find the others. make SURE you check the box that allows unfree software! 

- show them the powerpoint thing
- go to the root directory
- show them the website, also Nix package manager
	- notes about the package manager
	- 
- who uses this? seriously 
- I don't know the Nano keybindings, so let's install vim in a shell
 	`nix-shell p vim`

- Change Hostname
- Go to System Packages, add vim, wget, cheese. is it gnome.cheese? ....  
	`sudo nixos-rebuild test` or
	`sudo -i` run commands without sudo

	- should I run `sudo nixos-rebuild test` first?
	- I like to
	- when do I have to reset

## home manager, the module way, there is also a home manager tool
- First add the nix channel, make sure it is the same as your nixos or nix packages channel 
- use the `nix-channel` command 
- `nix-channel --add https://github.com/nix-community/home-manager/archive/release-24.11.tar.gz home-manager`

- add `<home-manager/nixos>` to imports
- lets add

- add home manager stuff - I like a dock


### OMG do this!!!!!
https://nixos.wiki/wiki/NixOS_configuration_editors


### 
here is a really useful command to find names of stuff to put in here cuz nixos is diffrent

`find /run/current-system/sw/share/applications -name '*chromium*.desktop'`
