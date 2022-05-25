//
//  ArrayTests.swift
//  
//
//  Created by Dan Hart on 5/25/22.
//

import Foundation

import XCTest
@testable import SwiftJiraIssueKeyParser

class ArrayTests: XCTestCase {
    override func setUp() async throws {
        SwiftJiraIssueKeyParser.shared.instanceBaseURL = nil
    }
    
    func testInit() {
        XCTAssertEqual("TEST-1, TEST-2, and TEST-3".jiraIssueKeys, [
            JiraIssueKey(id: "TEST-1")!,
            JiraIssueKey(id: "TEST-2")!,
            JiraIssueKey(id: "TEST-3")!,
        ])
    }
}
