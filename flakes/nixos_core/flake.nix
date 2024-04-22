{
  description = "My first flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    
  };

  outputs = { self, nixpkgs }: 
    let 
      system = "x86_64-linux";
      pkgs = import nxpkgs {
	inherit system;
	config.allowUnfree = true;
      };
      lib = nixpkgs.lib;
    in {
      nixosConfiguration = {
      mixos = lib.nixosSystem {
	inherit system;
	modules = [ ./configuration.nix ];
      };
    };
  };
}
