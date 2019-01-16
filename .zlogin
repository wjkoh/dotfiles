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
  HOURS_TILL_EOB=$((20 - $(date +%-H)))
  if [[ ${CORP_WORKSTATIONS[(r)$(hostname)]} == $(hostname) ]]; then
    prodcertstatus --check_remaining_hours=${HOURS_TILL_EOB}
    if [ $? -ne 0 ]; then
      prodaccess
    fi
  else
    if ! [ -x "$(command -v gcertstatus)" -a -x "$(command -v ~/bin/auth-refresh-gtunnel.py)" ]; then
      echo "Error: gcertstatus or ~/bin/auth-refresh-gtunnel.py not found."
      return
    fi
    gcertstatus -ssh_cert_comment=corp/normal -check_remaining=${HOURS_TILL_EOB}h
    if [ $? -ne 0 ]; then
      ~/bin/auth-refresh-gtunnel.py ${CORP_WORKSTATIONS}
    fi
  fi
}

# Do not call this function inside of `~/.at_google` check because a corp laptop
# doesn't have .at_google.
renew_gcert_if_needed
