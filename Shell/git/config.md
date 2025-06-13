
```> git config --global --edit```

```bash
[user]
    name = Terje Nagel 
    email = <email>
[core]
    autocrlf = true
    editor = code
[format]
    pretty=format:%C(yellow)%h %C(auto)%d %C(auto)%s %C(dim green bold)[by %cn %cr]%Creset
[alias]
    st = status
    sw = switch
    swc = switch -c
    aa = add -A
    br = branch
    cm = commit -m
    amend = commit --amend -m
    unstage = restore --staged
    ec = config --global -e
    co = checkout
    cob = checkout -b
    
    # alias: fetch and show the difference between local and remote
    fe = !git fetch && git log ..origin --oneline --pretty=format:'%C(yellow)%h %<(23)%C(green)%an %C(cyan)%>(32)%cD %C(dim white)%>(13)%cr %C(auto)%d %C(reset)%s'

    # log all commits between last 32 from head and origin
    lo = log head~32..origin --pretty=format:'%C(yellow)%h %<(23)%C(green)%an %C(cyan)%>(32)%cD %C(dim white)%>(13)%cr %C(auto)%d %C(reset)%s'
    # same but only commits by me
    lome = log head~32..origin --pretty=format:'%C(yellow)%h %<(23)%C(green)%an %C(cyan)%>(32)%cD %C(dim white)%>(13)%cr %C(auto)%d %C(reset)%s' --author=tna
    
    # log last 32 commits from HEAD (only local commits)
    ll = log -32 --pretty=format:'%C(yellow)%h %<(23)%C(green)%an %C(cyan)%>(32)%cD %C(dim white)%>(13)%cr %C(auto)%d %C(reset)%s'
    # same but only commits by me
    llme = log -32 --pretty=format:'%C(yellow)%h %<(23)%C(green)%an %C(cyan)%>(32)%cD %C(dim white)%>(13)%cr %C(auto)%d %C(reset)%s' --author=tna

    ## log commits including affected files
    # log last 4 commits from HEAD
    lf = log -4 --pretty=format:'%C(yellow)%h%C(auto)%d %C(yellow)%s %C(cyan)[by %cn %cD]' --decorate --numstat 
    # log last 16 commits from HEAD, but only commits by me
    lfme = log -16 --pretty=format:'%C(yellow)%h%C(auto)%d %C(yellow)%s %C(cyan)[by %cn %cD]' --decorate --numstat --author=tna
    # log all commits between last 4 from HEAD  and origin
    lfo = log head~4..origin --pretty=format:'%C(yellow)%h%C(auto)%d %C(yellow)%s %C(cyan)[by %cn %cD]' --decorate --numstat 
    # log all commits between last 16 from HEAD and origin, but only commits by me
    lfome = log head~16..origin --pretty=format:'%C(yellow)%h%C(auto)%d %C(yellow)%s %C(cyan)[by %cn %cD]' --decorate --numstat --author=tna
```
