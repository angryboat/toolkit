# ABToolKit

A Swift package providing essential utilities and macros for iOS and macOS development, emphasizing compile-time safety and secure data handling.

## Features

### 🔐 Secure Storage
- **Keychain**: Full CRUD operations with synchronization support
- **Error Handling**: Comprehensive error types and status codes

### 📊 Data & Logging
- **SwiftData Extensions**: Convenient query methods for PersistentModel
- **Logger**: Bundle-aware OSLog extensions with categories
- **Bundle Extensions**: Easy access to app metadata

### 🎯 Compile-Time Safety
- **#UUID**: Validates UUID strings at compile time
- **#URL**: Validates URLs at compile time
- **@LocalizedEnum**: Automatic localized string generation

### 🎨 SwiftUI Components
- **QueryView**: Dynamic SwiftData queries with SwiftUI integration

## Requirements

- iOS 26.0+
- macOS 26.0+
- Swift 6.2+

## Installation

### Swift Package Manager

Add this package to your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/your-username/toolkit.git", from: "1.0.0")
]
```

## Quick Start

```swift
import ABToolKit

// Secure storage
try Keychain.create("secret-token".data(using: .utf8)!,
                   service: "MyApp", account: "api-token")

// Compile-time validation
let apiURL = #URL("https://api.example.com/v1")
let userID = #UUID("123e4567-e89b-12d3-a456-426614174000")

// Enhanced logging
let logger = Logger(bundle: .main, category: "Network")
logger.info("API request started")
```

## Core Utilities

### Keychain

Secure storage with full CRUD operations and iCloud synchronization:

```swift
import ABToolKit

// Create/Store data
try Keychain.create(
    "sensitive-data".data(using: .utf8)!,
    service: "MyApp",
    account: "user-token",
    synchronizable: true  // Sync across devices
)

// Read stored data
let data = try Keychain.read(service: "MyApp", account: "user-token")
let token = String(data: data, encoding: .utf8)

// Update existing data
try Keychain.update(
    "new-token".data(using: .utf8)!,
    service: "MyApp",
    account: "user-token"
)

// Delete when no longer needed
try Keychain.delete(service: "MyApp", account: "user-token")
```

#### Error Handling

```swift
do {
    try Keychain.create(data, service: "MyApp", account: "token")
} catch Keychain.Error.duplicate {
    // Item already exists, update instead
    try Keychain.update(data, service: "MyApp", account: "token")
} catch Keychain.Error.notFound {
    // Handle missing item
} catch Keychain.Error.status(let status, let message) {
    // Handle other keychain errors
    print("Keychain error \(status): \(message ?? "Unknown")")
}
```

### Logger

Bundle-aware logging with category support:

```swift
import ABToolKit
import OSLog

// Create category-specific loggers
let networkLogger = Logger(bundle: .main, category: "Network")
let authLogger = Logger(bundle: .main, category: "Authentication")
let dataLogger = Logger(bundle: .main, category: "DataLayer")

// Use throughout your app
networkLogger.info("Starting API request to \(endpoint)")
authLogger.error("Authentication failed: \(error.localizedDescription)")
dataLogger.debug("Processing \(items.count) items")
```

### Bundle Extensions

Easy access to app metadata:

```swift
import ABToolKit

// App version information
let version = Bundle.main.bundleShortVersion     // "1.0.0"
let build = Bundle.main.bundleVersion           // "42"
let displayName = Bundle.main.bundleDisplayName // "My App"

// Additional metadata
let copyright = Bundle.main.bundleHumanReadableCopyright
let iconName = Bundle.main.appIconName

// Use in your UI
Text("Version \(version ?? "Unknown") (\(build ?? "?"))")
```

### SwiftData Extensions

Convenient query methods for PersistentModel:

```swift
import ABToolKit
import SwiftData

// Count records
let userCount = try User.count(inContext: context)
let activeCount = try User.count(
    inContext: context,
    where: #Predicate<User> { $0.isActive }
)

// Fetch with filtering and sorting
let users = try User.fetch(
    inContext: context,
    where: #Predicate<User> { $0.isActive },
    sortedBy: [SortDescriptor(\.name)],
    limit: 10
)

// Check existence
let hasAdmin = try User.exists(
    inContext: context,
    where: #Predicate<User> { $0.role == .admin }
)

// Get first match
let firstUser = try User.first(
    inContext: context,
    sortedBy: [SortDescriptor(\.createdAt)]
)
```

### SwiftUI QueryView

Dynamic SwiftData queries with SwiftUI:

```swift
import ABToolKit
import SwiftUI
import SwiftData

struct UsersView: View {
    var body: some View {
        QueryView(
            filter: #Predicate<User> { $0.isActive },
            sort: [SortDescriptor(\.name)]
        ) { users in
            List(users) { user in
                UserRow(user: user)
            }
        }
    }
}

// With custom fetch descriptor
QueryView(
    fetch: FetchDescriptor<User>(
        predicate: #Predicate { $0.lastLogin > Date().addingTimeInterval(-86400) },
        sortBy: [SortDescriptor(\.lastLogin, order: .reverse)]
    ),
    animation: .spring
) { recentUsers in
    // Your SwiftUI content
}
```

## Swift Macros

### Compile-Time Validation

Ensure correctness at build time:

```swift
import ABToolKit

struct APIClient {
    // Validated at compile time - no runtime crashes
    static let baseURL = #URL("https://api.example.com/v1")
    static let clientID = #UUID("123e4567-e89b-12d3-a456-426614174000")

    // These would cause compile-time errors:
    // static let badURL = #URL("not-a-url")           // ❌ Compile error
    // static let badUUID = #UUID("invalid-uuid")      // ❌ Compile error
}
```

### Localized Enums

Automatic localized string generation:

```swift
import ABToolKit

@LocalizedEnum(prefix: "error", separator: ".")
enum NetworkError: String, CaseIterable {
    case timeout
    case noConnection
    case serverError
    case unauthorized
}

// Usage - automatically generates localized descriptions
let error = NetworkError.timeout
print(error.localizedDescription) // Looks up "error.NetworkError.timeout"

// With custom configuration
@LocalizedEnum(prefix: "UI", separator: "_", bundle: .main)
enum AppState {
    case loading
    case ready
    case error
}
// Generates keys: "UI_AppState_loading", "UI_AppState_ready", etc.
```

#### Localization Setup

Create corresponding entries in your `Localizable.strings`:

```
// Localizable.strings
"error.NetworkError.timeout" = "The request timed out";
"error.NetworkError.noConnection" = "No internet connection";
"error.NetworkError.serverError" = "Server error occurred";
"error.NetworkError.unauthorized" = "Access denied";
```

## Complete Example

```swift
import ABToolKit
import SwiftUI
import SwiftData
import OSLog

class AuthenticationManager {
    private let logger = Logger(bundle: .main, category: "Auth")

    func saveToken(_ token: String) throws {
        logger.info("Saving authentication token")
        try Keychain.create(
            token.data(using: .utf8)!,
            service: "MyApp-Auth",
            account: "access-token",
            synchronizable: true
        )
    }

    func loadToken() -> String? {
        do {
            let data = try Keychain.read(
                service: "MyApp-Auth",
                account: "access-token"
            )
            return String(data: data, encoding: .utf8)
        } catch {
            logger.error("Failed to load token: \(error)")
            return nil
        }
    }
}

struct ContentView: View {
    var body: some View {
        VStack {
            Text("Version \(Bundle.main.bundleShortVersion ?? "Unknown")")

            QueryView(
                filter: #Predicate<User> { $0.isActive },
                sort: [SortDescriptor(\.name)]
            ) { users in
                List(users) { user in
                    Text(user.name)
                }
            }
        }
    }
}
```

## Error Handling

All utilities provide comprehensive error handling:

### Keychain Errors
- `Keychain.Error.duplicate`: Item already exists
- `Keychain.Error.notFound`: Item not found
- `Keychain.Error.invalidTypeFormat`: Type conversion error
- `Keychain.Error.status(OSStatus, String?)`: System keychain errors

### SwiftData Errors
SwiftData operations throw standard `Error` types for database issues.

### Macro Errors
Macro validation errors appear at compile time, preventing runtime crashes.

## Best Practices

### Keychain
- Use descriptive service and account names
- Enable synchronization for user credentials that should sync across devices
- Handle `duplicate` errors gracefully by updating existing items
- Store only essential sensitive data

### Logging
- Create category-specific loggers for different app areas
- Use appropriate log levels (debug, info, error)
- Never log sensitive information

### SwiftData
- Use `count()` before large fetch operations
- Prefer `first()` over `fetch().first` for single items
- Use predicates to filter data at the database level

### Macros
- Validate all external URLs and UUIDs at compile time
- Use `@LocalizedEnum` for user-facing enum descriptions
- Set up proper localization keys for all enum cases

## Testing

Run the complete test suite:

```bash
swift test
```

Run tests with verbose output:

```bash
swift test -v
```

The test suite includes:
- Keychain CRUD operations and error handling
- Logger functionality and bundle integration
- Bundle extension property access
- SwiftData query method validation
- Macro expansion and compile-time validation

## License

This project is released into the public domain under the [Unlicense](UNLICENSE).
