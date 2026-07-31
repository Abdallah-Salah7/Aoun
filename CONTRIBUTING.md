# Contributing to Aoun

Thanks for your interest in Aoun! This repo hosts three coordinated sub-projects — please branch and commit against the one you're changing.

## Repository Layout
- `mobile-app/` — Flutter app. Standard Flutter tooling (`flutter analyze`, `flutter test`) applies here.
- `backend/` — ASP.NET Core API. Run `dotnet build` and `dotnet test` from `backend/` before opening a PR.
- `admin-panel/` — React + Vite admin dashboard. Run `npm run lint` from `admin-panel/` before opening a PR.
- `docs/` — Architecture and feature documentation; update alongside relevant code changes.

## Commit Messages
Prefix commits with the affected area when practical, e.g.:
```
backend: fix zakat calculation rounding
mobile: add donation confirmation screen
admin: wire up campaign stats chart
docs: update AI gateway flow diagram
```

## Branching
- `main` — stable, deployable state of each sub-project.
- Feature branches should target the relevant sub-project folder.

## Secrets
Never commit real connection strings, JWT secrets, or third-party API keys. Use `dotnet user-secrets` locally for the backend, and `.env` (git-ignored) for the admin panel.
