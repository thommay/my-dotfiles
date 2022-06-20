local plugin_dir=${0:h}

export site_platform=${$(uname):l}
if [[ $site_platform == sunos ]]; then
  export site_id=`hostname`
else
  export site_id=`hostname -s`
fi
alias 'darwin:'='[[ $site_platform == darwin ]] &&'

fpath+=("${plugin_dir}/lib")
. ${plugin_dir}/lib/chruby_auto
. ${plugin_dir}/lib/direnv
. ${plugin_dir}/lib/_rustup
. ${plugin_dir}/lib/_zgit

autoload -Uz chruby_auto
autoload -Uz direnv

. ${plugin_dir}/settings
. ${plugin_dir}/aliases

if type brew &>/dev/null; then
  FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
fi

autoload -Uz compinit
compinit

unalias run-help
autoload run-help
HELPDIR=/usr/local/share/zsh/helpfiles

autoload -U url-quote-magic
zle -N self-insert url-quote-magic
