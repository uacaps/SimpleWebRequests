# SimpleWebRequests

[![Version](https://img.shields.io/cocoapods/v/SimpleWebRequests.svg?style=flat)](http://cocoapods.org/pods/SimpleWebRequests)
[![License](https://img.shields.io/cocoapods/l/SimpleWebRequests.svg?style=flat)](http://cocoapods.org/pods/SimpleWebRequests)
[![Platform](https://img.shields.io/cocoapods/p/SimpleWebRequests.svg?style=flat)](http://cocoapods.org/pods/SimpleWebRequests)

## Requirements

- Swift 4
- iOS 10.3 and above

## Demo Project

The demo project shows how to implement a few different ways of dealing with web calls using this library. The custom request manager is only needed if you intend to be able to easily switch between different data sources.

## Installation

### CocoaPods

SimpleWebRequests is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'SimpleWebRequests'
```

### Manual

Add all of the files in the 'Sources' directory to your project and you'll be ready to go.

## Getting Started

This library allows you to have your web layer up and running quickly, but also allows for a more complex setup involving multiple data sources (release, development, local, mock), but more on that later.

To get started all you need to do is add a subclass of 'DataResource' for each of your web requests to your project. I recommend adding a file called '{ProjectName}DataResources.swift and putting your resources in this file as shown below:

*Note: The query and resource parameters are usually not static and will be set using 'setBody:' and 'setQuery:' at the time a resource is instatiated and used.*

```swift
//  MyApiResources.swift

import Foundation

// MARK: - Articles (GET)

struct GetArticlesResource: DataResource {
    typealias Model = [Article]
    
    var urlSessionConfiguration: URLSessionConfiguration = URLSessionConfiguration.default
    var httpMethod: HttpMethod = .get
    var headers: [String: String]?
    var baseUrl: String = "https://www.test.com"
    var methodPath: String? = "api/test"
    var query: String?
    var body: Data?
}
```

After setting up your resources you are ready to make some web calls as shown below:

```swift
let resource = AddArticlesResource()
let body = Article(title: "Test 1", description: "Testing article description.")
let sessionTask = NetworkDataRequest(resource: resource).load { (response) in
    switch response {
    case let .success(model):
        self.textView.text = "Title: \(model.title)\nDescription: \(model.description)"
    case let .error(error):
        print("General Error: \(error)")
    case let .httpError(statusCode):
        print("HTTP Error - Status Code: \(statusCode)")
    }
}
```

If your request requires a body set the body of the resource as shown below:

```swift
//let resource = AddArticlesResource()
let body = Article(title: "Test 1", description: "Testing article description.")
resource.setBody(body: JSONCoder.encode(object: body))
//let sessionTask = NetworkDataRequest(resource: resource).load { (response) in
//...
```

If your request requires a query set the query of the resource as shown below:

```swift
//let resource = AddArticlesResource()
resource.setQuery(query: "?something=something")
//let sessionTask = NetworkDataRequest(resource: resource).load { (response) in
//...
```

If your request requires headers set the headers of the resource as shown below:

```swift
//let resource = AddArticlesResource()
resource.setHeaders(headers: ["SomeHeaderKey": "SomeHeaderValue"])
//let sessionTask = NetworkDataRequest(resource: resource).load { (response) in
//...
```

## Advanced Setup

Coming soon...

## Author

[Niklas Fahl (fahlout)](http://bit.ly/fahlout) - [LinkedIn](http://bit.ly/linked-in-niklas-fahl)

Inspired by: http://mrgott.com/swift-programing/33-rest-api-in-swift-4-using-urlsession-and-jsondecode

## License

SimpleWebRequests is available under the MIT license. See the LICENSE file for more info.
