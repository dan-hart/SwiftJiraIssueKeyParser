//
//  String+jiraIssueKeys.swift
//  
//
//  Created by Dan Hart on 5/25/22.
//

import Foundation

public extension String {
    /// parse issue key ids from this string if there are any
    public var jiraIssueKeys: [JiraIssueKey]? {
        return Array<JiraIssueKey>(string: self)
    }
}
