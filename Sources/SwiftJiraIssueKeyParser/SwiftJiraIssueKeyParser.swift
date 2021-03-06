//
//  SwiftJiraIssueKeyParser.swift
//  
//
//  Created by Dan Hart on 5/25/22.
//

import Foundation

/// Singleton to store jira-instance-level information
public class SwiftJiraIssueKeyParser {
    
    /// Singleton for `SwiftJiraIssueKeyParser`
    public static var shared = SwiftJiraIssueKeyParser()
    
    // MARK: - Properties
    
    /// Set this value to the desired base URL of jira, such as: "https://instance.jira.com/"
    public var instanceBaseURL: String?
}
