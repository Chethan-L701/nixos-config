
set -U wallpaper "/etc/nixos/wallpapers/purple.jpg"

# Special
set -U background '#040309'
set -U foreground '#bbabd2'
set -U cursor '#bbabd2'

# Colors
set -U color0 '#040309'
set -U color1 '#372A94'
set -U color2 '#5A37B2'
set -U color3 '#7452A3'
set -U color4 '#5838CF'
set -U color5 '#B46D9F'
set -U color6 '#8658AA'
set -U color7 '#bbabd2'
set -U color8 '#827793'
set -U color9 '#372A94'
set -U color10 '#5A37B2'
set -U color11 '#7452A3'
set -U color12 '#5838CF'
set -U color13 '#B46D9F'
set -U color14 '#8658AA'
set -U color15 '#bbabd2'

# Shell colors
set -U fish_color_normal normal
set -U fish_color_command 372A94
set -U fish_color_param B46D9F
set -U fish_pager_color_completion
set -U fish_pager_color_description  yellow
set -U fish_pager_color_progress brwhite --background=cyan
set -U fish_color_history_current --bold

# FZF colors
set -gx FZF_DEFAULT_OPTS "

    

    

    
    --color fg:7,bg:0,hl:1,fg+:232,bg+:1,hl+:255
    --color info:7,prompt:2,spinner:1,pointer:232,marker:1

--color fg:7,bg:0,hl:1,fg+:232,bg+:1,hl+:255
--color info:7,prompt:2,spinner:1,pointer:232,marker:1

    --color fg:7,bg:0,hl:1,fg+:232,bg+:1,hl+:255
    --color info:7,prompt:2,spinner:1,pointer:232,marker:1

--color fg:7,bg:0,hl:1,fg+:232,bg+:1,hl+:255
--color info:7,prompt:2,spinner:1,pointer:232,marker:1

    --color fg:7,bg:0,hl:1,fg+:232,bg+:1,hl+:255
    --color info:7,prompt:2,spinner:1,pointer:232,marker:1

--color fg:7,bg:0,hl:1,fg+:232,bg+:1,hl+:255
--color info:7,prompt:2,spinner:1,pointer:232,marker:1
"

