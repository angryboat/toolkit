# ABToolKit

A Swift package providing essential utilities and macros for iOS and macOS development.

## Features

### Core Utilities
- **Keychain**: Secure storage utilities for sensitive data
- **Logger**: Logging framework for debugging and monitoring
- **PersistentModel**: Data persistence helpers
- **UI Components**: Reusable UI elements including QueryView

### Swift Macros
- **@UUID**: Compile-time UUID validation and creation
- **@URL**: Compile-time URL validation and creation  
- **@LocalizedEnum**: Automatic localized string generation for enums

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

## Usage

### Macros

```swift
import ABToolKit

// UUID macro - validates UUID strings at compile time
let id = #UUID("550e8400-e29b-41d4-a716-446655440000")

// URL macro - validates URLs at compile time
let website = #URL("https://example.com")

// LocalizedEnum macro - generates localized descriptions
@LocalizedEnum(prefix: "error")
enum ErrorType: String, CaseIterable {
    case network
    case parsing
    case unknown
}
```

### Utilities

```swift
import ABToolKit

// Use Logger for debugging
// Use Keychain for secure storage
// Use PersistentModel for data persistence
```

## Testing

Run tests with:

```bash
swift test
```

## License

This project is released into the public domain under the [Unlicense](UNLICENSE).