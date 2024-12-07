if status is-interactive
    # Commands to run in interactive sessions can go here
end

function fish_greeting
end

alias tmux='tmux -u'
export TERM=kitty
export MANPAGER='nvim +Man!'
oh-my-posh init fish --config $HOME/.config/omp/catppuccin-mocha.omp.json | source
