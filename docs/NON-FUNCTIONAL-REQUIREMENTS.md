# HyperFocus Non-Functional Requirements

**Document:** NON-FUNCTIONAL-REQUIREMENTS.md  
**Product:** HyperFocus  

## 1. Privacy & Security (NFR-100)
- **NFR-101 (Zero-Knowledge):** No task data shall leave the device.
- **NFR-102 (No Accounts):** The app must function fully anonymously.

## 2. Performance (NFR-200)
- **NFR-201 (Search Latency):** The local SQL search for task templates must resolve in < 100ms so the user doesn't lose focus.
- **NFR-202 (Cold Start):** The app must launch instantly (< 0.8s) to capture the user's fleeting motivation.

## 3. Usability (NFR-300)
- **NFR-301 (Visual Noise Reduction):** The "One Thing Mode" must hide the device status bar (clock/battery) to prevent distraction.
- **NFR-302 (Haptics):** Haptic feedback must be crisp and satisfying (using `UIImpactFeedbackGenerator` style heavy impacts).