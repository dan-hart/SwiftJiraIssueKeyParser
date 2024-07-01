//
//  SwiftJiraIssueKeyParser.swift
//  
//
//  Created by Dan Hart on 5/25/22.
//

import Foundation
#if canImport(UIKit)
    import UIKit
#endif

#if canImport(AppKit)
    import AppKit
#endif

/// Singleton to store jira-instance-level information
public class SwiftJiraIssueKeyParser {
    
    /// Singleton for `SwiftJiraIssueKeyParser`
    public static var shared = SwiftJiraIssueKeyParser()
    
    // MARK: - Properties
    
    /// Set this value to the desired base URL of jira
    /// **Examples**
    /// - https://instance.jira.com/
    /// - https://instance.atlassian.net/
    public var instanceBaseURL: String?
    
    // MARK: - Functions
    
    /// Open the provided URL
    static func go(to url: URL?) -> Bool {
        guard let url = url else {
            return false
        }

        #if canImport(UIKit)
        UIApplication.shared.open(url)
        return true
        #else
        return false
        #endif
        
        #if canImport(AppKit)
        NSWorkspace.shared.open(url)
        return true
        #endif
    }
}
