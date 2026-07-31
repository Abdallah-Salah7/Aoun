# عون (Aoun) — Smart Charity & Donation Platform

<p align="left">
  <img alt="Build" src="https://github.com/Abdallah-Salah7/Aoun/actions/workflows/backend-ci.yml/badge.svg">
  <img alt="License" src="https://img.shields.io/github/license/Abdallah-Salah7/Aoun">
  <img alt="Version" src="https://img.shields.io/github/v/tag/Abdallah-Salah7/Aoun?label=version">
  <img alt="Stars" src="https://img.shields.io/github/stars/Abdallah-Salah7/Aoun">
  <img alt="Issues" src="https://img.shields.io/github/issues/Abdallah-Salah7/Aoun">
  <img alt="Forks" src="https://img.shields.io/github/forks/Abdallah-Salah7/Aoun">
</p>
<p align="center">
  <img src="E:\Aoun\docs\assets\Banner.png" alt="Aoun UI showcase" width="100%">
</p>

## 1. Project Overview

**Aoun** is a full-stack, Arabic-first charity and donation platform built as a university graduation project (grade: **A+**). It connects donors, charities, and admins through a mobile app, a management admin panel, and a robust backend API, with AI features woven throughout the donor and admin experience.

> This repository is a **monorepo** unifying the three parts of the system, originally developed across separate repositories by the project team.

```
Aoun/
├── mobile-app/     # Flutter application (donor & charity facing)
├── admin-panel/    # React admin dashboard
├── backend/        # ASP.NET Core Web API (Clean Architecture)
├── docs/           # Architecture, ERD, sequence diagrams, API docs
└── .github/        # CI workflows
```

---

## 2. Features

- **Multi-role platform** — Donor, Charity, and Admin experiences in one system.
- **Campaigns & Cases** — charities publish campaigns and individual aid cases; donors browse, favorite, and donate.
- **Donations & Zakat** — dedicated Zakat calculation engine and donation tracking, integrated with **Paymob** for payments.
- **AI donor chatbot** — RAG-based assistant that helps donors find causes and answers platform questions.
- **AI recommendation engine** — hybrid ML (Scikit-Learn) + LLM personalized suggestions.
- **AI admin financial assistant** — helps admins reason about platform financial data.
- **Arabic marketing content generator** — LLM-powered Arabic (MSA) marketing copy for charities.
- **Multi-provider AI fallback routing** — automatic failover across OpenAI, Gemini, DeepSeek, and Groq.
- **Role-Based Access Control (RBAC)** across the API.
- **Notifications, Favorites, Profiles, Charity Dashboard, and Admin Dashboard** modules.

---

## 3. Technologies

| Layer | Stack |
|---|---|
| Mobile App | Flutter, Dart, MVVM architecture, Cubit (Bloc) state management, Firebase |
| Admin Panel | React, Vite, Tailwind CSS |
| Backend API | ASP.NET Core 8, C#, Entity Framework Core 8 |
| Database | SQL Server |
| Auth | ASP.NET Core Identity, JWT Bearer |
| AI Gateway | Python, FastAPI, Qwen2.5-7B-Instruct, Scikit-Learn |
| Payments | Paymob, Stripe.net |
| Logging | Serilog |
| API Docs | Swagger / Swashbuckle |
| Testing | xUnit |
| CI/CD | GitHub Actions |

---

## 4. Architecture

The backend follows **Clean Architecture** and **SOLID** principles:

```
backend/
├── Aoun.API/     # Presentation — Controllers, Middleware, Program.cs
├── Aoun.BLL/     # Business Logic — Services, DTOs, Interfaces, Mapping
├── Aoun.DAL/     # Data Access — DbContext, Entities, Repositories, Migrations
└── Aoun.Tests/   # Unit & integration tests
```

Design patterns: **Repository + Unit of Work**, **Dependency Injection**, middleware-based cross-cutting concerns, and strategy-style provider routing for AI fallback.

Full breakdown: [`docs/BACKEND-ARCHITECTURE.md`](./docs/BACKEND-ARCHITECTURE.md) · AI Gateway: [`docs/AI-GATEWAY.md`](./docs/AI-GATEWAY.md) · ERD: [`docs/ERD.md`](./docs/ERD.md) · Sequence diagrams: [`docs/SEQUENCE-DIAGRAMS.md`](./docs/SEQUENCE-DIAGRAMS.md) · Flowcharts: [`docs/FLOWCHARTS.md`](./docs/FLOWCHARTS.md)

---

## 5. Screenshots

> Add real screenshots/GIFs here once available — e.g. `docs/screenshots/home.png`, `docs/screenshots/donation-flow.gif`.

| Home | Campaign Details | Donation Flow | Admin Dashboard |
|---|---|---|---|
| _screenshot_ | _screenshot_ | _screenshot_ | _screenshot_ |

---

## 6. Installation

### Backend (ASP.NET Core API)
```bash
cd backend
dotnet restore
# configure secrets — see Environment Variables below
dotnet ef database update --project Aoun.DAL --startup-project Aoun.API
dotnet run --project Aoun.API
```

### Admin Panel (React)
```bash
cd admin-panel
npm install
npm run dev
```

### Mobile App (Flutter)
```bash
cd mobile-app
flutter pub get
flutter run
```

---

## 7. Environment Variables

Never commit real secrets. Configure these via `dotnet user-secrets`, environment variables, or your hosting provider's secret manager.

**Backend** (`backend/Aoun.API`)
| Variable | Purpose |
|---|---|
| `ConnectionStrings__DefaultConnection` | SQL Server connection string |
| `JwtSettings__Secret` | JWT signing key |
| `ApiKeys__Gemini`, `ApiKeys__OpenAI`, `ApiKeys__DeepSeek`, `ApiKeys__Groq` | AI provider keys |
| `GeminiSettings__ApiKey` | Gemini key (chatbot/content generation) |
| `GoldApi__ApiKey` | Live gold price for Zakat calculation |
| `Paymob__ApiKey`, `Paymob__IntegrationId`, `Paymob__IframeId` | Payment gateway |

**Admin Panel** (`admin-panel/.env`, git-ignored)
| Variable | Purpose |
|---|---|
| `VITE_API_BASE_URL` | Backend API base URL |

**Mobile App** — API base URL configured in `mobile-app/lib/core` config.

---

## 8. API

Full endpoint reference: [`docs/API.md`](./docs/API.md) (Auth, Campaigns, Cases, Donations, Zakat, Favorites, Profile, Charity, Admin, Notifications, AI). Interactive Swagger UI available at `/swagger` when running the backend in development.

---

## 9. Folder Structure

```
Aoun/
├── mobile-app/
│   └── lib/{core, feature, main.dart}
├── admin-panel/
│   └── src/{pages, components, ...}
├── backend/
│   ├── Aoun.API/{Controllers, Middleware, Program.cs}
│   ├── Aoun.BLL/{Services, DTOs, Interfaces, Mapping}
│   ├── Aoun.DAL/{Entities, Repositories, Migrations}
│   └── Aoun.Tests/
├── docs/
│   ├── SRS.md, BACKEND-ARCHITECTURE.md, AI-GATEWAY.md
│   ├── ERD.md, SEQUENCE-DIAGRAMS.md, FLOWCHARTS.md
│   ├── API.md, DEPLOYMENT.md, TESTING.md, FUTURE-IMPROVEMENTS.md
├── .github/workflows/         # CI pipelines
├── CHANGELOG.md
├── CONTRIBUTING.md
└── LICENSE
```

---

## 10. Future Work

See [`docs/FUTURE-IMPROVEMENTS.md`](./docs/FUTURE-IMPROVEMENTS.md) — push notifications, multi-currency support, in-app messaging, recurring donations, recommendation model retraining pipeline, and more.

---

## 11. Authors

Graduation project — Faculty of Computer & Artificial Intelligence, Beni-Suef University. Supervised by **Dr. Farid Ali** (Teaching Assistant: Taha Mahmoud).

- **Abdallah Salah Abdallah** — Backend (.NET / Clean Architecture), AI Gateway integration — [GitHub](https://github.com/Abdallah-Salah7)
- **Mohab Mohamed Abdel-Tawab** — Backend (.NET / Clean Architecture)
- **Reham Khalil Ibrahim** — Backend (.NET / Clean Architecture)
- **Nada Adly Mourad** — Mobile (Flutter) , UI and UX
- **Shorouq Rabie Ali** — Mobile (Flutter)
- **Basmala Gaber Mohamed** — Mobile (Flutter)

---

## 12. License

MIT — see [`LICENSE`](./LICENSE).
