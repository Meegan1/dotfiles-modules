{
  homeModules.tmux =
    {
      pkgs,
      ...
    }:
    {
      programs.tmux = {
        enable = true;
        # Override with jixiuf fork to support kitty keys
        package = (pkgs.callPackage ./packages/tmux.nix { });
        terminal = "tmux-256color";
        keyMode = "vi";
        plugins = with pkgs; [
          tmuxPlugins.better-mouse-mode
          {
            plugin = tmuxPlugins.catppuccin;
            extraConfig = ''

              # Configure the catppuccin plugin
              set -g @catppuccin_flavor "macchiato"
              set -g @catppuccin_window_status_style "rounded"
              # leave this unset to let applications set the window title
              set -g @catppuccin_window_text " #W"
              set -g @catppuccin_window_default_text " #W"
              set -g @catppuccin_window_current_text " #W"
              set -g @catppuccin_window_status "icon"
              # set -g @catppuccin_window_current_background "#{@thm_lavender}"
              # Make the status line pretty and add some modules
              set -g status-left ""
              set -g status-right "#{E:@catppuccin_status_user}"
              set -ag status-right "#{E:@catppuccin_status_directory}"
            '';
          }
        ];
        extraConfig = ''
          set -g mouse on
          # set -s copy-command 'xsel -i'
          set -g set-clipboard on
          set -s kitty-keys always
          set -as terminal-features '*:kitkeys:clipboard'
          set -g allow-passthrough on

          # Ensure escape time is 0 to avoid delay in key bindings
          set -s escape-time 0

          # Set index base for windows to 1 instead of 0
          set -g base-index 1
          # Renumber windows when a window is closed
          set -g renumber-windows on

          # Bind hjkl to move between panes
          bind h if -F '#{pane_at_left}'   ''' 'select-pane -L'
          bind j if -F '#{pane_at_bottom}' ''' 'select-pane -D'
          bind k if -F '#{pane_at_top}'    ''' 'select-pane -U'
          bind l if -F '#{pane_at_right}'  ''' 'select-pane -R'

          bind-key -n M-a 'switch-client -Ttmux-pane-resize'
          # Bind alt + hjkl to resize panes
          bind -Ttmux-pane-resize -r h resize-pane -L 5
          bind -Ttmux-pane-resize -r j resize-pane -D 5
          bind -Ttmux-pane-resize -r k resize-pane -U 5
          bind -Ttmux-pane-resize -r l resize-pane -R 5

          # Send ctrl + hjkl to terminal
          bind -n C-h send-keys C-h
          bind -n C-j send-keys C-j
          bind -n C-k send-keys C-k
          bind -n C-l send-keys C-l

          # Send alt + hjkl to terminal
          bind -n M-h send-keys M-h
          bind -n M-j send-keys M-j
          bind -n M-k send-keys M-k
          bind -n M-l send-keys M-l

          is_vim="ps -o state= -o comm= -t '#{pane_tty}' \
              | grep -iqE '^[^TXZ ]+ +(\\S+\\/)?g?(view|ssh|l?n?vim?x?|fzf)(diff)?$'"

          # '@pane-is-vim' is a pane-local option that is set by the plugin on load,
          # and unset when Neovim exits or suspends; note that this means you'll probably
          # not want to lazy-load smart-splits.nvim, as the variable won't be set until
          # the plugin is loaded
          # Add <ctrl-w> table
          bind-key -n C-w if -F "$is_vim" 'send-keys C-w' 'switch-client -Tpane-select'
          bind-key -n M-w if -F "$is_vim" 'send-keys M-w' 'switch-client -Tpane-resize'

          # bind-key -n C-b 'switch-client -Twindow-switch'
          # bind-key -n M-b 'switch-client -Twindow-swap'

          # Smart pane switching with awareness of Neovim splits.
          bind-key -Tpane-select h if -F "$is_vim" { send-keys h } { if -F '#{pane_at_left}'   ''' 'select-pane -L' }
          bind-key -Tpane-select j if -F "$is_vim" { send-keys j } { if -F '#{pane_at_bottom}' ''' 'select-pane -D' }
          bind-key -Tpane-select k if -F "$is_vim" { send-keys k } { if -F '#{pane_at_top}'    ''' 'select-pane -U' }
          bind-key -Tpane-select l if -F "$is_vim" { send-keys l } { if -F '#{pane_at_right}'  ''' 'select-pane -R' }

          # Smart pane resizing with awareness of Neovim splits.
          bind-key -r -Tpane-resize h if -F "$is_vim" 'send-keys h' 'resize-pane -L 5'
          bind-key -r -Tpane-resize j if -F "$is_vim" 'send-keys j' 'resize-pane -D 5'
          bind-key -r -Tpane-resize k if -F "$is_vim" 'send-keys k' 'resize-pane -U 5'
          bind-key -r -Tpane-resize l if -F "$is_vim" 'send-keys l' 'resize-pane -R 5'

          # Vi copy mode pane switching
          bind-key -T copy-mode-vi C-w switch-client -Tpane-select

          # Vi copy mode pane resizing
          bind-key -T copy-mode-vi M-w switch-client -Tpane-resize

          # Move windows left/right with h/l
          bind-key -Twindow-switch h if -F '#{window_index}' 'previous-window'
          bind-key -Twindow-switch l if -F '#{window_index}' 'next-window'

          # Swap windows left/right with H/L and follow the window
          bind-key -Twindow-swap -r h if -F '#{>:#{window_index},1}' 'swap-window -d -t -1' '''
          bind-key -Twindow-swap -r l if -F '#{<:#{window_index},#{session_windows}}' 'swap-window -d -t +1' '''

          # Bind r to reload tmux configuration
          bind r source-file ~/.config/tmux/tmux.conf \; display-message "Reloaded tmux configuration"

          set -g prefix C-a
          unbind-key C-b
          bind-key C-a send-prefix

          # Rename window to the "current directory - application"
          set-option -g status-interval 5
          set-option -g automatic-rename on
          set-option -g automatic-rename-format '#{b:pane_current_path} - #{b:pane_current_command}'
          set -g default-command "${pkgs.zsh}/bin/zsh"
        '';
      };
    };
}
