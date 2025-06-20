//
//  ABToolKit.swift
//  toolkit
//
//  Created by Maddie Schipper on 6/19/25.
//

import Foundation

internal let _identifier = "com.angryboat.swift-toolkit"

import Foundation

@freestanding(expression)
public macro UUID(_ uuidString: String) -> UUID = #externalMacro(module: "ToolKitMacro", type: "UUIDMacro")

@freestanding(expression)
public macro URL(_ urlString: String) -> URL = #externalMacro(module: "ToolKitMacro", type: "URLMacro")

@attached(member, names: named(localizedDescription))
public macro LocalizedEnum(prefix: String = "", separator: String = ".", bundle: Bundle? = nil) = #externalMacro(module: "ToolKitMacro", type: "LocalizedEnumMacro")
