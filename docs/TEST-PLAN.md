# HyperFocus Test Plan

**Document:** TEST-PLAN.md  

## 1. Strategy
The primary risk is the app becoming another source of anxiety. Testing focuses on **Frictionless Onboarding** and **Background Audio Reliability**.

## 2. Testing Tiers
- **Unit Tests:** Test the heuristic fallback logic when a custom task is entered.
- **Integration Tests:** SQLite DB read speeds for template searching.
- **E2E Tests:** Ensure the "One Thing Mode" transitions correctly between steps.
- **Manual QA:** The "Time Blindness Audio" must fire accurately every 5/10/15 minutes even when the device is locked.