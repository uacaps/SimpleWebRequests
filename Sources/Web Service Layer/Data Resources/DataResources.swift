//
//  DataResources.swift
//  SimpleWebServiceRequestsDemo
//
//  Created by Niklas Fahl on 10/13/17.
//  Copyright © 2017 Niklas Fahl. All rights reserved.
//

import Foundation

public struct DataResource {
    var urlSessionConfiguration: URLSessionConfiguration = .default
    var httpMethod: HttpMethod = .get
    var headers: [String: String]?
    var baseUrl: String = ""
    var methodPath: String?
    var query: String?
    var body: Data?
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
}
