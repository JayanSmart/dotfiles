{ ... }: {
  imports = [
    ./bash
    ./fish
    ./git.nix
    ./zsh.nix
    ./fzf.nix
    # ./github.nix
    # ./nixpkgs.nix
    ./utilities.nix
  ];
}
