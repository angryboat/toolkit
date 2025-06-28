# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

ABToolKit is a Swift Package Manager library providing essential utilities and macros for iOS and macOS development. The library targets iOS 26.0+ and macOS 26.0+ with Swift 6.2+, emphasizing compile-time safety through macros and secure utilities.

## Common Commands

### Build and Test
```bash
swift build          # Build the package
swift test           # Run all tests
swift build -v       # Verbose build output
swift test -v        # Verbose test output
```

### Development
```bash
swift package resolve          # Resolve package dependencies
swift package show-dependencies # Show dependency tree
```

## Architecture

### Two-Module Structure
- **ABToolKit**: Main library module containing utilities and UI components
- **ToolKitMacro**: Swift macro implementations using SwiftSyntax

### Key Components

**Utilities** (`Sources/ABToolKit/`):
- `Keychain.swift`: Secure storage wrapper with static methods for CRUD operations
- `Logger.swift`: OSLog extensions with bundle-aware initialization
- `Bundle.swift`: Extensions for app metadata access (version, display name, icon)
- `PersistentModel.swift`: SwiftData persistence helpers
- `UI/QueryView.swift`: SwiftUI component for dynamic SwiftData queries

**Macros** (`Sources/ToolKitMacro/`):
- `#UUID("string")`: Compile-time UUID validation
- `#URL("string")`: Compile-time URL validation
- `@LocalizedEnum`: Auto-generates localized enum descriptions
- Uses SwiftSyntax for AST manipulation and compile-time validation

### Dependencies
- **swift-syntax** (601.0.1): Required for macro functionality
- **Foundation, Security, OSLog**: System frameworks
- **SwiftUI, SwiftData**: UI and data frameworks
- **Swift Testing**: Modern testing framework (not XCTest)

### Testing Structure
- `ABToolKitTest/`: Main library tests organized by component
- `ToolKitMacroTest/`: Macro expansion and validation tests
- Uses Swift Testing framework with `@Test` functions

## Development Guidelines

### Adding New Macros
1. Implement in `ToolKitMacro` module using SwiftSyntax
2. Declare in `ABToolKit.swift` with `@freestanding` or `@attached` attributes
3. Add comprehensive tests in `ToolKitMacroTest`
4. Follow existing error handling patterns using `MacroError`

### Utility Development
- Use static methods for stateless utilities (like Keychain)
- Extend existing types rather than creating new classes when possible
- Maintain iOS 26.0+/macOS 26.0+ compatibility
- Provide comprehensive error handling and documentation

### Security Considerations
- Never log sensitive data in Logger implementations
- Use Keychain for all sensitive storage requirements
- Validate all inputs in macros at compile-time when possible
