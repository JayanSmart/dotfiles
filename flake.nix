{
  description = "My nixos base configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
    

    # Used for user packages and dotfiles
    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs"; # Use system packages list for their inputs
    };
  };

  outputs = { nixpkgs, ... }@inputs:
    let 

      globals = rec {
	user = "jayan";
	fullName = "Jayan Smart";
	gitName = fullName;
	gitEmail = "jayandrinsmart@gmail.com";
      };

      # Overlays to use once I understand what these are
      overlays = [
	(import ./overlays/neovim-plugins.nix inputs)
      ];

      supportedSystems = [
	"x86_64-linux"
      ];

      forAllSystems = nixpkgs.lib.genAttrs supportedSystems;
    in rec {

      # List of all sytems this config maintains
      # Primary personal machine: nixos-rebuils switch --flake .@mixos
      nixosConfigurations = {
	mixos = import ./hosts/mixos { inherit inputs globals overlays; };
      };

      homeConfigurations = {
	mixos = nixosConfigurations.mixos.config.home-manager.users.${globals.user}.home;
      };
      

      packages = 
        let
	  neovim = 
	    system:
	    let
	      pkgs = import nixpkgs { inherit system overlays; };
	    in
	    import ./modules/common/neovim/package {
	      inherit pkgs;
	      colors = (import ./colorscheme/gruvbox-dark).dark;
	    };
	in
	{
	  x86_64-linux.neovim = neovim "x86_64-linux";
	};
      
      apps = forAllSystems (
        system:
	let
	  pkgs = import nixpkgs { inherit system overlays; };
	in
	import ./apps {inherit pkgs; }
      );
      
      # Development Environments
      devShells = forAllSystems (
        system:
	let
	  pkgs = import nixpkgs { inherit system overlays; };
	in
	{
	  
	  #Used to run commands and edit files in this repo
	  default = pkgs.mkshell {
	    buildInputs = with pkgs; [
	      git
	      stylua
	      shellcheck
	    ];
	  };
	}
      );

      #Templates for starting new projects quickly
      templates = rec {
	default = basic;
	basic = {
	  path = ./templates/basic;
	  description = "Basic programming template";
	};
	rust = {
	  path = ./templates/rust;
	  description = "Rust template";
	};
      };
    };    
}
