# Backend Work Division (Team Planning)

Original task split across the three backend developers on the team, used to plan the ~1-month build (at 3-4 hrs/day).

## Developer 1 — Core System
1. **Authentication & Authorization** — Register (Donor/Charity), Login, Forgot Password, JWT, Google/Facebook login
2. **Charity Registration Flow** — account creation, official data entry, document upload, status (Pending/Approved/Rejected)
3. **Admin Panel APIs** — view charities, review documents, approve/reject, view/delete cases
4. **User Profile** — edit data, change photo/password, view user activity

*Estimated: ~3 weeks*

## Developer 2 — Donation System (largest scope)
1. **Categories** (Education, Health, Relief, ...)
2. **Campaigns** (e.g. Iftar campaign, Winter campaign)
3. **Cases** — create (title, description, required amount, charity, urgency flag)
4. **Donations** — donate to a case/campaign/emergency wallet; track collected/remaining amount
5. **Favorites** — add/remove/view favorited cases

*Estimated: ~3 weeks*

## Developer 3 — Supporting Services
1. **Zakat Calculator API** — money, gold, silver calculation
2. **Notifications** — case near completion, new campaign, motivational messages
3. **Statistics APIs** — donation counts, case counts, category distribution (for dashboards)

*Estimated: ~10-12 days*

## Summary
| Developer | Responsibilities |
|---|---|
| Dev 1 | Authentication + Charity + Admin |
| Dev 2 | Cases + Campaigns + Donations |
| Dev 3 | Zakat + Notifications + Statistics |

## Recommended build order
1. Authentication
2. Charity approval
3. Categories
4. Cases
5. Donations
6. Dashboard
