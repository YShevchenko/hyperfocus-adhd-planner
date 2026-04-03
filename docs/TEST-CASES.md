# HyperFocus Detailed Test Cases

**Document:** TEST-CASES.md  

## 1. Task Generation (TC-100)
### TC-101: Known Task Match
1. Type "Clean Kitchen".
2. **Expected:** The app loads the specific 10-step template for kitchen cleaning from the SQLite DB.

### TC-102: Custom Task Fallback
1. Type "Write TPS Report".
2. **Expected:** The app loads the generic 3-step "Getting Started" template.

## 2. Focus Mode (TC-200)
### TC-201: One Thing Isolation
1. Start "Clean Kitchen".
2. **Expected:** Only step 1 is visible. Step 2 cannot be seen by scrolling.

### TC-202: Time Blindness Audio (Premium)
1. Enable "Chime every 5 mins".
2. Lock the device.
3. Wait 5 minutes.
4. **Expected:** A chime plays through the device speakers.

## 3. Extended Task & Focus Tests (TC-100/200 continued)

### TC-103: Select Pre-Built Task — Immediate First Step
1. Unlock Premium (to access the task template database).
2. Search for "Clean the Kitchen" in the task browser.
3. Tap to select it.
4. **Expected:** The app immediately enters One Thing Mode and displays the first micro-step (e.g., "Clear the countertops"). No loading screen or delay > 1 second. The full step list is not visible — only the current step.

### TC-104: Complete Micro-Step — Haptic Feedback and Advancement
1. Start the "Clean the Kitchen" task (10 steps).
2. Read Step 1 and tap the oversized "Done" button.
3. **Expected:** A satisfying haptic vibration fires immediately on tap. A celebratory sound effect plays. Step 1 is marked complete and Step 2 appears on screen. A progress indicator updates (e.g., "2 of 10").

### TC-105: Complete All Steps — Celebration Screen
1. Start a task with 3 steps (e.g., a custom task or short template).
2. Complete all 3 steps by tapping "Done" for each.
3. **Expected:** After the final "Done" tap, a celebration screen appears with confetti or equivalent animation. The screen shows completion stats: task name, number of steps completed, and total time elapsed. An option to return to the home screen is presented.

### TC-106: Custom Task — Generic Getting Started Framework
1. On the home screen, type a custom task: "Write Essay".
2. Confirm the task entry.
3. **Expected:** Since "Write Essay" is not in the pre-built database, the app generates a generic 3-step "Getting Started" sequence (e.g., "1. Gather your materials", "2. Set a 5-minute timer", "3. Write the first sentence"). The focus mode begins with Step 1.

### TC-107: One Thing Mode — UI Isolation
1. Start any task and enter One Thing Mode.
2. Attempt to scroll, swipe, or find any other UI elements (navigation bar, tab bar, settings).
3. **Expected:** Only the current micro-step text, the pie timer, and the "Done" button are visible. All navigation, menus, and extraneous UI elements are hidden. The user cannot accidentally navigate away without explicitly tapping "Pause" or "Quit".

### TC-108: Time-Blindness Pie Timer
1. Start a task where the current micro-step has an estimated time of 2 minutes.
2. Observe the pie-chart timer on screen.
3. Wait the full 2 minutes.
4. **Expected:** The pie chart starts empty (or full, depending on design) and fills (or depletes) over the 2-minute interval. The animation is smooth and continuous. When the 2 minutes elapse, the pie is fully filled/depleted and a gentle nudge (haptic or visual pulse) indicates time is up. The step is not auto-advanced — the user must tap "Done".

### TC-109: Premium Gate — Task Template Database
1. On a free-tier account, navigate to the task browser / template library.
2. Attempt to browse or select a pre-built task template.
3. **Expected:** A paywall modal appears presenting the $14.99 one-time Premium unlock. The template database content is not accessible. Dismissing the paywall returns the user to the home screen. The custom task entry field remains available on free tier.

### TC-110: Premium Gate — Time Blindness Audio
1. On a free-tier account, start a task and enter One Thing Mode.
2. Attempt to enable "Time Blindness Audio" (chime/spoken time feature).
3. **Expected:** A paywall modal appears presenting the $14.99 one-time Premium unlock. The audio feature does not activate. Dismissing the paywall returns to One Thing Mode with the pie timer still functional (visual timer is free).

### TC-111: Time Blindness Audio — Spoken Time Announcement
1. Unlock Premium.
2. Start a task and enable "Speak time every 10 minutes".
3. Lock the device and wait 10 minutes.
4. **Expected:** At the 10-minute mark, a spoken voice announces the current time (e.g., "It's 2:30 PM"). The audio plays through the device speaker even while the app is backgrounded or the screen is locked. A second announcement occurs at the 20-minute mark.

### TC-112: Abandon Task Mid-Way — Progress Saved
1. Start a 10-step task and complete Steps 1 through 4.
2. Tap "Quit" or "Pause" to abandon the session.
3. Return to the home screen.
4. **Expected:** The abandoned task appears in a "Continue" or "In Progress" section on the home screen showing "4 of 10 steps completed". Tapping it resumes from Step 5 — the 4 completed steps are not repeated.

### TC-113: App Killed During One Thing Mode — Progress Persists
1. Start a 10-step task and complete Steps 1 through 6.
2. Force-kill the app from the app switcher (do not tap Quit).
3. Relaunch the app.
4. **Expected:** The app detects the interrupted session and offers to resume. Tapping "Resume" returns to Step 7 with 6 steps marked complete. No progress is lost.

### TC-114: Search Task Templates by Keyword
1. Unlock Premium.
2. Open the task template browser.
3. Type "laundry" in the search bar.
4. **Expected:** Templates related to laundry appear in the results (e.g., "Do the Laundry", "Fold Clothes"). Unrelated templates (e.g., "Clean the Kitchen", "File Taxes") are filtered out. Results update as the user types.

### TC-115: Complete Multiple Tasks — History Log
1. Complete 5 different tasks in one session (use short custom tasks for speed).
2. Navigate to the History / Completed Tasks screen.
3. **Expected:** All 5 completed tasks appear in the history log with task names, completion timestamps, step counts, and time elapsed for each. The most recent completion appears first. The history persists across app restarts.

### TC-116: Restore Purchases on New Device
1. Complete a Premium purchase on Device A via RevenueCat.
2. Install the app on Device B using the same Apple ID / Google account.
3. Launch the app on Device B and tap "Restore Purchases".
4. **Expected:** The Premium unlock is restored. The task template database and Time Blindness Audio features become accessible. No second payment is required. The restore works in Airplane Mode if the purchase was previously validated.