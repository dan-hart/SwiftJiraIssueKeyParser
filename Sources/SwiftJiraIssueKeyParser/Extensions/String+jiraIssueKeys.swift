//
//  String+jiraIssueKeys.swift
//  
//
//  Created by Dan Hart on 5/25/22.
//

import Foundation

public extension String {
    /// the first issue key in this string if there is one
    var firstJiraIssueKey: JiraIssueKey? {
        return jiraIssueKeys?.first
    }
    
    /// parse issue key ids from this string if there are any
    var jiraIssueKeys: [JiraIssueKey]? {
        return Array<JiraIssueKey>(string: self)
    }
}
