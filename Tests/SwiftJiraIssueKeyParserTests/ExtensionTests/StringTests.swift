//
//  StringTests.swift
//  
//
//  Created by Dan Hart on 5/25/22.
//

import Foundation

import XCTest
@testable import SwiftJiraIssueKeyParser

class StringTests: XCTestCase {
    override func setUp() async throws {
        SwiftJiraIssueKeyParser.shared.instanceBaseURL = nil
    }
    
    func testJiraIssueKeyFromString() {
        let issueKey = "DAN-1234".jiraIssueKeys?.first
        XCTAssertNotNil(issueKey)
        XCTAssertEqual(issueKey?.id, "DAN-1234")
        XCTAssertEqual(issueKey?.projectKey, "DAN")
        XCTAssertEqual(issueKey?.sequentialNumber, 1234)
    }
    
    func testJiraIssueKeys() {
        XCTAssertEqual("TEST-1, TEST-2, and TEST-3".jiraIssueKeys, [
            JiraIssueKey(id: "TEST-1")!,
            JiraIssueKey(id: "TEST-2")!,
            JiraIssueKey(id: "TEST-3")!,
        ])
    }
    
    func testJiraIssueKeysProjects() {
        XCTAssertEqual("TEST-1, TEST-2, and TEST-3".jiraIssueKeys?.projects, ["TEST"])
        XCTAssertEqual("TEST-1, TEST-2, and SMART-3".jiraIssueKeys?.projects, ["TEST", "SMART"])
    }
    
    func testJiraIssueKeysSequentialNumbers() {
        XCTAssertEqual("TEST-1, TEST-2, and TEST-3".jiraIssueKeys?.sequentialNumbers, [1, 2, 3])
        XCTAssertEqual("TEST-1, TEST-2, and SMART-3".jiraIssueKeys?.sequentialNumbers, [1, 2, 3])
    }
    
    func testJiraIssueKeysEmpty() {
        XCTAssertEqual("".jiraIssueKeys, [])
        XCTAssertEqual(" ".jiraIssueKeys, [])
        XCTAssertEqual("nil".jiraIssueKeys, [])
    }
}
