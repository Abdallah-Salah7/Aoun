# Testing

## Backend
Located in `backend/Aoun.Tests`, run with:
```bash
cd backend
dotnet test
```

**Test types present:**
- **Unit tests** — isolated business-logic tests, e.g. `ZakatServiceTests`, `ZakatLogicTests`, `ZakatTests`, `CaseServiceTests` — validate calculation rules and service behavior without hitting the database.
- **Integration tests** — `CasesApiTests`, `CasesEndpointTests`, `CaseIntegrationTests` use `CustomWebApplicationFactory` to spin up the API in-memory and exercise real HTTP endpoints end-to-end.

## Admin Panel
```bash
cd admin-panel
npm run lint
```
(Add a test runner such as Vitest + React Testing Library for component-level tests — see Future Work.)

## Mobile App
```bash
cd mobile-app
flutter analyze
flutter test
```

## Manual/QA Checklist (recommended before a release)
- [ ] Donor registration, login, and social login
- [ ] Charity registration → admin approval flow
- [ ] Campaign/case creation, edit, delete (as Charity)
- [ ] Donation flow end-to-end, including Paymob sandbox payment
- [ ] Zakat calculation against known reference values
- [ ] AI chatbot returns relevant, grounded answers
- [ ] AI recommendations update after new donations
- [ ] Admin moderation actions (approve/reject/delete)
- [ ] Notifications delivered for key events
