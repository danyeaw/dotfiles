function activate-conda --wraps='eval /home/dan/miniconda3/bin/conda "shell.fish" "hook" $argv | source' --wraps='eval ~/miniconda3/bin/conda "shell.fish" "hook" $argv | source' --description 'alias activate-conda eval ~/miniconda3/bin/conda "shell.fish" "hook" $argv | source'
  eval ~/miniconda3/bin/conda "shell.fish" "hook" $argv | source $argv
        
end
