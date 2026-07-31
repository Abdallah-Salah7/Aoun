# API Documentation

Base URL (local): `https://localhost:{port}/api`
Interactive docs: Swagger UI is enabled in development at `/swagger`.

All endpoints below are prefixed with `/api/[controller]` unless noted otherwise. Endpoints marked 🔒 require a JWT Bearer token (`Authorization: Bearer <token>`); role-gated endpoints require the matching role (Donor / Charity / Admin).

## Auth (`/api/auth`)
| Method | Route | Description |
|---|---|---|
| POST | `/register` | Register a new donor/charity account |
| POST | `/login` | Authenticate and receive a JWT |
| POST | `/forgot-password` | Trigger password reset flow |
| POST | `/verify-email` | Verify a user's email address |
| POST | `/social-login` | Authenticate via a social identity provider |

## Campaigns (`/api/campaigns`)
| Method | Route | Description |
|---|---|---|
| POST | `/` 🔒 | Create a campaign (Charity) |
| GET | `/home` | Campaigns for the home feed |
| GET | `/charity/{charityId}` | Campaigns for a specific charity |
| GET | `/public` | Public campaign listing |
| GET | `/{id}` | Campaign details |
| GET | `/charity/details/{id}` 🔒 | Campaign details (charity-facing) |
| PUT | `/{id}` 🔒 | Update a campaign |
| DELETE | `/{id}` 🔒 | Delete a campaign |

## Cases (`/api/cases`)
| Method | Route | Description |
|---|---|---|
| GET | `/` 🔒 | List cases (charity-facing) |
| GET | `/home` | Cases for the home feed |
| POST | `/` 🔒 | Create a case |
| PUT | `/{id}` 🔒 | Update a case |
| DELETE | `/{id}` 🔒 | Delete a case |
| GET | `/public/{id}` | Public case details |
| GET | `/search` | Search cases |
| GET | `/{id}` 🔒 | Case details (charity-facing) |
| GET | `/charity/{charityId}/cases` | Cases belonging to a charity |

## Donations (`/api/donations`)
| Method | Route | Description |
|---|---|---|
| POST | `/` 🔒 | Create a donation record |
| POST | `/pay` 🔒 | Initiate a Paymob payment for a donation |
| GET | `/api/cases/{caseId}/donations` | Donations for a case |
| GET | `/api/campaigns/{campaignId}/donations` | Donations for a campaign |

## Zakat (`/api/zakat`)
Zakat calculation endpoints backed by `ZakatService` (nisab, gold-price lookups via GoldApi, and Zakat-due calculation logic — see `Aoun.Tests/ZakatLogicTests.cs` for calculation rules).

## Favorites (`/api/favorites`)
🔒 Add/remove/list a donor's favorited campaigns and cases.

## Profile (`/api/profile`)
🔒 Get/update the authenticated user's profile (donor or charity).

## Charity & CharityDashboard (`/api/charity`, `/api/charitydashboard`)
Charity account management and dashboard stats (campaign performance, donation totals).

## Admin (`/api/admin`)
| Method | Route | Description |
|---|---|---|
| GET | `/stats` 🔒 | Platform-wide statistics |
| GET | `/charities` 🔒 | List charities |
| GET | `/charities/{id}` 🔒 | Charity details |
| PUT | `/charities/{id}/status` 🔒 | Approve/reject/suspend a charity |
| GET | `/cases` 🔒 | List cases (moderation) |
| PUT | `/cases/{id}` 🔒 | Update a case (moderation) |
| DELETE | `/cases/{id}` 🔒 | Remove a case |
| GET | `/users` 🔒 | List platform users |
| DELETE | `/users/{id}` 🔒 | Remove a user |
| POST | `/add-admin` 🔒 | Promote a user to admin |
| GET | `/top-donors` 🔒 | Top donors leaderboard |
| GET | `/top-charities` 🔒 | Top-performing charities |
| POST | `/add-charity` 🔒 | Manually onboard a charity |

## Notifications (`/api/notifications`)
🔒 List/mark-read notifications for the authenticated user.

## AI (`/api/ai`)
| Method | Route | Description |
|---|---|---|
| POST | `/generate-description` 🔒 | Generate Arabic marketing copy for a campaign/case (Charity) |
| POST | `/chat` | RAG-based donor chatbot |
| GET | `/recommendations` 🔒 | Personalized campaign/case recommendations (hybrid ML + LLM) |

See [`AI-GATEWAY.md`](./AI-GATEWAY.md) for how these calls are routed to the FastAPI AI Gateway.

## Errors
All errors are handled centrally by `ExceptionMiddleware` and returned as a consistent JSON error shape with an appropriate HTTP status code.
