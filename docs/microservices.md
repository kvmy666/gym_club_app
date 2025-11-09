## Proposed Microservices Architecture

### 1. Identity & Access
- **Responsibilities:** Authentication (email/social), authorization, profile bootstrap, session management.
- **Interfaces:** REST (`/auth`), OAuth 2.0 for Google/Apple/Facebook, webhooks for password reset.
- **Data:** Users, roles, MFA secrets.
- **Notes:** Issue JWT with short TTL and refresh tokens, integrate with Azure AD B2C or Firebase Auth initially.

### 2. Scheduling & Classes
- **Responsibilities:** Class catalogue, instructor availability, bookings, cancellations, waitlist management, attendance sync (QR).
- **Interfaces:** REST (`/classes`, `/bookings`), WebSocket push for waitlist promotions.
- **Data:** Classes, instructors, bookings, attendance logs.
- **Notes:** Expose idempotent booking endpoints, use eventual consistency for capacity updates.

### 3. Membership & Billing
- **Responsibilities:** Membership plans, pricing, invoicing, payment orchestration, receipts.
- **Interfaces:** REST (`/plans`, `/subscriptions`), Stripe webhooks, financing provider integrations.
- **Data:** Plans, subscriptions, invoices, payment methods.
- **Notes:** PCI scope limited via tokenization, maintain audit trail for refunds.

### 4. Activity & Telemetry
- **Responsibilities:** Workout templates, live logging, wearable ingestion, progress analytics.
- **Interfaces:** gRPC/REST (`/workouts`, `/metrics`), ingestion queue for wearables, SSE for live sessions.
- **Data:** Workout sessions, metrics, goals, PRs.
- **Notes:** Store raw telemetry in time-series DB (Timescale, Influx), derive aggregates for dashboard.

### 5. Nutrition & Wellness
- **Responsibilities:** Meal plans, macro targets, barcode lookup, hydration tracking.
- **Interfaces:** REST (`/nutrition`), external API adapters (USDA, FatSecret), background jobs for recommendations.
- **Data:** Recipes, meals, daily logs.
- **Notes:** Cache ingredient lookups, schedule push reminders via Notifications service.

### 6. Commerce & Inventory
- **Responsibilities:** Shop catalogue, inventory, orders, fulfilment status.
- **Interfaces:** REST (`/store`), integration with ERP/WMS, payment hooks from Billing service.
- **Data:** Products, SKUs, orders, shipments.
- **Notes:** Support promotional pricing, bundling, loyalty credits.

### 7. Messaging & AI Coach
- **Responsibilities:** Conversational AI orchestration, plan summarisation, insight generation.
- **Interfaces:** GraphQL/gRPC for front-end, async worker for LLM requests, event bus for data ingestion.
- **Data:** Chat history, recommendation snapshots, feature toggles.
- **Notes:** Apply guardrails (PII redaction), maintain prompt templates versioning.

### 8. Notifications
- **Responsibilities:** Push/email/SMS, class reminders, achievement streaks, marketing campaigns.
- **Interfaces:** REST (`/notifications`), event-driven fan-out via Pub/Sub.
- **Data:** Notification templates, delivery logs, user preferences.
- **Notes:** Deduplicate deliveries, respect quiet hours, allow experimentation (A/B).

### 9. Gateway & API Aggregator
- **Responsibilities:** API gateway, request authentication, throttling, localization headers, BFF adapters for mobile.
- **Interfaces:** GraphQL/REST unified endpoint, caching via CDN.
- **Notes:** Inject locale (`ar`/`en`), theme hints, transform responses to match Flutter view models.

### Cross-Cutting Concerns
- **Observability:** Centralized tracing (OpenTelemetry), metrics dashboards, alerting runbooks.
- **Data Privacy:** Regional data residency, encryption at rest (AES-256), TLS 1.2+ in transit.
- **CI/CD:** Automated pipelines per service, blue/green or canary deploys, contract tests.
- **Infrastructure:** Kubernetes (GKE/AKS), service mesh for zero-trust (mTLS), secrets managed via Vault.

### Migration Considerations
- Phase 1: Bootstrap with managed services (Firebase Auth, Firestore) while defining APIs.
- Phase 2: Gradually extract Scheduling/Billing into dedicated services as load increases.
- Phase 3: Introduce AI coach worker pool and streaming ingestion once telemetry volume necessitates it.
