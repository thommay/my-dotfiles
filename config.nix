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
        hub
        jq
        neovim
        ripgrep
        terraform
        watch
        zsh
      ];
    };
  };
}
