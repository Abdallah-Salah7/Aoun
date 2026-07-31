# Future Improvements

- **Push notifications** — native FCM/APNs integration instead of in-app-only notifications.
- **Multi-currency & multi-country support** — beyond EGP/Paymob, to support diaspora donors.
- **In-app messaging** — direct communication channel between donors and charities for case updates.
- **Recurring donations** — subscription-style monthly giving.
- **Admin panel test coverage** — add Vitest/React Testing Library coverage for critical dashboard flows.
- **Recommendation model retraining pipeline** — automate periodic retraining of the Scikit-Learn collaborative-filtering model as new donation data accumulates.
- **Observability dashboard** — surface Serilog output into a centralized log viewer (e.g. Seq, Grafana Loki) for production monitoring.
- **Automated E2E tests** — mobile app UI testing (e.g. via `integration_test` package) covering the full donation journey.
- **Public GitHub Pages microsite** — marketing/landing page for the platform, separate from the admin panel.
