#!/data/data/com.termux/files/usr/bin/bash

# fooli.sh v1.5.4 — Final Lock Edition

mkdir -p ~/fooli_logs
mkdir -p ~/.fooli/nescafe_pool

LOG_PATH=~/fooli_logs
TERMUX_PATH=/data/data/com.termux/files/home/storage/shared/fooli_logs
mkdir -p "$TERMUX_PATH"

# Count entries
ENTRY_COUNT=$(find "$LOG_PATH" -maxdepth 1 -name "*.txt" | wc -l)

# Build and display magenta novel battery with count underneath
NOVEL_SIZE=2000
BLOCKS_FULL=$((ENTRY_COUNT / 100))

MAGENTA=$(tput setaf 5)
RESET=$(tput sgr0)

echo ""
echo "    [::::::] fooli.sh"
echo "    a shell script for slow"
echo "    writing in fast systems"
echo ""
echo -n "novel battery: ["
for ((i=0; i<20; i++)); do
  if [ $i -lt $BLOCKS_FULL ]; then
    printf "${MAGENTA}█${RESET}"
  else
    printf "░"
  fi
done
echo "]"
echo "$ENTRY_COUNT / $NOVEL_SIZE"
echo ""

# Show last entry
LAST_ENTRY=$(ls "$LOG_PATH" | sort | tail -n 1)
if [ -n "$LAST_ENTRY" ]; then
  echo "[>>] Last entry:"
  cat "$LOG_PATH/$LAST_ENTRY"
  echo ""
fi

# Show random past fragment
RANDOM_ENTRY=$(ls "$LOG_PATH" | shuf -n 1)
if [ -n "$RANDOM_ENTRY" ]; then
  echo "[*] A fragment returns:"
  cat "$LOG_PATH/$RANDOM_ENTRY"
  echo ""
fi

echo "[1] Observation"
echo "[2] Obedience"
echo "[3] Confession"
echo ""
read -p "Choose your mode: " MODE
read -p "Write your fragment: " TEXT

# Save the entry
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
FILENAME="$TIMESTAMP.txt"
echo "[$MODE] $TEXT" > "$LOG_PATH/$FILENAME"
cp "$LOG_PATH/$FILENAME" "$TERMUX_PATH/$FILENAME"

echo "[✓] Saved: $FILENAME"

# Optional: Nescafe unlock notice
if [ "$ENTRY_COUNT" -eq 2000 ]; then
  echo ""
  echo "[!!] Nescafe ritual is now available. Run ./nescafe to export your novel."
  echo ""
fi

read -p "Add another? [y/N] " CONT
if [[ "$CONT" =~ ^[Yy]$ ]]; then
  exec "$0"
else
  FINAL_WORD=$(echo "$TEXT" | awk '{print $NF}')
  for i in {1..40}; do
    echo -n "f"
    sleep 0.02
  done
  echo " $FINAL_WORD"
  sleep 1
  exit
fi
