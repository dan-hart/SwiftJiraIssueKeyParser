//
//  JiraIssueKey.swift
//  
//
//  Created by Dan Hart on 5/25/22.
//

import Foundation

/// https://support.atlassian.com/jira-software-cloud/docs/what-is-an-issue/
public struct JiraIssueKey: Codable, Equatable, Hashable {
    /// Combine the project key, delimiter, and sequential number to create the issue key's identifier
    public var id: String {
        projectKey + JiraIssueKey.delimiter + "\(sequentialNumber)"
    }
    
    /// Uppercase text, i.e. "SMART"
    public let projectKey: String
    
    /// Number starting at 0
    public let sequentialNumber: Int
    
    /// Delimiter between the project key and sequential number
    public static let delimiter = "-"
    
    // MARK: - Initializers
    
    /// create a `JiraIssueKey` if there is ONE contained within this string
    public init?(string: String?) {
        guard let results = JiraIssueKey.with(text: string) else {
            return nil
        }
        if results.count == 1 {
            self = results.first!
        } else {
            return nil
        }
    }
    
    /// Initialize a `JiraIssueKey` from an ID string
    /// - Parameter string: a string containing a jira issue key ID
    public init?(id string: String) {
        guard let regex = try? NSRegularExpression(pattern: JiraIssueKey.regularExpressionPatternString) else {
            return nil
        }
        let results = regex.matches(in: string, range: NSRange(string.startIndex..., in: string))
        if results.count == 1 {
            let match = results.first!
            let id = String(string[Range(match.range, in: string)!])
            let split = id.components(separatedBy: JiraIssueKey.delimiter)
            
            self.projectKey = split.first!
            self.sequentialNumber = Int(split.last!)!
        } else {
            return nil
        }
    }
}

// MARK: - Functions
extension JiraIssueKey {
    /// Using the `SwiftJiraIssueKeyParser` base url, return this issue's url
    public func url() throws -> URL? {
        if let baseURL = SwiftJiraIssueKeyParser.shared.instanceBaseURL,
           !baseURL.isEmpty,
           !baseURL.trimmingCharacters(in: .whitespaces).isEmpty {
            return url(using: baseURL)
        } else {
            throw JiraIssueKeyError.missingBaseURL
        }
    }
    
    /// Create a URL using the given jira instance url
    /// - Parameter instanceBaseURL: i.e. "https://instance.jira.com/"
    /// - Returns: a URL with the proper components added to view this issue
    public func url(using instanceBaseURL: String) -> URL? {
        guard let baseURL = URL(string: instanceBaseURL) else { return nil }
        var browseURL = baseURL.appendingPathComponent("browse", isDirectory: true)
        browseURL.appendPathComponent(id)
        return browseURL
    }
}

// MARK: - Regex
extension JiraIssueKey {
    /// https://confluence.atlassian.com/stashkb/integrating-with-custom-jira-issue-key-313460921.html
    public static let regularExpressionPatternString = "((?<!([A-Z]{1,10})-?)[A-Z]+-\\d+)"
    
    /// Create a computed property that makes a new `NSRegularExpression` for every call, this allows for customizing the options when needed, however, keep in mind you're creating a new object every time you call this.
    public var nsRegularExpression: NSRegularExpression? {
        return try? NSRegularExpression(pattern: JiraIssueKey.regularExpressionPatternString)
    }
    
    /// determine if there are any jira issue key id's in the provided string
    /// - Parameter text: string with optional jira issue key ids
    /// - Returns: an optional array of `JiraIssueKey`
    public static func with(text: String?) -> [JiraIssueKey]? {
        guard let text = text else {
            return nil
        }
        guard let regex = try? NSRegularExpression(pattern: JiraIssueKey.regularExpressionPatternString) else {
            return nil
        }
        let results = regex.matches(in: text, range: NSRange(text.startIndex..., in: text))
        if results.isEmpty {
            return []
        } else {
            var issueKeys = [JiraIssueKey]()
            for match in results {
                let id = String(text[Range(match.range, in: text)!])
                if let issueKey = JiraIssueKey(id: id) {
                    issueKeys.append(issueKey)
                }
            }
            return issueKeys
        }
    }
}

// MARK: - Example
#if DEBUG
extension JiraIssueKey {
    public static let example: JiraIssueKey = JiraIssueKey(id: "SMART-1")!
}
#endif
