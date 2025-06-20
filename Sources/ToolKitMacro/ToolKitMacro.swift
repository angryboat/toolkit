//
//  ToolKitMacro.swift
//  toolkit
//
//  Created by Maddie Schipper on 1/28/25.
//

import Foundation
import SwiftCompilerPlugin
import SwiftSyntaxMacros

@main
struct ToolKitMacro : CompilerPlugin {
    let providingMacros: [Macro.Type] = [
        UUIDMacro.self,
        URLMacro.self,
        LocalizedEnumMacro.self,
    ]
}
