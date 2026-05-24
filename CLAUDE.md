# AcmeBank — Agent Context

## Project Overview
AcmeBank is an iOS banking app (iOS 17+, Swift 5.10) built with SwiftUI and an
MVVM + Coordinator architecture. It provides account overviews, transaction history,
fund transfers, and bill payments, authenticated via Okta OIDC. This repo currently
holds the Hello-World bootstrap shell; all features are deferred to future PRs.

## Tech Stack
| Concern | Choice |
|---|---|
| Platform | iOS 17+, Xcode 16+ |
| Language | Swift 5.10 |
| UI Framework | SwiftUI |
| Architecture | MVVM + Coordinator (`NavigationStack`) |
| Auth | Okta OIDC (`okta-mobile-swift` 2.x) |
| Networking | `URLSession` + async/await |
| Dependency Injection | Constructor injection |
| Notifications | `NotificationCenter` with typed wrappers |
| Project generation | XcodeGen (`project.yml`) |
| Unit tests | XCTest (`AcmeBankTests` target) |
| UI tests | XCUITest (`AcmeBankUITests` target — deferred) |
| Bundle ID | `com.acmebank.mobile` |

## How to Run Locally
```bash
git clone <repo> && cd <repo>
./setup.sh          # installs xcodegen, generates .xcodeproj, opens Xcode
```
Manual fallback: `brew install xcodegen && xcodegen generate && open AcmeBank.xcodeproj`  
Build & run: select scheme `AcmeBank` → iPhone simulator → ▶

## How to Run Tests
- Xcode: ⌘U
- CLI: `xcodebuild test -scheme AcmeBank -destination 'platform=iOS Simulator,name=iPhone 16'`

## Key Directory Structure
```
AcmeBank/
├── App/               ← @main entry + ContentView (implemented)
├── Core/              ← Auth, Networking, Notifications, Extensions (deferred)
├── Domain/            ← Models + Repository protocols (deferred)
├── Data/              ← Remote + Mock repository implementations (deferred)
├── Features/          ← Login, Home, Accounts, Transfer, Cards screens (deferred)
└── DesignSystem/      ← Colors, Typography, Assets (deferred)
AcmeBankTests/         ← XCTest unit tests (smoke test implemented; feature tests deferred)
AcmeBankUITests/       ← XCUITest end-to-end flows (deferred)
project.yml            ← XcodeGen spec (source of truth — never edit .xcodeproj directly)
setup.sh               ← One-shot post-clone materialisation script
```

## Planned Architecture

### Entry Point (implemented in this PR)
- `AcmeBankApp.swift` — `@main struct AcmeBankApp: App`, `WindowGroup { ContentView() }`
- `ContentView.swift` — placeholder "AcmeBank" label

### MVVM + Coordinator (deferred — future PR)
- **View**: SwiftUI `View` struct, zero business logic, observes ViewModel via `@StateObject`
- **ViewModel**: `final class: ObservableObject`, `@Published` state, calls repositories
- **Coordinator**: `ObservableObject`, owns `NavigationPath`, creates Views+ViewModels, drives navigation
- **Repository protocols** in `Domain/`; concrete implementations in `Data/`

### Coordinator Hierarchy (deferred — future PR)
`AppCoordinator` → `LoginCoordinator` | `TabBarCoordinator` → `HomeCoordinator`,
`TransferCoordinator`, `CardsCoordinator`, `MoreCoordinator`

### Auth — Okta OIDC (deferred — future PR)
`AuthServiceProtocol` / `AuthService`, `KeychainStore`, `UserSession` value type.
Token refresh via `RequestInterceptor` before every request; session expiry posts
`AppNotification.sessionExpired` → `AppCoordinator` redirects to login.

### Networking (deferred — future PR)
`APIClient` (URLSession + async/await), `APIRouter` (endpoint enum), `APIError`,
`RequestInterceptor`. Base URL from `Info.plist` key `API_BASE_URL` injected via xcconfig.

### Domain Models (deferred — future PR)
`Account`, `Transaction`, `Customer`, `TransferRequest` — all `Codable`.

### Repository Protocols (deferred — future PR)
`AccountRepositoryProtocol`, `TransactionRepositoryProtocol`, `CustomerRepositoryProtocol`,
`TransferRepositoryProtocol`. ViewModels depend on protocols only, never concrete types.

### Mock Data Layer (deferred — future PR)
`MockAccountRepository`, `MockTransactionRepository`, `MockCustomerRepository` with
hardcoded fixtures. Every screen story uses mocks first; real API wired in follow-up story.

### Notifications (deferred — future PR)
`AppNotification` typed `Notification.Name` constants, `NotificationPublisher` helper,
`NotificationKey` typed userInfo keys.

### Design System (deferred — future PR)
`Colors.swift` (`Color` extensions: `acmeNavy`, `acmeBackground`, etc.),
`Typography.swift` (`Font` extensions), `Assets.xcassets`.

### Testing (deferred — future PR)
- XCTest for all ViewModels, repositories, extensions (≥80% line coverage on Core + Features)
- XCUITest for critical flows: login, transfer, sign-out (separate `AcmeBankUITests` target)
- SwiftLint (`.swiftlint.yml`) on every PR

### CI (deferred — future PR)
`ios-build.yml`: `xcodebuild test`, SwiftLint, `-warnings-as-errors`, xcconfig secret injection.

## Deferred Work
- Okta OIDC auth (`AuthService`, `KeychainStore`, `UserSession`, `Okta.plist.example`)
- AppCoordinator + full coordinator hierarchy
- Core/Networking layer (`APIClient`, `APIRouter`, `APIError`, `RequestInterceptor`)
- Core/Notifications (`AppNotification`, `NotificationPublisher`, `NotificationKey`)
- Core/Extensions (`Decimal+Currency`, `Date+Greeting`, `String+Initials`)
- Domain models + repository protocols
- Data/Remote + Data/Mock repository implementations
- All feature screens (Login, Home, Accounts, Transfer, Cards)
- DesignSystem (Colors, Typography, Assets)
- `AcmeBankUITests` XCUITest target (login, transfer, sign-out flows)
- SwiftLint configuration (`.swiftlint.yml`)
- CI workflow + xcconfig injection
- `Localizable.strings`

## Git Workflow

> **Default PR target branch: `develop`.** Every feature/refactor/docs PR
> opens against `develop`. PRs are only opened against `qa`, `uat`, or
> `main` for explicit promotion PRs.

**Branch model (`develop` → `qa` → `uat` → `main`):**

| Branch  | Role                                 | Receives PRs from              | Promotes to |
|---------|--------------------------------------|--------------------------------|-------------|
| develop | Default integration branch           | feature branches               | qa          |
| qa      | First quality gate                   | develop (promotion PR)         | uat         |
| uat     | Pre-prod acceptance                  | qa (promotion PR)              | main        |
| main    | Production / release tags            | uat (promotion PR)             | tagged only |

All feature PRs MUST target `develop`. Never open a feature PR against
`qa`, `uat`, or `main`. Promotions happen via dedicated promotion PRs.
