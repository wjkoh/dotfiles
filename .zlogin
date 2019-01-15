#
# Executes commands at login post-zshrc.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Execute code that does not affect the current session in the background.
{
  # Compile the completion dump to increase startup speed.
  zcompdump="${ZDOTDIR:-$HOME}/.zcompdump"
  if [[ -s "$zcompdump" && (! -s "${zcompdump}.zwc" || "$zcompdump" -nt "${zcompdump}.zwc") ]]; then
    zcompile "$zcompdump"
  fi
} &!

# Print a random, hopefully interesting, adage.
if [ -x "$(command -v cowsay)" -a -x "$(command -v fortune)" ]; then
  fortune | cowsay
else
  echo "Error: fortune or cowsay not found."
fi

renew_gcert_if_needed() {
  if ! [ -x "$(command -v gcertstatus)" -a -x "$(command -v ~/bin/auth-refresh-gtunnel.py)" ]; then
    echo "Error: gcertstatus or ~/bin/auth-refresh-gtunnel.py not found."
    return
  fi

  HOURS_TILL_EOB=$((20 - $(date +%-H)))h
  if [[ ${CORP_WORKSTATIONS[(r)$(hostname)]} == $(hostname) ]]; then
    gcertstatus -ssh_cert_comment=corp/normal -check_remaining=$HOURS_TILL_EOB || prodaccess
  else
    gcertstatus -ssh_cert_comment=corp/normal -check_remaining=$HOURS_TILL_EOB || ~/bin/auth-refresh-gtunnel.py ${CORP_WORKSTATIONS}
  fi
}

# Do not call this function inside of `~/.at_google` check because a corp laptop
# doesn't have .at_google.
if [ -f ~/.at_google ]; then
  renew_gcert_if_needed
fi
