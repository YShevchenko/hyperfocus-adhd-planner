# HyperFocus Requirements

**Document:** REQUIREMENTS.md  
**Product:** HyperFocus  
**Publisher:** Heldig Lab  
**Source of Truth:** [SPEC.md](./SPEC.md)  

## Purpose

This document enumerates the functional requirements (FR) and high-level non-functional requirements (NFR) for HyperFocus (v1.0).

---

## 1. Functional Requirements

### 1.1 Paralysis Breaker (Task Breakdown) (FR-001 to FR-010)

| ID | Requirement | Priority |
|---|---|---|
| FR-001 | The system shall allow users to search a local database of pre-defined overwhelming tasks. | High |
| FR-002 | The system shall map a selected task to a pre-defined sequence of micro-steps. | High |
| FR-003 | If a custom task is entered, the system shall provide a generic 3-step "Getting Started" sequence. | High |
| FR-004 | The system shall allow users to manually enter their own micro-steps for a custom task. | High |

### 1.2 "One Thing" Focus Mode (FR-011 to FR-020)

| ID | Requirement | Priority |
|---|---|---|
| FR-011 | The focus mode shall display only *one* micro-step on the screen at a time, hiding all other UI elements. | High |
| FR-012 | The focus mode shall feature an oversized "Done" button to advance to the next step. | High |
| FR-013 | Advancing a step shall trigger a highly satisfying haptic vibration and sound effect (dopamine hit). | High |
| FR-014 | The focus mode shall include a visual pie-chart timer representing the estimated time for the current micro-step. | High |
| FR-015 | The system shall allow the user to pause, skip, or quit the session at any time without punitive messaging. | High |

### 1.3 Time Blindness Tools (FR-021 to FR-030)

| ID | Requirement | Priority |
|---|---|---|
| FR-021 | The system shall provide an optional background audio feature that chimes or speaks the time every 5, 10, or 15 minutes. | Medium |
| FR-022 | The audio feature shall continue running even if the app is backgrounded or the screen is locked. | High |

### 1.4 Premium Features (FR-031 to FR-040)

| ID | Requirement | Priority |
|---|---|---|
| FR-031 | The system shall lock the pre-defined `task_templates` database behind a $14.99 one-time Premium unlock. | High |
| FR-032 | The system shall lock the "Time Blindness Audio" feature behind the Premium unlock. | High |
| FR-033 | The system shall validate the Premium unlock locally via RevenueCat without requiring a user account. | High |

---

## 2. Non-Functional Requirements (High-Level)

| ID | Category | Requirement |
|---|---|---|
| NFR-001 | **Privacy** | **Zero-Backend:** No tasks, behaviors, or usage data shall ever be transmitted to Heldig Lab servers. |
| NFR-002 | **Monetization** | Freemium with a single $14.99 non-consumable unlock. No subscriptions ("No ADHD Tax") or ads. |
| NFR-003 | **Offline** | 100% of the application's features must work in Airplane Mode. |
| NFR-004 | **Accessibility** | The UI must use massive touch targets and simple fonts. Visual noise must be actively suppressed. |
| NFR-005 | **Tone** | The app's copywriting must be empathetic, non-judgmental, and highly forgiving. |
