set -g fish_greeting
# set -x http_proxy http://127.0.0.1:7890
# set -x https_proxy http://127.0.0.1:7890
set -x EDITOR nvim
if status is-interactive
    alias clrprxy 'export http_proxy="" && export https_proxy=""'
    source "$HOME/.cargo/env.fish"
    starship init fish | source
end

# List Directory
alias ls="eza --icons"
alias l="ls -l"
alias la="ls -a"
alias lla="ls -la"
alias lt="ls --tree"

alias cat="bat"

# Handy change dir shortcuts
abbr .. 'cd ..'
abbr ... 'cd ../..'
abbr .3 'cd ../../..'
abbr .4 'cd ../../../..'
abbr .5 'cd ../../../../..'

# Always mkdir a path (this doesn't inhibit functionality to make a single dir)
abbr mkdir 'mkdir -p'

zoxide init fish | source



function yy
    set tmp (mktemp -t "yazi-cwd.XXXXXX")
    yazi $argv --cwd-file="$tmp"
    if set cwd (cat -- "$tmp"); and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
        cd -- "$cwd"
    end
    rm -f -- "$tmp"
end

nvm use --silent 22


function export_conf_keys
    set -l file $argv[1]
    while read -l line
        # Skip empty lines and comments
        if string match -qr '^\s*$' -- $line; or string match -qr '^\s*#' -- $line
            continue
        end
        
        # Split the line into key and value
        set -l parts (string split '=' -- $line)
        if test (count $parts) -eq 2
            set -l key (string trim $parts[1])
            set -l value (string trim $parts[2])
            # Export the key-value pair as an environment variable
            set -gx $key $value
        end
    end < $file
end

# Usage: export_conf_keys /path/to/keys.conf


export_conf_keys ~/setup/keys.conf

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH
# anyconnect
alias uchivpn="/opt/cisco/anyconnect/bin/vpnui"

# use neovim as manpager
export MANPAGER='nvim +Man!'
