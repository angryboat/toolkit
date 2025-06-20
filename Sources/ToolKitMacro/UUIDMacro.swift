//
//  UUIDMacro.swift
//  toolkit
//
//  Created by Maddie Schipper on 1/18/25.
//

import Foundation
import SwiftSyntax
import SwiftSyntaxMacros

public struct UUIDMacro : ExpressionMacro {
    public static func expansion(of node: some FreestandingMacroExpansionSyntax, in context: some MacroExpansionContext) throws -> ExprSyntax {
        guard let argument = node.arguments.first?.expression else {
            throw MacroError.argumentError("Missing required argument at index 0")
        }
        guard let segments = argument.as(StringLiteralExprSyntax.self)?.segments else {
            throw MacroError.invalidArgumentType(String.self, 0)
        }
        guard let _ = UUID(uuidString: segments.description) else {
            throw MacroError(name: "UUIDError", message: "UUID string is invalid or malformed")
        }
        
        return "UUID(uuidString: \(argument))!"
    }
}
