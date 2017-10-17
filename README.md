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

*Note: The header, query and resource parameters are usually not static and will be set using 'setHeaders:', 'setBody:' and 'setQuery:' at the time a resource is instatiated and used.*

```swift
//  {ProjectName}ApiResources.swift

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

If your request requires a body set the body of the resource directly in the class definition if they are non-changing or as shown below:

```swift
//let resource = AddArticlesResource()
let body = Article(title: "Test 1", description: "Testing article description.")
resource.setBody(body: JSONCoder.encode(object: body))
//let sessionTask = NetworkDataRequest(resource: resource).load { (response) in
//...
```

If your request requires a query set the query of the resource directly in the class definition if they are non-changing or as shown below:

```swift
//let resource = AddArticlesResource()
resource.setQuery(query: "?something=something")
//let sessionTask = NetworkDataRequest(resource: resource).load { (response) in
//...
```

If your request requires headers set the headers of the resource directly in the class definition if they are non-changing or as shown below:

```swift
//let resource = AddArticlesResource()
resource.setHeaders(headers: ["SomeHeaderKey": "SomeHeaderValue"])
//let sessionTask = NetworkDataRequest(resource: resource).load { (response) in
//...
```

## Advanced Setup

The advanced setup lets you automatically switch between different data sources through a common manager class. For this setup you will need to inherit from the following structs/protocols. Again I'm recommending to prefix your classes with your project name for claity.

```
protocol ApiInformation
protocol DataRequestManager
class MockDataRequestManager (optional)
class LocalDataRequestManager (optional)
```

Let's start with the ApiInformation. This class will let you set your desired data source that's used at runtime. In the below example I'm switching between data sources depending on if my app is running in debug or in release as set in my apps build configuration.

```swift
//  {ProjectName}ApiInformation.swift

struct {ProjectName}ApiInformation: ApiInformation {
    #if DEBUG
    var dataSource: DataSource = DataSource(type: .development, baseUrl: "http://development.something.com")
    #else
    var dataSource: DataSource = DataSource(type: .release, baseUrl: "https://release.something.com")
    #endif
}
```

The next part to be setup is the data request manager that handles the data source switching as shown below:

*Note: The online data request manager will be set to a new instance of NetworkDataRequestManager unless you desire to to make your own class inheriting from it to make desired changes to the class.*

```swift
//  {ProjectName}DataRequestManager.swift

public struct {ProjectName}DataRequestManager: DataRequestManager {
    public typealias Resource = DataResource
    public var apiInformation: ApiInformation = {ProjectName}ApiInformation()
    public var onlineDataRequestManager: NetworkDataRequestManager = NetworkDataRequestManager()
    public var localDataRequestManager: LocalDataRequestManager? = {ProjectName}LocalDataRequestManager()
    public var mockDataRequestManager: MockDataRequestManager? = {ProjectName}MockDataRequestManager()
    
    public static var shared: {ProjectName}DataRequestManager = {ProjectName}DataRequestManager()
}
```

The mock as well as the local request manager are setup very similarly and really depend on your implementation and how you want to handle these data requests as this library only provides a shell for these parts so that the data request manager can switch based on data sources. Below is an example of what each may look like:

Mock Data Request Manager
*Note: In the switch statement I'm showing how each resource case can be handled based on its type. Make sure to generate and return your appropriate mock data for each case statement.*

```swift
//  {ProjectName}MockDataRequest.swift

public class {ProjectName}MockDataRequestManager: MockDataRequestManager {
    // All your custom variables to allow mocking your server
    var articles: [Article] = [Article(title: "Mock 1", description: "Mocking an article."), Article(title: "Mock 2", description: "Mocking an article again.")]
    
    public override func loadRequest<Resource: DataResource>(with resource: Resource, completion: @escaping (DataResponse<Resource.Model>) -> Void) -> URLSessionTask {
        return handleRequest(with: resource, completion: completion)
    }
}

extension {ProjectName}MockDataRequestManager {
    
    // MARK: - Handle Request
    
    func handleRequest<Resource: DataResource>(with resource: Resource, completion: @escaping (DataResponse<Resource.Model>) -> Void) -> URLSessionTask {
        switch resource.self {
        case is GetArticlesResource:
            getArticles(completion: completion as! (DataResponse<GetArticlesResource.Model>) -> Void)
        default:
            return URLSessionTask()
        }
        return URLSessionTask()
    }
}

extension {ProjectName}MockDataRequestManager {
    
    // MARK: - Articles (GET)
    
    func getArticles(completion: @escaping (DataResponse<GetArticlesResource.Model>) -> Void)  {
        let response: DataResponse = .success(model: articles)
        completion(response)
    }
}
```

Local Data Request Manager
*Note: In the switch statement I'm showing how each resource case can be handled based on its type. Make sure to return your appropriate data from a local database for example for each case statement.*

```swift
//  {ProjectName}LocalDataRequest.swift

public class {ProjectName}LocalDataRequestManager: LocalDataRequestManager {
    public override func loadRequest<Resource: DataResource>(with resource: Resource, completion: @escaping (DataResponse<Resource.Model>) -> Void) -> URLSessionTask {
        // Get offline data
        return handleRequest(with: resource, completion: completion)
    }
}

extension {ProjectName}LocalDataRequestManager {
    
    // MARK: - Handle Request
    
    func handleRequest<Resource: DataResource>(with resource: Resource, completion: @escaping (DataResponse<Resource.Model>) -> Void) -> URLSessionTask {
        switch resource.self {
        case is GetArticlesResource:
            let error = NSError(domain: "Local Data Fetch Error", code: 1, userInfo: nil)
            let response: DataResponse = DataResponse<Resource.Model>.error(error: error)
            completion(response)
        default:
            return URLSessionTask()
        }
        return URLSessionTask()
    }
}
```

## Author

[Niklas Fahl (fahlout)](http://bit.ly/fahlout) - [LinkedIn](http://bit.ly/linked-in-niklas-fahl)

Inspired by: http://mrgott.com/swift-programing/33-rest-api-in-swift-4-using-urlsession-and-jsondecode

## License

SimpleWebRequests is available under the MIT license. See the LICENSE file for more info.
