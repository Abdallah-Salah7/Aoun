# Backend Architecture

The `backend/` service is an ASP.NET Core 8 Web API built with **Clean Architecture**, separating concerns into four layers so that business logic stays independent of frameworks, databases, and delivery mechanisms.

## Layers

### `Aoun.API` — Presentation
- Controllers (one per domain: Auth, Admin, Campaigns, Cases, Charity, CharityDashboard, Donations, Favorites, Home, Notifications, Profile, UserActivity, Zakat, AI)
- Middleware: `ExceptionMiddleware` (centralized error handling), `CampaignStateMiddleware` (campaign lifecycle state transitions)
- `Program.cs` composition root: DI registration, Identity, JWT auth, Swagger, Serilog

### `Aoun.BLL` — Business Logic
- Services implementing each domain's business rules (e.g. `ZakatService`, `CampaignService`, `CharityDashboardService`, `AISmartService`)
- DTOs for request/response shaping, decoupled from EF entities
- AutoMapper-style mapping profiles
- Interfaces (`I*Service`) so controllers depend on abstractions, not implementations — enables unit testing via mocking

### `Aoun.DAL` — Data Access
- `ApplicationDbContext` (EF Core, Code-First)
- Entities grouped by domain: Auth, Campaign, Case/Cases, Category, Charity, Donation, Favorite, Shared
- Repository pattern (`I*Repository` / `*Repository`) + Unit of Work, isolating EF Core from the business layer
- EF Core Migrations

### `Aoun.Tests`
- Unit tests for business logic in isolation (e.g. `ZakatServiceTests`, `ZakatLogicTests`, `CaseServiceTests`)
- Integration tests against a real (in-memory/test) host via `CustomWebApplicationFactory` (e.g. `CasesApiTests`, `CasesEndpointTests`, `CaseIntegrationTests`)

## Design Patterns in Use

- **Clean Architecture** — dependencies point inward; `Aoun.DAL` and `Aoun.BLL` know nothing about `Aoun.API`.
- **Repository + Unit of Work** — abstracts persistence from business logic.
- **Dependency Injection** — every service/repository is registered and injected via interfaces.
- **Middleware pipeline** — cross-cutting concerns (errors, campaign state) handled outside individual controllers.
- **Strategy-style provider routing** — used in the AI Gateway integration to swap AI providers without changing calling code.

## Authentication & Authorization

- ASP.NET Core Identity for user management
- JWT Bearer tokens for stateless authentication
- Role-Based Access Control (RBAC) — Donor / Charity / Admin roles gate access to controllers and actions

## Payments

- **Paymob** integration for donation payments (primary, Egypt-focused payment gateway)
- **Stripe.net** package included for card payment support

## Logging

- **Serilog** with file sink for structured, persistent application logs
