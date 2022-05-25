# SwiftJiraIssueKeyParser
Jira Issue Key Parser in Swift

## Example
```swift
import SwiftJiraIssueKeyParser

let issue = JiraIssueKey(string: "The issue is SMART-1")
print(issue.id) // "SMART-1"
```

## Installation
### [Swift Package Manager](https://swift.org/package-manager/)

```swift
dependencies: [
    .package(url: "https://github.com/dan-hart/SwiftJiraIssueKeyParser.git", from: "0.0.2")
]
```

Alternatively, you can add the package [directly via Xcode](https://developer.apple.com/documentation/xcode/adding_package_dependencies_to_your_app).

## Buy Me A Coffee
[!["Buy Me A Coffee"](https://www.buymeacoffee.com/assets/img/custom_images/orange_img.png)](https://www.buymeacoffee.com/codedbydan)
