# Color
git config color.ui true
git config color.branch.current 'yellow reverse' 
git config color.branch.local 'yellow' 
git config color.branch.remote 'green' 

# Aliases
git config alias.a 'add'
git config alias.b 'branch -v'
git config alias.c 'commit -m'
git config alias.ca 'commit -am'
git config alias.co 'checkout'
git config alias.nb 'checkout -b'
git config alias.l 'log --graph --date=short'
git config alias.changes 'log --pretty=format:"%h %cr %cn %Cgreen%s%Creset" --name-status'
git config alias.short 'log --pretty=format:"%h %cr %cn %Cgreen%s%Creset"'
git config alias.changelog 'log --pretty=format:" * %s"'
git config alias.t 'tag -n'

# Format
git config format.pretty 'format:%C(blue)%ad%Creset %C(yellow)%h%C(green)%d%Creset %C(blue)%s %C(magenta) [%an]%Creset'

# Merge
git config merge.summary true
git config merge.verbosity 1

# Push
git config push.default tracking
