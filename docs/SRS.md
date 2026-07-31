# Software Requirements Specification (SRS)

## 1. Purpose
Aoun is a charity and donation platform connecting donors, charities, and platform admins in Egypt, with Arabic-first UX and AI-assisted discovery and content generation.

## 2. Scope
The system consists of:
- A Flutter mobile app for donors and charities
- A React admin panel for platform administrators
- An ASP.NET Core REST API and SQL Server database
- A FastAPI AI Gateway providing chatbot, recommendation, and content-generation features

## 3. User Roles
| Role | Capabilities |
|---|---|
| **Donor** | Browse campaigns/cases, donate, calculate Zakat, favorite items, chat with AI assistant, view profile & donation history |
| **Charity** | Register (subject to admin approval), publish campaigns/cases, view dashboard stats, generate AI marketing copy |
| **Admin** | Approve/reject charities, moderate cases/campaigns, manage users, view platform-wide stats, use AI financial assistant |

> This is a condensed summary. The full **Requirements Gathering Document** (49 numbered requirements, gathered Oct 8th 2025, covering donor/charity/admin flows, Zakat rules, and AI features in detail) is maintained by the team separately and should be added here as `docs/Requirements-Gathering.md` or linked from the team's shared drive.

## 4. Functional Requirements
- **FR1** — Users can register and authenticate via email/password or social login; sessions are managed via JWT.
- **FR2** — Charities can create, update, and delete campaigns and cases, subject to admin moderation.
- **FR3** — Donors can donate to a campaign or case via Paymob; donation status must be tracked (Pending/Completed).
- **FR4** — The system calculates Zakat due based on current gold price (via GoldApi) and Islamic nisab rules.
- **FR5** — Donors can favorite campaigns/cases and view them later.
- **FR6** — The system sends notifications for key events (donation confirmation, charity approval, campaign updates).
- **FR7** — The AI Gateway provides a RAG-based chatbot, personalized recommendations, an admin financial assistant, and Arabic marketing content generation.
- **FR8** — Admins can view platform statistics and manage users, charities, and content.

## 5. Non-Functional Requirements
- **NFR1 — Security:** JWT-based auth, RBAC, secrets managed outside source control, password policy enforced via ASP.NET Identity.
- **NFR2 — Resilience:** AI features must gracefully fall back across multiple LLM providers.
- **NFR3 — Localization:** Primary language is Arabic (MSA), with right-to-left UI support.
- **NFR4 — Maintainability:** Backend follows Clean Architecture to keep layers testable and independently replaceable.
- **NFR5 — Observability:** Structured logging via Serilog for diagnosing production issues.

## 6. Out of Scope (current version)
- Multi-currency support
- In-app messaging between donors and charities
- Native iOS/Android push notification infrastructure (see Future Work)
