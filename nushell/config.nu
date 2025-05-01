# config.nu
# version = "0.101.0"
#
# This file is used to override default Nushell settings, define
# (or import) custom commands, or run any other startup tasks.
# See https://www.nushell.sh/book/configuration.html
#
# This file is loaded after env.nu and before login.nu
# `config nu`
#
# See `help config nu` for more options
$env.path ++= (/usr/libexec/path_helper -s |split row ";"|first 1|str trim |split row '"'|skip 1|first|split row ':')

use std/util "path add"
path add "/Applications/Xcode.app/Contents/Developer/usr/bin"
path add "~/go/bin"
path add "~/.cargo/bin"

# where to source/use custom code, like completions, from
const NU_LIB_DIRS = [
  '~/.nu/'
]

source "site-settings.nu"
mkdir ($nu.data-dir | path join "vendor/autoload")
starship init nu | save -f ($nu.data-dir | path join "vendor/autoload/starship.nu")
jj util completion nushell | save -f ($nu.data-dir | path join "vendor/autoload/jj.nu")

$env.config.buffer_editor = "hx"
$env.config.show_banner = false
$env.config.use_kitty_protocol = true

alias vi = hx
alias ll = ls

$env.RIPGREP_CONFIG_PATH = $env.Home | path join ".config/ripgreprc"
$env.HOMEBREW_NO_EMOJI = 1

