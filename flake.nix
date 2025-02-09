{
  description = "My nixos base configuration";

  inputs = {

    # Used f:or system packages
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # Used for specific stable packages
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.11";

    # Used for user packages and dotfiles
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs"; # Use system packages list for their inputs
    };

    # Community packages for Firefox plugins
    nur.url = "github:nix-community/nur";

    # Wallpapers
    wallpapers = {
      url = "gitlab:exorcist365/wallpapers";
      flake = false;
    };

    nix2vim = {
      url = "github:gytis-ivaskevicius/nix2vim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Neovim plugins
    base16-nvim-src = {
      url = "github:RRethy/base16-nvim";
      flake = false;
    };
    nvim-lspconfig-src = {
      # https://github.com/neovim/nvim-lspconfig/tags
      url = "github:neovim/nvim-lspconfig/v0.1.8";
      flake = false;
    };
    cmp-nvim-lsp-src = {
      url = "github:hrsh7th/cmp-nvim-lsp";
      flake = false;
    };
    baleia-nvim-src = {
      # https://github.com/m00qek/baleia.nvim/tags
      url = "github:m00qek/baleia.nvim";
      flake = false;
    };
    comment-nvim-src = {
      # https://github.com/numToStr/Comment.nvim/relnixeases
      url = "github:numToStr/Comment.nvim/v0.8.0";
      flake = false;
    };
    nvim-treesitter-src = {
      # https://github.com/nvim-treesitter/nvim-treesitter/tags
      url = "github:nvim-treesitter/nvim-treesitter/v0.9.2";
      flake = false;
    };
    telescope-nvim-src = {
      # https://github.com/nvim-telescope/telescope.nvim/releases
      url = "github:nvim-telescope/telescope.nvim/0.1.8";
      flake = false;
    };
    telescope-project-nvim-src = {
      url = "github:nvim-telescope/telescope-project.nvim";
      flake = false;
    };
    toggleterm-nvim-src = {
      # https://github.com/akinsho/toggleterm.nvim/tags
      url = "github:akinsho/toggleterm.nvim/v2.12.0";
      flake = false;
    };
    bufferline-nvim-src = {
      # https://github.com/akinsho/bufferline.nvim/releases
      url = "github:akinsho/bufferline.nvim/v4.6.1";
      flake = false;
    };
    nvim-tree-lua-src = {
      url = "github:kyazdani42/nvim-tree.lua";
      flake = false;
    };
    hmts-nvim-src = {
      url = "github:calops/hmts.nvim";
      flake = false;
    };
    fidget-nvim-src = {
      # https://github.com/j-hui/fidget.nvim/tags
      url = "github:j-hui/fidget.nvim/v1.4.5";
      flake = false;
    };
    kitty-scrollback-nvim-src = {
      url = "github:mikesmithgh/kitty-scrollback.nvim";
      flake = false;
    };
    nvim-lint-src = {
      url = "github:mfussenegger/nvim-lint";
      flake = false;
    };

    # Tree-Sitter Grammars
    tree-sitter-bash = {
      url = "github:tree-sitter/tree-sitter-bash/master";
      flake = false;
    };
    tree-sitter-python = {
      url = "github:tree-sitter/tree-sitter-python/master";
      flake = false;
    };
    tree-sitter-lua = {
      url = "github:MunifTanjim/tree-sitter-lua/main";
      flake = false;
    };
    tree-sitter-ini = {
      url = "github:justinmk/tree-sitter-ini";
      flake = false;
    };
    tree-sitter-puppet = {
      url = "github:amaanq/tree-sitter-puppet";
      flake = false;
    };
    tree-sitter-rasi = {
      url = "github:Fymyte/tree-sitter-rasi";
      flake = false;
    };
    tree-sitter-vimdoc = {
      url = "github:neovim/tree-sitter-vimdoc";
      flake = false;
    };

    # Ren and rep - CLI find and replace
    rep = {
      url = "github:robenkleene/rep-grep";
      flake = false;
    };
    ren = {
      url = "github:robenkleene/ren-find";
      flake = false;
    };

    # Firefox addon from outside the extension store
    # bypass-paywalls-clean = {
    #   # https://gitlab.com/magnolia1234/bpc-uploads/-/commits/master/?ref_type=HEADS
    #   url = "https://github.com/bpc-clone/bpc_updates/releases/download/latest/bypass_paywalls_clean-3.7.4.0.xpi";
    #   flake = false;
    # };
  };

  outputs =
    { nixpkgs, ... }@inputs:
    let

      globals = rec {
        user = "jayan";
        fullName = "Jayan Smart";
        gitName = fullName;
        gitEmail = "jayandrinsmart@gmail.com";
      };

      # Overlays to use once I understand what these are
      overlays = [
        inputs.nur.overlay
        inputs.nix2vim.overlay
        (import ./overlays/neovim-plugins.nix inputs)
        (import ./overlays/tree-sitter.nix inputs)
        # (import ./overlays/bypass-paywalls-clean.nix inputs)
        (import ./overlays/ren-rep.nix inputs)
        (import ./overlays/betterlockscreen.nix)
        (import ./overlays/gh-collaborators.nix)
        # (import ./overlays/mpv-scripts.nix inputs)
      ];

      supportedSystems = [ "x86_64-linux" ];

      forAllSystems = nixpkgs.lib.genAttrs supportedSystems;
    in
    rec {
      # Remove warnings
      system.StateVersion = 23.11;

      # Allow unfree packages
      nixpkgs.config.allowUnfree = true;

      # List of all sytems this config maintains
      # Primary personal machine: nixos-rebuild switch --flake .#mixos
      nixosConfigurations = {
        mixos = import ./hosts/mixos { inherit inputs globals overlays; };
        protea = import ./hosts/protea { inherit inputs globals overlays; };
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
          aarch64-darwin.neovim = neovim "aarch64-darwin";
        };

      apps = forAllSystems (
        system:
        let
          pkgs = import nixpkgs { inherit system overlays; };
        in
        import ./apps { inherit pkgs; }
      );

      formatter = forAllSystems (
        system:
        let
          pkgs = import nixpkgs { inherit system overlays; };
        in
        pkgs.nixfmt-rfc-style
      );

      # Development Environments
      devShells = forAllSystems (
        system:
        let
          pkgs = import nixpkgs { inherit system overlays; };
        in
        {

          #Used to run commands and edit files in this repo
          default = pkgs.mkShell {
            buildInputs = with pkgs; [
              git
              stylua
              nixfmt
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
        python = {
          path = ./templates/python;
          description = "Python template";
        };
      };
    };
}
