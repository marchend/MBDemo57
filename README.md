# AcmeBank iOS

iOS banking app — iOS 17+, Swift 5.10, SwiftUI, MVVM + Coordinator.

## Quick Start

```bash
git clone <repo>
cd <repo>
./setup.sh
```

The script installs [XcodeGen](https://github.com/yonaskolb/XcodeGen) (via Homebrew if
missing), generates `AcmeBank.xcodeproj` from `project.yml`, and opens it in Xcode.

**Manual fallback** (for environments that block shell scripts):
```bash
brew install xcodegen
xcodegen generate
open AcmeBank.xcodeproj
```

## Running Tests

```bash
# Xcode
⌘U

# CLI
xcodebuild test -scheme AcmeBank -destination 'platform=iOS Simulator,name=iPhone 16'
```

## Project Structure

```
AcmeBank/App/      ← @main entry + ContentView (Hello World)
AcmeBankTests/     ← XCTest unit tests
project.yml        ← XcodeGen spec (source of truth — never edit .xcodeproj)
setup.sh           ← One-shot post-clone setup script
CLAUDE.md          ← Full architecture reference for Anthropic agents
AGENT.md           ← Same content, for other model families
```

See `CLAUDE.md` / `AGENT.md` for the full planned architecture and deferred feature list.
