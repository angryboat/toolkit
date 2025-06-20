//
//  Bundle.swift
//  toolkit
//
//  Created by Maddie Schipper on 6/19/25.
//

import Foundation

extension Bundle {
    /// The build version number (CFBundleVersion).
    public var bundleVersion: String? {
        return infoDictionary?["CFBundleVersion"] as? String
    }
    
    /// The user-facing version string (CFBundleShortVersionString).
    public var bundleShortVersion: String? {
        return infoDictionary?["CFBundleShortVersionString"] as? String
    }
    
    /// The app display name (CFBundleDisplayName).
    public var bundleDisplayName: String? {
        return infoDictionary?["CFBundleDisplayName"] as? String
    }
    
    /// The copyright notice (NSHumanReadableCopyright).
    public var bundleHumanReadableCopyright: String? {
        return infoDictionary?["NSHumanReadableCopyright"] as? String
    }
    
    /// The primary app icon filename.
    public var appIconName: String? {
        guard let icons = infoDictionary?["CFBundleIcons"] as? [String: Any] else {
            return infoDictionary?["CFBundleIconFile"] as? String
        }
        guard let primary = icons["CFBundlePrimaryIcon"] as? [String: Any] else {
            return infoDictionary?["CFBundleIconFile"] as? String
        }
        guard let files = primary["CFBundleIconFiles"] as? [String] else {
            return infoDictionary?["CFBundleIconFile"] as? String
        }
        
        return files.first
    }
}
