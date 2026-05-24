# Bootstrap Plan — AcmeBank iOS

## In scope (this PR)

### Project name + tech stack
- **App name:** AcmeBank
- **Platform:** iOS 17+, Swift 5.10, Xcode 16+
- **UI Framework:** SwiftUI (`@main struct AcmeBankApp: App`)
- **Project generation:** XcodeGen (`project.yml`) — no hand-crafted `.xcodeproj`
- **Test framework:** XCTest (unit test target `AcmeBankTests`)
- **Bundle ID:** `com.acmebank.mobile`

### Directory structure (Hello World only)

```
AcmeBank/                        ← iOS source root (XcodeGen glob: sources: [AcmeBank])
└── App/
    ├── AcmeBankApp.swift        ← @main SwiftUI entry point (WindowGroup → ContentView)
    └── ContentView.swift        ← Hello-World placeholder ("AcmeBank")
AcmeBankTests/
└── AcmeBankTests.swift          ← Single smoke test: ContentView initializes
project.yml                      ← XcodeGen spec (app + unit-test targets only)
setup.sh                         ← One-shot: installs xcodegen, generates .xcodeproj, opens Xcode
.gitignore                       ← Standard iOS/XcodeGen ignore set
CLAUDE.md                        ← Project context for Anthropic agents
AGENT.md                         ← Project context for other model families (identical content)
README.md                        ← Quick-start guide
bootstrap_plan.md                ← This file
```

### Files this PR creates
| File | Purpose |
|------|---------|
| `project.yml` | XcodeGen declarative project spec |
| `AcmeBank/App/AcmeBankApp.swift` | `@main` SwiftUI entry — `WindowGroup { ContentView() }` |
| `AcmeBank/App/ContentView.swift` | Hello-World view — `Text("AcmeBank")` centered on screen |
| `AcmeBankTests/AcmeBankTests.swift` | Smoke test: `_ = ContentView()` proves test target links |
| `setup.sh` | Post-clone materialisation script |
| `.gitignore` | Prevents committing generated `.xcodeproj`, `.DS_Store`, etc. |
| `CLAUDE.md` | Agent context (full planned architecture documented, most deferred) |
| `AGENT.md` | Byte-identical copy of CLAUDE.md for non-Anthropic model families |
| `README.md` | Quick-start for humans |

### How to run the project locally
```bash
git clone <repo>
cd <repo>
./setup.sh          # installs xcodegen if missing, generates .xcodeproj, opens Xcode
```
Manual fallback:
```bash
brew install xcodegen
xcodegen generate
open AcmeBank.xcodeproj
```
Build & run in Xcode: select the `AcmeBank` scheme → iPhone 17 simulator → ▶.

### How to run tests
In Xcode: ⌘U (or Product → Test).  
CLI: `xcodebuild test -scheme AcmeBank -destination 'platform=iOS Simulator,name=iPhone 16'`

### Definition of Hello World
The app launches in the simulator and shows a centered "AcmeBank" text label on a white/system background. One XCTest passes confirming `ContentView` initialises and the test target links against the app module.

---

## Out of scope — deferred to future work

- **Authentication (Okta OIDC via `okta-mobile-swift`)** — future PR
- **`RootView` / auth-state switching (Login vs TabBar)** — future PR
- **AppCoordinator, LoginCoordinator, TabBarCoordinator, HomeCoordinator, TransferCoordinator, CardsCoordinator, MoreCoordinator** — future PR
- **Core/Auth layer** (`AuthService`, `KeychainStore`, `UserSession`) — future PR
- **Networking layer** (`APIClient`, `APIRouter`, `APIError`, `RequestInterceptor`) — future PR
- **Core/Notifications** (`AppNotification`, `NotificationPublisher`, `NotificationKey`) — future PR
- **Core/Extensions** (`Decimal+Currency`, `Date+Greeting`, `String+Initials`) — future PR
- **Domain models** (`Account`, `Transaction`, `Customer`, `TransferRequest`) — future PR
- **Repository protocols** (`AccountRepositoryProtocol`, `TransactionRepositoryProtocol`, etc.) — future PR
- **Data/Remote repositories** (`AccountAPIRepository`, `TransactionAPIRepository`, `CustomerAPIRepository`) — future PR
- **Data/Mock repositories** (`MockAccountRepository`, `MockTransactionRepository`, `MockCustomerRepository`) — future PR
- **Features/Login screen** (`LoginView`, `LoginViewModel`, `LoginCoordinator`) — future PR
- **Features/Home screen** (`HomeView`, `HomeViewModel`, `HomeCoordinator`, sub-views) — future PR
- **Features/Accounts, Transfer, Cards screens** — future PRs
- **DesignSystem** (`Colors.swift`, `Typography.swift`, `Assets.xcassets`) — future PR
- **`AcmeBankUITests` target with XCUITest flows** — future PR (login, transfer, sign-out flows)
- **`.swiftlint.yml` configuration** — future PR
- **CI workflow** (`ios-build.yml`, xcconfig injection, warnings-as-errors) — future PR
- **`Okta.plist.example`** — future PR
- **`Localizable.strings`** — future PR
