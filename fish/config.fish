function starship_transient_prompt_func
    starship module character
end

starship init fish | source

fish_add_path "$HOME/bin"

set -gx VOLTA_HOME "$HOME/.volta"
fish_add_path "$VOLTA_HOME/bin"

set -gx HOMEBREW_NO_EMOJI 1

if test -d "$HOME/go"
    set -gx GOPATH "$HOME/go"
    fish_add_path $GOPATH/bin
end

test -d "$HOME/.cargo/bin" && fish_add_path "$HOME/.cargo/bin"

set -gx RIPGREP_CONFIG_PATH $HOME/.config/ripgreprc

op completion fish | source

COMPLETE=fish jj | source

enable_transience

gpg-connect-agent /bye
