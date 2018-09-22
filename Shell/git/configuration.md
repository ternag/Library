# Configure git

To view current configuration use either:

    git config --global --list
    git config --local --list

*global* configuration applies to all repositories on your computer.<br>
*local* configuration applies to the specific repository you are in.

*local* configuration have precedence over *global* configuration.

I the following examples use either `--global` or `--local` as you see fit.

## Editing configuration

To set a specific variable, use:

    git config --global <variable-name> <value>

    f.ex.

    git config --global user.name "Terje Nagel"
    git config --global user.email terje.nagel@gmail.com

To unset a variable in, say global config, use:

    git config --global --unset <variable-name>

To edit gitconfig file in default editor use either:

    git config --global --edit
    git config --local --edit

## Aliases

Aliases are short versions of git commands. Usually used with frequently used commands.

To add an alias from commandline use:

    git config --global alias.sts status

If command line arguments are needed place alias in quotes, like this:

    git config --global alias.l2 "log --oneline -20"

above *git command alias* can be used like this:

    > git l2

If editing the configuration in an editor add an `[alias]` section in th file.

Examples:

    [alias]
        sts = status
        l2 = log --oneline -20
        l4 = log --oneline -40
        lol = log --oneline --graph -40
        ru = remote update
