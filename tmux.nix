{ pkgs, ... }:

{
  programs.tmux = {
    enable = true;
    terminal = "tmux-256color";

    extraConfig = ''
      # set colors correctly with tmux and alacritty
      set -ag terminal-overrides ",xterm-256color:RGB"

      # set prefix key to control-space
      unbind-key C-b
      set-option -g prefix C-Space
      bind-key C-Space send-prefix

      # split windows
      unbind %
      unbind '"'

      # source config
      unbind r
      bind-key r source-file ~/.config/tmux/tmux.conf \; display-message "tmux config reloaded"

      # select panes (with tab switching fallback for h and l)
      bind j select-pane -D
      bind k select-pane -U
      bind l if-shell '[ $(tmux display-message -p "#{pane_at_right}") -eq 1 ]' 'next-window' 'select-pane -R'
      bind h if-shell '[ $(tmux display-message -p "#{pane_at_left}") -eq 1 ]' 'previous-window' 'select-pane -L'

      # mouse on
      set -g mouse on

      # copy mode
      unbind [
      bind c copy-mode
      set-window-option -g mode-keys vi
      bind-key -T copy-mode-vi e send-keys -X cancel \; run-shell 'tmux capture-pane -p -S -100000 > /tmp/tmux-screen-$$ && tmux new-window -n "screen-edit" "nvim /tmp/tmux-screen-$$; rm /tmp/tmux-screen-$$"'

      # clipboard pass through
      set -g set-clipboard on

      # pane splitting with prefix + s + v/h (preserves current directory)
      bind n split-window -h -c "#{pane_current_path}"
      bind N split-window -v -c "#{pane_current_path}"

      # tab (window) management with prefix + t
      bind t switch-client -T tab-table
      bind -T tab-table n new-window -c "#{pane_current_path}"
      bind -T tab-table x kill-window

      # session management with prefix + m
      bind m switch-client -T session-table
      bind -T session-table s choose-session
      bind -T session-table l switch-client -l
      bind -T session-table n command-prompt -p "New session name:" "new-session -d -s '%1'; switch-client -t '%1'"
      setw -g mode-style 'fg=color232 bg=color255 bold'

      # statusbar
      set -g status-position top
      set -g status-justify left
      set -g status-style 'fg=color255'
      set -g status-left ' '
      set -g status-right ' '
      set -ag status-right '#{pane_current_path}'
      set -ag status-right ' | '
      set -ag status-right '%Y-%m-%d %H:%M '
      set -g status-right-length 100
      set -g status-left-length 10
      setw -g window-status-current-style 'fg=default bg=default bold'
      setw -g window-status-current-format ' #I #W #F '

      # messages
      set -g message-style 'fg=color3 bg=default bold'
    '';
  };
}

