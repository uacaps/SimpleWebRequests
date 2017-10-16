//
//  DataResources.swift
//  WebserviceOnSteroids
//
//  Created by Niklas Fahl on 10/13/17.
//  Copyright © 2017 Niklas Fahl. All rights reserved.
//

import Foundation

public protocol DataResource {
    associatedtype Model: Codable
    var urlSessionConfiguration: URLSessionConfiguration { get }
    var httpMethod: HttpMethod { get }
    var headers: [String: String]? { get }
    var baseUrl: String { get }
    var methodPath: String? { get }
    var query: String? { get }
    var body: Data? { get set }
}

public extension DataResource {
    mutating func setBody(body: Data?) {
        self.body = body
    }
    
    var url: URL? {
        var url = baseUrl
        
        guard let methodPath = methodPath else {
            return URL(string: url)
        }
        url += "/" + methodPath
        
        guard let query = query else {
            return URL(string: url)
        }
        url += "?" + query
        
        return URL(string: url)
    }
}
