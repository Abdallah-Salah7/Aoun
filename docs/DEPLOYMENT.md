# Deployment Guide

## Backend (Aoun.API)
1. Provision a SQL Server instance (Azure SQL, or any SQL Server-compatible host).
2. Set configuration via environment variables or `dotnet user-secrets` — do **not** edit `appsettings.json` with real values:
   - `ConnectionStrings__DefaultConnection`
   - `JwtSettings__Secret`
   - `ApiKeys__Gemini`, `ApiKeys__OpenAI`, `ApiKeys__DeepSeek`, `ApiKeys__Groq`
   - `Paymob__ApiKey`, `Paymob__IntegrationId`, `Paymob__IframeId`
   - `GoldApi__ApiKey`
3. Apply EF Core migrations: `dotnet ef database update --project Aoun.DAL --startup-project Aoun.API`
4. Publish: `dotnet publish Aoun.API -c Release -o ./publish`
5. Host behind IIS, a Linux container, or an App Service (e.g. Azure App Service / databaseasp.net-style hosting).

## AI Gateway (FastAPI)
- Deployed on **Hugging Face Spaces**.
- Requires provider API keys as Space secrets (never in code).
- The `.pkl` recommendation model is loaded at startup; retrain and re-upload it as donation/interaction data grows.

## Admin Panel (React)
1. `npm install && npm run build` inside `admin-panel/`.
2. Deploy the `dist/` output to any static host (Vercel, Netlify, Azure Static Web Apps, or GitHub Pages — see below).
3. Set the API base URL via a build-time `.env` variable (do not hardcode).

## Mobile App (Flutter)
1. `flutter build apk --release` (Android) or `flutter build ios --release` (iOS, requires macOS + Xcode).
2. Point the app's API base URL to the deployed backend via its config/environment file.
3. Distribute via Google Play / TestFlight, or as a direct APK for demos.

## Suggested CI/CD
See `.github/workflows/` for automated build/test pipelines that run on every push and pull request against `main`.
