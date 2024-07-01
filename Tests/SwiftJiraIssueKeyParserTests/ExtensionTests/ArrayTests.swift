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
        XCTAssertEqual(Array<JiraIssueKey>(string: "TEST-1, TEST-2, and TEST-3"), [
            JiraIssueKey(id: "TEST-1")!,
            JiraIssueKey(id: "TEST-2")!,
            JiraIssueKey(id: "TEST-3")!,
        ])
    }
    
    func testProjects() {
        XCTAssertEqual(Array<JiraIssueKey>(string: "TEST-1, TEST-2, and TEST-3")?.projects, ["TEST"])
        XCTAssertEqual(Array<JiraIssueKey>(string: "TEST-1, TEST-2, and SMART-3")?.projects, ["TEST", "SMART"])
    }
    
    func testSequentialNumbers() {
        XCTAssertEqual(Array<JiraIssueKey>(string: "TEST-1, TEST-2, and TEST-3")?.sequentialNumbers, [1, 2, 3])
        XCTAssertEqual(Array<JiraIssueKey>(string: "TEST-1, TEST-2, and SMART-3")?.sequentialNumbers, [1, 2, 3])
    }
}
