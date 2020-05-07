#!/bin/bash

#string="$(</dev/stdin)"
#echo $string > /tmp/clip
#sed -i '${/^$/d;}' /tmp/clip
#sed -i '$s/\r//g' /tmp/clip
#echo -n "$string" | sed 's/$'"/`echo \\\r`/" | ssh -p2222 localhost 'cat > /dev/clipboard'
#echo -n "$string" | ssh -p2222 localhost 'cat > /dev/clipboard'
#echo -n "$string" | xsel -b
#xsel -b </dev/stdin
#xclip -rmlastnl </dev/stdin
if [[ ! -z "$DISPLAY" ]]; then
  xclip </dev/stdin
elif [[ "$CLIENT" = "termux" ]]; then
  string="$(</dev/stdin)"
  echo -n "$string" | ssh -p8022 u0_a311@localhost 'cat | termux-clipboard-set'
else
  echo "No clipboard sync method" && exit 0
fi
