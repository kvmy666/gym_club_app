Functional Requirements (Gym Club App)

- F-UM-001 User Registration (Email)
- F-UM-002 User Registration (Social: Google/Apple/Facebook)
- F-UM-003 User Login
- F-UM-004 Password Reset
- F-UM-005 Profile Management
- F-UM-006 Goal Setting on first login
- F-CM-001 View Class Schedule
- F-CM-002 Filter/Search Classes
- F-CM-003 Book a Class
- F-CM-004 Cancel Booking
- F-CM-005 Waitlist System
- F-CM-006 Digital Check-In
- F-MP-001 View Membership Plans
- F-MP-002 Purchase Membership
- F-MP-003 View Billing History
- F-AT-001 Workout Library
- F-AT-002 Custom Workout Builder
- F-AT-003 Live Workout Tracking
- F-AT-004 Geolocation Tracking
- F-AT-005 Health API Integration
- F-AT-006 Progress Dashboard
- F-NW-001 Calorie/Macro Tracker
- F-NW-002 Barcode Scanner
- F-NW-003 Water Tracker
- F-CS-001 Social Sharing
- F-CS-002 Gamification
- F-SA-001 Push Notifications
- F-SA-002 In-App Support
- F-SA-003 Offline Access

Non-Functional Requirements (NFR)

- NFR-PER-01 Load Time: < 4s cold start
- NFR-PER-02 UI Feedback: < 1s per action
- NFR-PER-03 Backend concurrency: 1,000 bookings, < 2s API
- NFR-SEC-01 Encryption at Rest (AES-256)
- NFR-SEC-02 TLS 1.2+ in transit
- NFR-SEC-03 PCI DSS compliance for payments
- NFR-USA-01 Learnability: Book in < 90s
- NFR-USA-02 Accessibility: WCAG 2.1 AA
- NFR-USA-03 Consistency: per style guide
- NFR-COM-01 OS support: iOS last 2, Android 24+
- NFR-COM-02 Device widths: 375–430pt
- NFR-COM-03 Offline Access: F-SA-003 fully offline
- NFR-REL-01 Availability: 99.9% backend uptime
- NFR-REL-02 Error Handling: resilient to network/5xx
- NFR-SCL-01 Scalability: 10x growth in a year
- NFR-MNT-01 Lint: 100% pass dart lints

Initial Implementation Notes

- App shell with 5 tabs: Home, Classes, Workouts, Nutrition, Profile.
- Routing via GoRouter with nested details route for classes.
- In-memory data provider for class schedule (to be replaced by API).
- Auth screens scaffolded (sign in/up/reset) pending backend integration.
- Material 3 theme, Google Fonts, light/dark mode.

Next Engineering Phases

- Phase 1 (Auth & Basics): Integrate Firebase Auth (email/password, Google), user profile storage; introduce app-wide auth state guarding routes; local persistence with SharedPreferences; push notifications (FCM) baseline.
- Phase 2 (Classes): Backend API for schedule, filtering, booking, cancellations, waitlist; offline cache; QR check-in.
- Phase 3 (Membership & Payments): Plans, purchase flow (Stripe), billing history.
- Phase 4 (Activity & Nutrition): Workout tracking, progress dashboards; nutrition diary; optional HealthKit/Google Fit integration.
- Phase 5 (Quality): Accessibility pass, performance targets, CI/CD, analytics/crash reporting, test coverage.

