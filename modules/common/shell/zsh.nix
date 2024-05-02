{
  programs = {
    zsh = {
      enable = true;

      enableCompletion = true;
      autosuggestions.enable = true;
      syntaxHighlighting.enable = true;

      ohMyZsh = {
        enable = true;
        plugins = [ "git" ];
        theme = "frisk";
      };

#      history = {
#        save = 10000;
#        size = 10000;
#        path = "$HOME/.cache/zsh_history";
#      };

#      intiExtra = ''
#        bindkey '^[[1;5C' forward-word # Ctrl+RightArrow
#        bindkey '^[[1;5D' backward-word # Ctrl+LeftArrow
#
#        zstyle ':completion:*' completer _complete _match _approximate
#        zstyle ':completion:*:match:*' original only
#        zstyle ':completion:*:approximate:*' max-errors 1 numeric
#        zstyle ':completion:*' menu select
#        zstyle ':completion:*' list-colors "''${(s.:.)LS_COLORS}"
#
#        export EDITOR=nvim
#      '';

      shellAliases = {
        l = "ls -lah";
        ga = "git add";
        gc = "git commit";
        gco = "git checkout";
        gst = "git status";
      };
    };
  };
}
