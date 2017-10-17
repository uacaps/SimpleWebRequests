//
//  DataResources.swift
//  SimpleWebServiceRequestsDemo
//
//  Created by Niklas Fahl on 10/13/17.
//  Copyright © 2017 Niklas Fahl. All rights reserved.
//

import Foundation

public protocol DataResource {
    associatedtype Model: Codable
    var urlSessionConfiguration: URLSessionConfiguration { get set }
    var httpMethod: HttpMethod { get }
    var headers: [String: String]? { get set }
    var baseUrl: String { get }
    var methodPath: String? { get }
    var query: String? { get set }
    var body: Data? { get set }
}

public extension DataResource {
    // Full Url
    var url: URL? {
        var url = baseUrl
        
        guard let methodPath = methodPath else {
            return URL(string: url)
        }
        url += "/" + methodPath
        
        guard let query = query else {
            return URL(string: url)
        }
        url += query
        
        return URL(string: url)
    }
    
    // Setters
    mutating func setUrlSessionConfiguration(urlSessionConfiguration: URLSessionConfiguration) {
        self.urlSessionConfiguration = urlSessionConfiguration
    }
    
    mutating func setHeaders(headers: [String: String]) {
        self.headers = headers
    }
    
    mutating func setBody(body: Data?) {
        self.body = body
    }
    
    mutating func setQuery(query: String?) {
        self.query = query
    }
}
