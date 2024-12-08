if status is-interactive
    # Commands to run in interactive sessions can go here
end

function fish_greeting
end

export TERM=kitty
export MANPAGER='nvim +Man!'
oh-my-posh init fish --config $HOME/.config/omp/catppuccin-mocha.omp.json | source


set -Ux CARAPACE_BRIDGES 'zsh,fish,bash,inshellisense' # optional
mkdir -p ~/.config/fish/completions
carapace --list | awk '{print $1}' | xargs -I{} touch ~/.config/fish/completions/{}.fish # disable auto-loaded completions (#185)
carapace _carapace | source


alias tmux='tmux -u'
alias vi='nvim'
alias snvim='sudo -E nvim'
