//
//  Array+JiraIssueKey.swift
//  
//
//  Created by Dan Hart on 5/25/22.
//

import Foundation

/// Extend the functionality of an array where the element is a jira issue key
extension Array where Element == JiraIssueKey {
    /// Create an array of `JiraIssueKey` with a given string
    /// - Parameter string: string containing none or some key ids
    public init?(string: String) {
        guard let results = JiraIssueKey.with(text: string) else {
            return nil
        }
        self = results
    }
}
