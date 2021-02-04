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
    
    public init(urlSessionConfiguration: URLSessionConfiguration = .default, httpMethod: HttpMethod = .get, headers: [String: String]? = nil, baseUrl: String = "", methodPath: String? = nil, query: String? = nil, body: Data? = nil) {
        self.urlSessionConfiguration = urlSessionConfiguration
        self.httpMethod = httpMethod
        self.headers = headers
        self.baseUrl = baseUrl
        self.methodPath = methodPath
        self.query = query
        self.body = body
    }
}

public extension DataResource {
    // Full Url
    var url: URL? {
        var url = baseUrl.trimmingCharacters(in: CharacterSet(["/"]))

		if let methodPath = methodPath {
			url += "/" + methodPath.trimmingCharacters(in: CharacterSet(["/"]))
		}

		if let query = query {
			url += query
		}

		return URL(string: url)
    }
}
