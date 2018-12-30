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
        "hub"
        jq
        neovim
        nodejs
        "python3.6-grip"
        ripgrep
        "ruby-2.5.1"
        terraform
        watch
        zsh
      ];
    };
  };
}
