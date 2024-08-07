//
//  JiraIssueKeyTests.swift
//  
//
//  Created by Dan Hart on 5/25/22.
//

import XCTest
@testable import SwiftJiraIssueKeyParser

class JiraIssueKeyTests: XCTestCase {
    override func setUp() async throws {
        SwiftJiraIssueKeyParser.shared.instanceBaseURL = nil
    }
    
    func testDelimiter() {
        // Consider changing this carefully
        XCTAssertEqual(JiraIssueKey.delimiter, "-")
    }
    
    func testExample() {
        XCTAssertNotNil(JiraIssueKey.example)
        XCTAssertEqual(JiraIssueKey.example.sequentialNumber, 1)
        XCTAssertEqual(JiraIssueKey.example.projectKey, "SMART")
        
        XCTAssertNotEqual(JiraIssueKey.example.projectKey, "smart") // No no
    }
    
    func testID() {
        XCTAssertEqual(JiraIssueKey.example.id, "SMART-1")
    }
    
    // MARK: - Success
    func testStringInitSuccess1() {
        let issueKey = JiraIssueKey(string: "       TEST-2       ")
        XCTAssertNotNil(issueKey)
        XCTAssertEqual(issueKey?.id, "TEST-2")
    }
    
    func testStringInitSuccess2() {
        let issueKey = JiraIssueKey(string: "aaa134987#)@($*%&)#$(*%&TEST-2#(*$&%)(#*$&%")
        XCTAssertNotNil(issueKey)
        XCTAssertEqual(issueKey?.id, "TEST-2")
    }
    
    func testStringInitSuccess3() {
        let testString = """
            Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea TEST-1234 commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
            """
        let issueKey = JiraIssueKey(string: testString)
        XCTAssertNotNil(issueKey)
        XCTAssertEqual(issueKey?.id, "TEST-1234")
    }
    
    // MARK: - Multiple Init
    func testStringInitMultipleValues() {
        XCTAssertEqual(JiraIssueKey(string: "")?.id, nil)
        XCTAssertEqual(JiraIssueKey(string: nil)?.id, nil)
        XCTAssertEqual(JiraIssueKey(string: " ")?.id, nil)
        XCTAssertEqual(JiraIssueKey(string: "nil")?.id, nil)
        XCTAssertEqual(JiraIssueKey(string: "null")?.id, nil)
        XCTAssertEqual(JiraIssueKey(string: "null-")?.id, nil)
        XCTAssertEqual(JiraIssueKey(string: "null-1")?.id, nil) // Note that lowercase DOES NOT MATCH
        XCTAssertEqual(JiraIssueKey(string: "NULL-1")?.id, "NULL-1")
        XCTAssertEqual(JiraIssueKey(string: "NULL-")?.id, nil)
        XCTAssertEqual(JiraIssueKey(string: "NULL")?.id, nil)
        XCTAssertEqual(JiraIssueKey(string: "TEST-0")?.id, "TEST-0") // 0 is a valid sequence
        XCTAssertEqual(JiraIssueKey(string: "NULL--1")?.id, nil) // Can't have double dash
        XCTAssertEqual(JiraIssueKey(string: "NULL--1TEST-1")?.id, "TEST-1")
        XCTAssertEqual(JiraIssueKey(string: "TEST-1234, TEST-5678")?.id, nil) // There can only be one!
        XCTAssertEqual(JiraIssueKey(string: "-----TEST-1-1-1")?.id, "TEST-1")
        XCTAssertEqual(JiraIssueKey(string: ".T.EST-1$4")?.id, "EST-1")
        XCTAssertEqual(JiraIssueKey(string: "t1")?.id, nil)
        XCTAssertEqual(JiraIssueKey(string: "t-9")?.id, nil)
        XCTAssertEqual(JiraIssueKey(string: "T-9")?.id, "T-9") // One character project is valid
        XCTAssertEqual(JiraIssueKey(string: "           A1")?.id, nil)
    }
    
    // MARK: - ID Initializer
    func testIDInitMultipleValues() {
        XCTAssertEqual(JiraIssueKey(id: "")?.id, nil)
        XCTAssertEqual(JiraIssueKey(id: " ")?.id, nil)
        XCTAssertEqual(JiraIssueKey(id: "nil")?.id, nil)
        XCTAssertEqual(JiraIssueKey(id: "null")?.id, nil)
        XCTAssertEqual(JiraIssueKey(id: "null-")?.id, nil)
        XCTAssertEqual(JiraIssueKey(id: "null-1")?.id, nil) // Note that lowercase DOES NOT MATCH
        XCTAssertEqual(JiraIssueKey(id: "NULL-1")?.id, "NULL-1")
        XCTAssertEqual(JiraIssueKey(id: "NULL-")?.id, nil)
        XCTAssertEqual(JiraIssueKey(id: "NULL")?.id, nil)
        XCTAssertEqual(JiraIssueKey(id: "NULL-1")?.id, "NULL-1")
        XCTAssertEqual(JiraIssueKey(id: "NULL-")?.id, nil)
        XCTAssertEqual(JiraIssueKey(id: "NULL")?.id, nil)
        XCTAssertEqual(JiraIssueKey(id: "TEST-0")?.id, "TEST-0") // 0 is a valid sequence
        XCTAssertEqual(JiraIssueKey(id: "NULL--1")?.id, nil) // Can't have double dash
        XCTAssertEqual(JiraIssueKey(id: "NULL--1TEST-1")?.id, "TEST-1")
        XCTAssertEqual(JiraIssueKey(id: "TEST-1234, TEST-5678")?.id, nil) // There can only be one!
        XCTAssertEqual(JiraIssueKey(id: "-----TEST-1-1-1")?.id, "TEST-1")
        XCTAssertEqual(JiraIssueKey(id: ".T.EST-1$4")?.id, "EST-1")
        XCTAssertEqual(JiraIssueKey(id: "t1")?.id, nil)
        XCTAssertEqual(JiraIssueKey(id: "t-9")?.id, nil)
        XCTAssertEqual(JiraIssueKey(id: "T-9")?.id, "T-9") // One character project is valid
        XCTAssertEqual(JiraIssueKey(id: "           A1")?.id, nil)
    }
    
    // MARK: - Project Key
    func testProjectKey() {
        XCTAssertEqual(JiraIssueKey(id: "SMART-1")?.projectKey, "SMART")
        XCTAssertEqual(JiraIssueKey(id: "SMART-1")?.sequentialNumber, 1)
        XCTAssertEqual(JiraIssueKey(id: "SMART-1")?.id, "SMART-1")
    }
    
    // MARK: - Test URL
    func testURLFailure() {
        XCTAssertThrowsError(try JiraIssueKey.example.url())
    }
    
    func testURLFromTextSuccess() {
        let key = JiraIssueKey(string: "https://jira.atlassian.com/browse/SMART-1")
        XCTAssertEqual(key?.id, "SMART-1")
    }
    
    func testURLSuccess1() {
        SwiftJiraIssueKeyParser.shared.instanceBaseURL = "https://jira.atlassian.com"
        let url = try? JiraIssueKey.example.url()
        XCTAssertNotNil(url)
        XCTAssertEqual(url?.absoluteString, "https://jira.atlassian.com/browse/SMART-1")
    }
    
    func testURLSuccess2() {
        SwiftJiraIssueKeyParser.shared.instanceBaseURL = "https://jira.atlassian.com/"
        XCTAssertEqual((try? JiraIssueKey.example.url())?.absoluteString, "https://jira.atlassian.com/browse/SMART-1")
    }
    
    func testURLSuccess3() {
        let url = JiraIssueKey.example.url(using: "https://acme.atlassian.net")
        XCTAssertEqual(url?.absoluteString, "https://acme.atlassian.net/browse/SMART-1")
    }
    
    func testURLSuccess4() {
        let url = JiraIssueKey.example.url(using: "localLink")
        XCTAssertEqual(url?.absoluteString, "localLink/browse/SMART-1")
    }
    
    func testURLMultiple() {
        SwiftJiraIssueKeyParser.shared.instanceBaseURL = "http://jira/"
        XCTAssertEqual((try? JiraIssueKey.example.url())?.absoluteString, "http://jira/browse/SMART-1")
        
        SwiftJiraIssueKeyParser.shared.instanceBaseURL = ""
        XCTAssertEqual((try? JiraIssueKey.example.url())?.absoluteString, nil)
        
        SwiftJiraIssueKeyParser.shared.instanceBaseURL = nil
        XCTAssertEqual((try? JiraIssueKey.example.url())?.absoluteString, nil)
        
        SwiftJiraIssueKeyParser.shared.instanceBaseURL = " "
        XCTAssertEqual((try? JiraIssueKey.example.url())?.absoluteString, nil)
        
        SwiftJiraIssueKeyParser.shared.instanceBaseURL = "jira"
        XCTAssertEqual((try? JiraIssueKey.example.url())?.absoluteString, "jira/browse/SMART-1")
    }
    
    // MARK: - Regex Tests
    func testRegexPattern() {
        XCTAssertNotNil(JiraIssueKey.regularExpressionPatternString)
        XCTAssertNotEqual(JiraIssueKey.regularExpressionPatternString, "")
        XCTAssertNotEqual(JiraIssueKey.regularExpressionPatternString, " ")
        
        // Make SURE this is the OFFICIAL Jira regex, we want to match what atlassian has
        // specified as much as possible.
        // https://confluence.atlassian.com/stashkb/integrating-with-custom-jira-issue-key-313460921.html
        XCTAssertEqual(JiraIssueKey.regularExpressionPatternString, "((?<!([A-Z]{1,10})-?)[A-Z]+-\\d+)")
    }
    
    func testNSRegularExpression() {
        let regex = JiraIssueKey.example.nsRegularExpression
        XCTAssertNotNil(regex)
        
        XCTAssertTrue(regex?.options.isEmpty ?? false)
        
        let regexFromInit = JiraIssueKey(id: "")?.nsRegularExpression
        XCTAssertNil(regexFromInit)
    }
    
    // MARK: - Equatable
    func testEquality() {
        XCTAssertEqual(JiraIssueKey(id: "SMART-2"), JiraIssueKey(id: "SMART-2"))
        XCTAssertNotEqual(JiraIssueKey(id: "SMART-1"), JiraIssueKey(id: "SMART-2"))
        XCTAssertNotEqual(JiraIssueKey(id: ""), JiraIssueKey(id: "SMART-2"))
    }
    
    // MARK: - Hashable
    func testHashable() {
        let key = JiraIssueKey(id: "SMART-2")!
        let key2 = JiraIssueKey(id: "SMART-2")!
        let key3 = JiraIssueKey(id: "SMART-1")!
        
        var set = Set<JiraIssueKey>()
        set.insert(key)
        set.insert(key2)
        set.insert(key3)
        
        XCTAssertEqual(set.count, 2)
    }
    
    // MARK: - Codable
    func testCodable() {
        let key = JiraIssueKey(id: "SMART-2")!
        let encoder = JSONEncoder()
        let decoder = JSONDecoder()
        
        let data = try? encoder.encode(key)
        XCTAssertNotNil(data)
        
        let decodedKey = try? decoder.decode(JiraIssueKey.self, from: data!)
        XCTAssertNotNil(decodedKey)
        XCTAssertEqual(decodedKey, key)
    }
}
