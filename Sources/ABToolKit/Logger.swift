//
//  Logger.swift
//  toolkit
//
//  Created by Maddie Schipper on 6/19/25.
//

import Foundation
import OSLog

extension Logger {
    public init(bundle: Bundle = .main, category: String) {
        self.init(subsystem: bundle.bundleIdentifier ?? _identifier, category: category)
    }
}
