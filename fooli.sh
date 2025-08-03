#!/data/data/com.termux/files/usr/bin/bash

# fooli.sh — a shell script for slow writing in fast systems

mkdir -p ~/fooli_logs
mkdir -p ~/.fooli/nescafe_pool

LOG_PATH=~/fooli_logs
TERMUX_PATH=/data/data/com.termux/files/home/storage/shared/fooli_logs

mkdir -p "$TERMUX_PATH"

BATTERY_SIZE=100
ENTRY_COUNT=$(ls "$LOG_PATH" | wc -l)
BATTERIES_FULL=$((ENTRY_COUNT / BATTERY_SIZE))

clear
echo ""
echo "    [::::::] fooli.sh"
echo "    a shell script for slow writing in fast systems"
echo "    battery: $BATTERIES_FULL/20 (each = 100 entries)"
echo ""

# Show previous entry if exists
LAST_ENTRY=$(ls "$LOG_PATH" | sort | tail -n 1)
if [ -n "$LAST_ENTRY" ]; then
  echo "[>>] Last entry:"
  echo "----------------------"
  cat "$LOG_PATH/$LAST_ENTRY"
  echo "----------------------"
fi

# Rotate a random old entry as prompt
RANDOM_ENTRY=$(ls "$LOG_PATH" | shuf -n 1)
if [ -n "$RANDOM_ENTRY" ]; then
  echo "[*] A fragment returns:"
  cat "$LOG_PATH/$RANDOM_ENTRY"
fi

echo ""
echo "[1] Observation"
echo "[2] Obedience"
echo "[3] Confession"
echo ""
read -p "Choose your mode: " MODE
read -p "Write your fragment: " TEXT

TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
FILENAME="$TIMESTAMP.txt"

echo "[$MODE] $TEXT" > "$LOG_PATH/$FILENAME"
cp "$LOG_PATH/$FILENAME" "$TERMUX_PATH/$FILENAME"

echo "[✓] Saved: $FILENAME"

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

