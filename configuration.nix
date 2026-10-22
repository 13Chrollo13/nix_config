# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      # inputs.noctalia-greeter.nixosModules.default
      ./hardware-configuration.nix
      <home-manager/nixos>
      ../modules/baseline.nix # <-- shared config between laptop/desktop
 #    ../../../modules/flatpak.nix
     ../modules/niri.nix # <-- niri environment
 #    ../../../modules/hypr.nix # <-- hyprland environment
 #    # ../../../modules/gnome.nix    <-- gnome environemt
     # ../modules/kde.nix
 #    # ../../../modules/xfce.nix     <-- xfce environment
 #    ../../../modules/storagebox.nix
 #    ../../../modules/retroshare.nix
 #    ../../../modules/nixvim.nix
     ../modules/packages.nix
 #    ../../../modules/yazi.nix
 #    ../../../modules/virtualization.nix
 #    ../../../modules/polkit.nix
     ];
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Use latest kernel.
  # boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  # time.timeZone = "Europe/Berlin";

  # Select internationalisation properties.
  # i18n.defaultLocale = "de_DE.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_DE.UTF-8";
    LC_IDENTIFICATION = "de_DE.UTF-8";
    LC_MEASUREMENT = "de_DE.UTF-8";
    LC_MONETARY = "de_DE.UTF-8";
    LC_NAME = "de_DE.UTF-8";
    LC_NUMERIC = "de_DE.UTF-8";
    LC_PAPER = "de_DE.UTF-8";
    LC_TELEPHONE = "de_DE.UTF-8";
    LC_TIME = "de_DE.UTF-8";
  };

  # Enable the X11 windowing system.
  # You can disable this if you're only using the Wayland session.
  services.xserver.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "de";
    variant = "";
  };
# services.displayManager.noctalia-greeter = {
#   enable = true;
#   settings = {
#     cursor = {
#       theme = "Bibata-Modern-Ice";
#       size = 24;
#       path = pkgs.bibata-cursors;
#     };
#   };
# };
#
  # Configure console keymap
  # console.keyMap = "de";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    # jack.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  # users.users."shu" = {
  #   isNormalUser = true;
  #   description = "shu_UwU";
  #   extraGroups = [ "networkmanager" "wheel" ];
  #   packages = with pkgs; [
  #     kdePackages.kate
  #   #  thunderbird
  #   ];
  # };
  nixpkgs.config.permittedInsecurePackages = [
      "ventoy-1.1.12"
  ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile.
  # You can use https://search.nixos.org/ to find more packages (and options).
  # environment.systemPackages = with pkgs; [
  #   vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  #   wget
  # ];
environment.systemPackages = [
    pkgs.hyfetch
    pkgs.comma
    pkgs.obsidian
    pkgs.vlc
    pkgs.ente-auth
    #pkgs.ente-desktop
    pkgs.fastfetch
    pkgs.alacritty
    pkgs.git
#comunicaiont
    pkgs.signal-desktop    
    pkgs.element
    pkgs.beeper
    pkgs.waydroid
#games
    pkgs.ventoy
    pkgs.kiwix
    pkgs.vscodium
    pkgs.mlocate
    pkgs.element
    pkgs.home-manager
    pkgs.niri
    pkgs.noctalia
];
  

programs = {
	neovim.enable = true;
  # nixvim.enable = true; # enable nixvim configuration
   # polkit.enable = true;
  # yazi.enable = true; # yazi
 
  niri.enable = true; # change to a different profile if you want
  #fish.enable = true;
#  niri.enable = true;
};


  # virtualization.enable = true; # enable QEMU/KVM virtualization

   #home-manager.users.shu = {
     programs.fish = {
       enable = true;
     };
         programs.fish.shellAliases = {
         "v" = "nvim";
       };
    #};
  #};
 

  # hostname
  # networking.hostName = "prometheus";
  hardware.cpu.amd.updateMicrocode = true;

  workstation = {
    baseline = {
      enable = true; # enable baseline config
      packages = {
        tools = true; # enable common suite of CLI tools
        dev = true; # enable common langs/lang related tools
        apps = true; # enable common desktop applications
      };
    };
    # retroshare.enable = false; # enables ROM sync to server
    # nixvim.enable = true; # enable nixvim configuration
    niri.enable = true; # change to a different profile if you want
  #   kde.enable = false;
  #   polkit.enable = true;
  #   yazi.enable = true; # yazi
  #   virtualization.enable = true; # enable QEMU/KVM virtualization
  #   flatpak = {
  #     enable = true;
  #     onCalendar = "weekly";
  #     packages = [
  #       "flathub:app/app.zen_browser.zen//stable"
  #       "flathub:app/com.github.tchx84.Flatseal//stable"
  #     ];
  #   };
   };
# workstation = {
#     baseline = {
#       enable = true; # enable baseline config
#       packages = {
#         tools = true; # enable common suite of CLI tools
#         dev = true; # enable common langs/lang related tools
#         apps = true; # enable common desktop applications
#       };
#     };
#     retroshare.enable = false; # enables ROM sync to server

  services.fprintd.enable = true;

  # sops.age.sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];

  programs.steam.enable = true;

  systemd.services.micmute-led-off = {
    description = "Turn off micmute LED at boot";
    wantedBy = [ "multi-user.target" ];
    after = [ "sysinit.target" ];

    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.bash}/bin/bash -c 'echo 0 > /sys/class/leds/platform::micmute/brightness || true'";
    };
  };

  #  virtualisation.podman = {
  #   enable = true;
  #   dockerCompat = true;
  # };

  # environment.systemPackages = with pkgs; [
  #   v4l-utils
  # ];
  #



programs.firefox = {
  enable = true;


  policies = {
    ExtensionSettings = let
      moz = short: "https://addons.mozilla.org/firefox/downloads/latest/${short}/latest.xpi";
    in {
      "*".installation_mode = "blocked";

      "uBlock0@raymondhill.net" = {
        install_url       = moz "ublock-origin";
        installation_mode = "force_installed";
      };
      "{4150c16f-df8a-4535-a7d0-197b3f7c3ce8}" = {
        install_url       = moz "kit-big";
        installation_mode = "force_installed";
      }; 
      "{446900e4-71c2-419f-a6a7-df9c091e268b}" = {
        install_url       = moz "bitwarden-password-manager";
        installation_mode = "force_installed";
      };
      "{d7742d87-e61d-4b78-b8a1-b469842139fa}" = {
        install_url       = moz "vimium-ff";
        installation_mode = "force_installed";
      };
      "{{b11bea1f-a888-4332-8d8a-cec2be7d24b9}}" = {
        install_url       = moz "torproject-snowflake";
        installation_mode = "force_installed";
      }; 
    };
  };
};
  

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "26.05"; # Did you read the comment?

}
