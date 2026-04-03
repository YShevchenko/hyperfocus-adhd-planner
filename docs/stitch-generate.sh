#!/bin/bash
# Script to generate ADHD Planner UI designs using Google Stitch

set -e
WORK_DIR="/Users/yts/lab/planned/adhd-planner/docs/stitch-designs"
mkdir -p "$WORK_DIR"
LOG_FILE="$WORK_DIR/generation.log"

echo "Starting Stitch Generation for ADHD Planner (HyperFocus)..." > "$LOG_FILE"
TOKEN=$(gcloud auth application-default print-access-token)
export STITCH_ACCESS_TOKEN=$TOKEN
export GOOGLE_CLOUD_PROJECT=lab-apps-490222
export PATH="/opt/homebrew/bin:$PATH"

echo "Creating project..." | tee -a "$LOG_FILE"
PROJECT_JSON=$(stitch-mcp tool create_project -d '{"title": "HyperFocus - Vibecodable"}' -o json)
PROJECT_ID=$(echo "$PROJECT_JSON" | grep -o '"name":"projects/[^"]*' | cut -d'/' -f2 | head -1)

if [ -z "$PROJECT_ID" ]; then
  echo "Failed to create project." | tee -a "$LOG_FILE"
  exit 1
fi

declare -a PROMPTS=(
  "Mobile app entry screen. Very clean, light theme. A single massive text input centered on the screen reading 'What is overwhelming you right now?'. Below it, a subtle button saying 'Or browse templates'. Lots of whitespace, calming design."
  "Mobile app list screen. Light theme. Top reads 'Clean Kitchen'. Below is a clean list of 5 tiny micro-steps like '1. Grab a trash bag', '2. Pick up visible trash'. At the very bottom, a massive blue 'Start One Thing Mode' button."
  "Mobile app focus mode screen called 'One Thing Mode'. Pure black background. In the exact center, a single giant instruction in white text: '1. Grab a trash bag.' Above it, a subtle visual pie-chart timer. At the bottom, a huge bright green 'DONE' button."
  "Mobile app celebration screen. Vibrant, joyful colors. A large 'You did it!' text with a satisfying checkmark animation graphic. A button to 'Return to Home'."
  "Mobile app settings screen. Light theme. Toggles for 'Time Blindness Audio Chime' (every 5, 10, 15 mins). A prominent section highlighting a $14.99 Premium Unlock for 300+ overwhelming task templates. Clean list layout."
)

declare -a FILENAMES=(
  "01_EntryScreen"
  "02_BreakdownList"
  "03_OneThingMode"
  "04_Celebration"
  "05_Settings"
)

for i in "${!PROMPTS[@]}"; do
  export STITCH_ACCESS_TOKEN=$(gcloud auth application-default print-access-token)
  PROMPT="${PROMPTS[$i]}"
  FILENAME="${FILENAMES[$i]}"
  
  echo "Generating Screen $((i+1))/5: $FILENAME..." | tee -a "$LOG_FILE"
  SCREEN_JSON=$(stitch-mcp tool generate_screen_from_text -d "{\"projectId\": \"$PROJECT_ID\", \"prompt\": \"$PROMPT\"}" -o json || true)
  SCREEN_ID=$(echo "$SCREEN_JSON" | grep -o '"name":"projects/[^"]*/screens/[^"]*' | cut -d'/' -f4 | head -1)
  
  if [ -n "$SCREEN_ID" ]; then
    echo "  Success! Screen ID: $SCREEN_ID" | tee -a "$LOG_FILE"
    CODE_JSON=$(stitch-mcp tool get_screen_code -d "{\"projectId\": \"$PROJECT_ID\", \"screenId\": \"$SCREEN_ID\"}" -o json || true)
    echo "$CODE_JSON" > "$WORK_DIR/$FILENAME.json"
    echo "  Saved to $FILENAME.json" | tee -a "$LOG_FILE"
  else
    echo "  Failed to generate screen. Response: $SCREEN_JSON" | tee -a "$LOG_FILE"
  fi
done
echo "All tasks completed!" | tee -a "$LOG_FILE"