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

## What You’ll Need
1. A fresh install of NixOS.
2. **Optional:** A Linux-compatible Wi-Fi adapter like the [Alfa AWUS036ACHM](https://www.amazon.com/AWUS036ACHM-802-11ac-Range-Boost-Adapter/dp/B08SJBV1N3).
3. A willingness to tinker and learn!

---

## NixOS Basics
Nix is a package manager, and NixOS is a Linux distribution built around it. Instead of manually managing configurations, you declare your system’s state in configuration files. Think of it as coding your system into existence.

---

## Getting Started

### Step 1: Install a Text Editor
If you’re unfamiliar with Nano keybindings, you can install Vim:
```bash
nix-shell -p vim
```

### Step 2: Change the Hostname
Update your hostname in `configuration.nix`:
```nix
networking.hostName = "MyCoolHostName";
```

Rebuild the system:
```bash
sudo nixos-rebuild test
```

### Step 3: Add Essential Packages
Add the following packages to your `configuration.nix` under `environment.systemPackages`:
```nix
environment.systemPackages = with pkgs; [
  vim
  wget
];
```
Rebuild the system to apply changes:
```bash
sudo nixos-rebuild switch
```

---

## Home Manager Setup
Home Manager allows you to manage user-level configurations declaratively. Here’s how to set it up:

### Step 1: Add the Home Manager Channel
Ensure your Nix channels match the version of your NixOS installation:
```bash
nix-channel --add https://github.com/nix-community/home-manager/archive/release-24.11.tar.gz home-manager
nix-channel --update
```

### Step 2: Import Home Manager into `configuration.nix`
Add this line to your imports:
```nix
<home-manager/nixos>
```

### Step 3: Configure Home Manager
In your `home-manager.nix`, you can add configurations like these:

#### Example Configuration:
```nix
home-manager.users.yourusername = {
  home.stateVersion = "24.11";
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    extensions = with pkgs.vscode-extensions; [
      bbenoist.nix
      kamadorueda.alejandra
      esbenp.prettier-vscode
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
Rebuild to apply:
```bash
sudo nixos-rebuild switch
```

---

## Handy Tips
- Find installed applications:
```bash
find /run/current-system/sw/share/applications
```
- Check out configuration editors:
[NixOS Configuration Editors](https://nixos.wiki/wiki/NixOS_configuration_editors)

---

## Debugging and FAQs
### Why use `sudo nixos-rebuild test`?
- This command applies changes without committing them, so you can validate your configuration.

### When do I need to reboot?
- Only if critical system components (like the kernel) are updated. For most changes, a rebuild suffices.

---

## Conclusion
By the end of this walkthrough, you’ll have a fully functional, customized NixOS installation. Remember, NixOS is about learning and experimenting. Once you grasp the basics, you’ll wonder how you ever lived without it.

Now, let’s set it and forget it—until the next great idea strikes!
