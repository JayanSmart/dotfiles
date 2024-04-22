{
  description = "My nixos base configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
    
  };

  outputs = { self, nixpkgs }: 
    let 
      system = "x86_64-linux";
      pkgs = import nixpkgs {
	inherit system;
	config.allowUnfree = true;
      };
      lib = nixpkgs.lib;
    in {
      nixosConfigurations = {
      mixos = lib.nixosSystem {
	inherit system;
	modules = [ ./configuration.nix ];
      };
    };
  };
}
