{ 
  packageOverrides = pkgs: with pkgs; {
    user-env = pkgs.buildEnv {
      name = "user-env";
      paths = [
        ctags
        fzf
        git
        gnupg
        go
        "hub-2.3.0"
        jq
        neovim
        ripgrep
        "ruby-2.5.1"
        zsh
      ];
    };
  };
}
