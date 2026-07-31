# Changelog

This project follows [Semantic Versioning](https://semver.org/) (`MAJOR.MINOR.PATCH`). Each version below corresponds to a real, meaningful milestone in the project's capability — use these as the basis for actual GitHub Releases/tags **at the point you push and tag them**, rather than backdating.

## [Unreleased]
- Ongoing documentation and CI hardening.

## v1.0.0 — Graduation Release
- Full donor, charity, and admin flows complete.
- AI Gateway integrated: chatbot, recommendations, admin assistant, Arabic content generation.
- Paymob payments and Zakat calculation live.
- Admin panel feature-complete.
- Project submitted and graded (A+).

## v0.8.0 — AI Integration
- AI Gateway (FastAPI) connected to the backend via `AISmartService`.
- Multi-provider fallback routing (OpenAI → Gemini → Groq → DeepSeek) implemented.
- RAG donor chatbot and recommendation engine shipped.

## v0.5.0 — Payments & Zakat
- Paymob integration for donations.
- Zakat calculation service and tests added.
- Donation tracking (Pending/Completed) wired end-to-end.

## v0.3.0 — Admin Panel MVP
- React + Vite admin dashboard scaffolded.
- Charity approval/rejection and case moderation flows.
- Platform stats dashboard (`AdminController`).

## v0.2.0 — Core Charity Features
- Campaigns and Cases CRUD (charity-facing).
- Public browsing endpoints for donors.
- Favorites and Notifications modules.

## v0.1.0 — Foundation
- Clean Architecture backend scaffolded (API / BLL / DAL / Tests).
- ASP.NET Core Identity + JWT authentication.
- Initial Flutter app shell and navigation.

---

### How to cut a real release
```bash
git tag -a v1.0.0 -m "Graduation release"
git push origin v1.0.0
```
Then open **GitHub → Releases → Draft a new release**, pick the tag, and paste the matching section from this changelog as release notes.
