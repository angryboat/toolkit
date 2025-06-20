//
//  LoggerTest.swift
//  toolkit
//
//  Created by Maddie Schipper on 6/19/25.
//

import Testing
import OSLog
import ABToolKit

@Test
func createNewLoggerInstance() {
    Logger(category: "TestLogger").debug(#function)
}
