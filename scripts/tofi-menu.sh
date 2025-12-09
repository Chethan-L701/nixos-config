if [ "$DESKTOP_SESSION" == "niri" ]; then
    program=$(tofi-run -c $HOME/.config/tofi/config)
    if [ -n "$program" ]; then
        niri msg action spawn -- $program
    fi
fi
