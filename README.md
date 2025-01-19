# NixOS Crash Course
![Ron Popeil says Set it and Forget it](https://substackcdn.com/image/fetch/f_auto,q_auto:good,fl_progressive:steep/https%3A%2F%2Fbucketeer-e05bbc84-baa3-437e-9518-adb32be77984.s3.amazonaws.com%2Fpublic%2Fimages%2F33d6e1a2-8b3a-41f0-9430-2758dec0a401_387x405.jpeg)

## Introduction
Welcome to the NixOS Crash Course! Think of this as the Ron Popeil approach to Linux: "Set it and forget it." While NixOS may have a steeper learning curve than other distributions, it rewards you with unparalleled reproducibility and flexibility.

This guide will walk you through setting up NixOS from a fresh install, customizing it with packages, and leveraging Home Manager for user-level configuration. Let’s get started!

---

## Who Uses NixOS?
NixOS is popular among:
- **Developers and DevOps Engineers** who love reproducible builds and deployments.
- **Linux Enthusiasts** who enjoy tweaking and customizing their setups.
- **System Administrators** looking for a declarative approach to configuration.

If you value consistency and want your configurations to work across machines, NixOS might be for you!

---

## Prerequisites
Before diving in, ensure you have:
- A fresh NixOS installation. If you’re new to NixOS, check out [the official installation guide](https://nixos.org/manual/nixos/stable/#chap-installation) or simply download the ISO from [here](https://nixos.org/download/).
  - **Optional:** A Linux-compatible Wi-Fi adapter like the [Alfa AWUS036ACHM](https://www.amazon.com/AWUS036ACHM-802-11ac-Range-Boost-Adapter/dp/B08SJBV1N3). NixOS requires an internet connection during installation. If you’re unsure whether your Wi-Fi card is supported by the Linux kernel, consider using an adapter.
  - Make sure to allow un-free software during installation unless you’re certain you don’t need it. This typically helps with drivers and hardware compatibility.
- A willingness to tinker and learn!

**Note:** Some configurations, like for older MacBooks (e.g., a 2015 MacBook Air), may require additional setup for components like webcams. 

---

## NixOS Basics
Nix is a package manager, and NixOS is a Linux distribution built around it. Instead of manually managing configurations, you declare your system’s state in configuration files. Think of it as coding your system into existence.



Key concepts:
- **Declarative Configuration**: Define your system in files.
- **Reproducibility**: Replicate configurations on different machines.
- **Atomic Upgrades and Rollbacks**: Easily revert changes.

---

## Step-by-Step Guide

### 1. Install a Text Editor
For editing configuration files, you’ll need a text editor. If Nano isn’t your preference, install Vim temporarily:
```bash
nix-shell -p vim
```
This creates a temporary shell with Vim, removed after the session ends.

### 2. Change the Hostname
Set your system’s hostname in `/etc/nixos/configuration.nix`:
```nix
networking.hostName = "nebulaNugget";
```

Test the change:
```bash
sudo nixos-rebuild test
```
Apply it permanently:
```bash
sudo nixos-rebuild switch
```

### 3. Add Essential Packages
Add packages under `environment.systemPackages` in `configuration.nix`:
```nix
environment.systemPackages = with pkgs; [
  vim
  wget
  firefox
];
```
Rebuild your system:
```bash
sudo nixos-rebuild switch
```
Packages and options are found here. There are loads!:
- [search.nixos.org](https://search.nixos.org/)


### 4. Edit Configurations as a User
For convenience, move your NixOS configuration directory to your home folder:
```bash
mkdir ~/etc
sudo mv /etc/nixos ~/etc/
sudo chown -R $(id -un):users ~/etc/nixos
sudo ln -s ~/etc/nixos /etc/
```
This lets you edit configurations without switching to root. I recommend initializing this folder as a private repository. This makes management really easy. 

---

## Home Manager Setup
Home Manager allows you to manage user-level configurations declaratively. This method is installing [Home Manager as a NixOS Module](https://nix-community.github.io/home-manager/index.xhtml#sec-install-nixos-module).

### 1. Add the Home Manager Channel
Add the Home Manager channel matching your NixOS version:
```bash
sudo nix-channel --add https://github.com/nix-community/home-manager/archive/release-24.11.tar.gz home-manager
sudo nix-channel --update
```
Learn more about channels [here](https://nixos.org/manual/nixos/stable/#sec-channels).

### 2. Enable Home Manager in `configuration.nix`
Add the Home Manager module to imports:
```nix
imports = [
  <home-manager/nixos>
];
```

### 3. Configure Home Manager
Define user-specific configurations:
```nix
home-manager.users.phil = {
  home.stateVersion = "24.11";
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    extensions = with pkgs.vscode-extensions; [
      bbenoist.nix
      kamadorueda.alejandra
    ];
  };
  programs.chromium = {
    enable = true;
    extensions = [
      "nngceckbapebfimnlniiiahkandclblb" # Bitwarden extension ID
    ];
  };
};
```
The VSCode extensions are from [search.nixos.org](https://search.nixos.org/), The Chrome extensions are the code at the end of its URL, like this for Bitwarden: [nngceckbapebfimnlniiiahkandclblb](https://chromewebstore.google.com/detail/bitwarden-password-manage/nngceckbapebfimnlniiiahkandclblb) 

Apply changes:
```bash
sudo nixos-rebuild switch
```

---

## Maintenance Tips

### Updating Channels and Packages
Keep your system up to date:
```bash
sudo nix-channel --update
sudo nixos-rebuild switch --upgrade
```

### Garbage Collection
Remove unused packages and generations:
```bash
sudo nix-collect-garbage -d
```
Learn more [here](https://nix.dev/manual/nix/2.24/package-management/garbage-collection.html).

### Rollbacks
If a configuration causes issues, revert to a previous generation via GRUB or:
```bash
sudo nix-env --rollback
```

---

## Resources
- **Official Documentation**: [NixOS Manual](https://nixos.org/manual/nixos/stable/)
- **Community Wiki**: [NixOS Wiki](https://nixos.wiki/)
- **Support**: Join the [NixOS Discourse](https://discourse.nixos.org/) or [Matrix chat](https://matrix.to/#/#nixos:matrix.org).

---

## Conclusion
With this guide, you’re well on your way to mastering NixOS. Its declarative, reproducible approach can transform how you manage systems. Experiment, learn, and enjoy the journey!

Happy hacking!

