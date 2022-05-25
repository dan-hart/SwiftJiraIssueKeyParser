//
//  String+jiraIssueKeys.swift
//  
//
//  Created by Dan Hart on 5/25/22.
//

import Foundation

extension String {
    /// parse issue key ids from this string if there are any
    var jiraIssueKeys: [JiraIssueKey]? {
        return Array<JiraIssueKey>(string: self)
    }
}
