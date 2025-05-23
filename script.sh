#!/bin/bash

clear

# Configura tu nombre de usuario de GitHub
GITHUB_USER="dnielpy"

SVG=$(curl -s "https://github.com/users/$GITHUB_USER/contributions")

LEVELS=$(echo "$SVG" | grep -oE 'data-level="[0-4]"' | grep -oE '[0-4]')

N=40   # Cambia este valor para más o menos semanas
LINES=$((N * 7))
LEVELS=$(echo "$LEVELS" | tail -n "$LINES")

readarray -t LEVEL_ARRAY <<< "$(echo "$LEVELS")"

map_level_to_block() {
  case "$1" in
    0) echo -n "⬜" ;;
    1) echo -n "🟩" ;;
    2) echo -n "🟨" ;;
    3) echo -n "🟧" ;;
    4) echo -n "🟥" ;;
  esac
}

echo "GitHub Contributions for $GITHUB_USER (Last $N weeks)"
echo ""

for day in {0..6}; do
  for week in $(seq 0 $((N - 1))); do
    index=$((week * 7 + day))
    level=${LEVEL_ARRAY[$index]}
    map_level_to_block "$level"
  done
  echo ""  
done
