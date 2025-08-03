{
  homeModules.nushell = {
    programs.nushell = {
      enable = true;
      configFile.source = ./config.nu;
      extraConfig = ''
        let fish_completer = {|spans|
          fish --command $'complete "--do-complete=($spans | str join " ")"'
          | $"value(char tab)description(char newline)" + $in
          | from tsv --flexible --no-infer
        }


        let carapace_completer = {|spans: list<string>|
          # if the current command is an alias, get it's expansion
          let expanded_alias = (scope aliases | where name == $spans.0 | get -i 0 | get -i expansion)

          # overwrite
          let spans = (if $expanded_alias != null  {
              # put the first word of the expanded alias first in the span
              $spans | skip 1 | prepend ($expanded_alias | split row " " | take 1)
          } else { $spans })

          carapace $spans.0 nushell ...$spans
          | from json
          | if ($in | default [] | where value == $"($spans | last)ERR" | is-empty) { $in } else { null }
        }

        let zoxide_completer = {|spans|
          $spans | skip 1 | zoxide query -l ...$in | lines | where {|x| $x != $env.PWD}
        }

        # This completer will use carapace by default
        let external_completer = {|spans|
            let expanded_alias = scope aliases
            | where name == $spans.0
            | get -i 0.expansion

            let spans = if $expanded_alias != null {
                $spans
                | skip 1
                | prepend ($expanded_alias | split row ' ' | take 1)
            } else {
                $spans
            }

            match $spans.0 {
                # carapace completions are incorrect for nu
                nu => $fish_completer
                # fish completes commits and branch names in a nicer way
                git => $fish_completer
                # carapace doesn't have completions for asdf
                asdf => $fish_completer
                # use zoxide completions for zoxide commands
                __zoxide_z | __zoxide_zi => $zoxide_completer
                _ => $carapace_completer
            } | do $in $spans
        }

        $env.config = {
          completions: {
            case_sensitive: true # case-sensitive completions
            quick: true    # set to false to prevent auto-selecting completions
            partial: true    # set to false to prevent partial filling of the prompt
            algorithm: "fuzzy"    # prefix or fuzzy
            external: {
              # set to false to prevent nushell looking into $env.PATH to find more suggestions
              enable: true 
              # set to lower can improve completion performance at the cost of omitting some options
              max_results: 100 
              completer: $carapace_completer # check 'carapace_completer' 
            }
          }
        }
      '';
    };
  };
}
