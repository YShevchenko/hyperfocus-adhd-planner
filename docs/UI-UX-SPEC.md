# HyperFocus UI/UX Specification

**Document:** UI-UX-SPEC.md  
**Product:** HyperFocus  

## 1. Design Philosophy
- **Anti-Overwhelm:** The UI should look like a calm, empty room. Lots of whitespace.
- **Dopamine Delivery:** The act of completing a micro-step must feel physically rewarding (haptics, sound, bold color changes).

## 2. Color Palette
- **Background (Light Mode):** `#FDFBF7` (Warm, non-clinical white).
- **Background (Focus Mode):** `#111111` (Near black to eliminate peripheral vision).
- **Primary (Action):** `#4A90E2` (Calm, trustworthy blue).
- **Success:** `#2ECC71` (Vibrant green for the "Done" flash).

## 3. Screens (Vibecodable)
1. **The Entry Screen:** A single massive text input centered on the screen: "What's overwhelming you right now?"
2. **The Breakdown List (Preview):** A clean list showing the generated micro-steps. A massive "Start Focus Mode" button.
3. **One Thing Mode:** Pure black background. One giant instruction in the center. A visual pie timer. A huge "Done" button at the bottom.
4. **Completion Screen:** A celebration screen: "You did it." with a satisfying animation.
5. **Settings:** Toggles for Time Blindness Audio, Dark Mode preference, and Premium Unlock.

## Error & Edge States

- **Empty state (first launch):** Large, friendly prompt centered on screen: "What's overwhelming you right now?" This is the core interaction from SPEC.md. No chrome, no menus -- just the text input and a warm, inviting background. The keyboard opens automatically.
- **No matching template found:** "We don't have a pre-built plan for that yet. Let's break it down together." The app transitions to a generic Getting Started framework that guides the user through manually creating micro-steps for their task.
- **Task abandoned mid-way:** On returning to an in-progress task, a card appears: "You left off on step 3 of 'Clean the Kitchen'. Pick up where you left off?" Two buttons: "Resume" (returns to One Thing Mode at the current step) and "Start Over" (resets progress to step 1).
- **One Thing Mode interrupted (app backgrounded):** On return from background, the app immediately shows the current step in One Thing Mode with no navigation required. No splash screen, no dashboard -- the user sees exactly where they left off with the timer state preserved.
- **Premium paywall (gentle):** When a user taps a locked template: "You've discovered the full task library! Unlock 300+ pre-built breakdowns for $14.99. No subscription. No ADHD Tax." A primary "Unlock" button and a subtle "Not now" link. The tone is encouraging, not pushy.
- **Audio playback failure:** Toast notification: "Couldn't play the time announcement. Check your volume and try again." The timer continues running silently. The audio icon in Settings shows a warning indicator.
- **SQLite corruption:** On detection of database errors: "Something went wrong with your data. Try restarting. Your task history may need to be reset." A "Restart" button force-closes the app. If the issue persists after restart, the app offers to reset the database with a clear warning that history will be lost.