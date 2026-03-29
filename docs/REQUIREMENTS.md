# REQUIREMENTS.md

## 1. Introduction

This document defines the functional requirements for the ADHD-native planner described in [SPEC.md](/Users/yts/lab/planned/adhd-planner/docs/SPEC.md).

It converts the product vision, principles, and intended user experience into explicit statements of required system behavior.

The purpose of this document is to specify what the product shall do, what workflows it shall support, what rules shall govern behavior, and what product capabilities shall exist in the implemented system.

This document is intended to support:

- product scope definition
- design validation
- engineering implementation
- QA traceability
- maintenance and change review

This document covers functional requirements only.

It defines required user-facing behavior, system responses, workflow logic, feature responsibilities, and application rules.

It does not serve as the primary source for:

- non-functional quality attributes
- detailed UI design guidance
- architecture decisions
- data schema design details
- test execution procedures

Those concerns are defined in companion documents, including:

- `NFR.md`
- `UI-UX.md`
- `ARCHITECTURE.md`
- `DATA-MODEL.md`
- `TEST-PLAN.md`
- `TEST-CASES.md`

This document shall be interpreted in the context of the product's ADHD-native philosophy.

Accordingly, the functional requirements in this document are expected to preserve the product's core intent:

- reduce activation energy
- reduce overwhelm and shame
- support recovery after interruption
- make next actions clearer
- prioritize momentum over rigid compliance

Unless explicitly stated otherwise, every requirement in this document applies to the intended shipped product behavior rather than to exploratory ideas, optional experiments, or aspirational concepts.

Where a conflict exists between broad descriptive language in the specification and an explicit requirement in this document, the explicit requirement in this document shall govern functional interpretation unless later superseded by an approved revision.

## 2. Requirement Numbering and Statement Conventions

Each formal functional requirement in this document shall use a unique identifier in the following format:

`REQ-XXX`

In this format:

- `REQ` designates a functional requirement
- `XXX` is a zero-padded numeric identifier

Examples of valid identifiers include:

- `REQ-001`
- `REQ-002`
- `REQ-010`
- `REQ-125`

Each identifier is permanent once assigned.

An identifier shall not be reused for a different requirement, even if the original requirement is removed, merged, replaced, or retired.

If a requirement is deprecated or withdrawn, its identifier shall remain reserved for traceability.

The preferred normative statement form is:

`REQ-XXX: The system shall ...`

Equivalent mandatory phrasing may be used where necessary for readability, provided the requirement remains explicit, testable, and unambiguous.

Preferred normative language includes:

- `shall` for mandatory behavior
- `shall not` for prohibited behavior
- `must` only where it improves clarity without weakening mandatory meaning

Requirement statements should avoid non-normative wording unless such wording appears in quoted source material or in clearly labeled explanatory text.

Terms that should generally be avoided inside requirement statements include:

- `may`
- `might`
- `could`
- `usually`
- `ideally`
- `etc.`

Each requirement should state one primary obligation whenever practical.

If a statement contains multiple independently testable obligations, those obligations should normally be separated into distinct requirement identifiers.

Each requirement should be:

- specific
- observable
- testable
- implementation-neutral where practical
- consistent with the specification
- stable enough to support cross-document traceability

Requirement numbering is an identification mechanism only.

It does not imply implementation order, release order, business priority, or technical dependency.

Requirement identifiers are used for:

- traceability across design, architecture, and testing artifacts
- review and change discussion
- implementation planning references
- defect reporting against intended behavior
- cross-document linking

Dependencies between requirements shall be stated explicitly in requirement text or supporting notes when needed.

Dependencies shall not be inferred from identifier proximity or sequence.

Supporting notes, rationale, examples, or clarifications may appear beneath a requirement as non-numbered text.

Such supporting text is informative unless it is itself expressed as a formal requirement identifier.

Only statements labeled with a `REQ-XXX` identifier shall be treated as formal functional requirements for traceability and downstream test-case mapping.
