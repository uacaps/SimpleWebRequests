//
//  MyApiResources.swift
//  WebserviceOnSteroids
//
//  Created by Niklas Fahl on 10/13/17.
//  Copyright © 2017 Niklas Fahl. All rights reserved.
//

import Foundation

// MARK: - Rolls (GET, POST)

struct GetArticlesResource: DataResource {
    typealias Model = [Article]
    
    var urlSessionConfiguration: URLSessionConfiguration = URLSessionConfiguration.default
    var httpMethod: HttpMethod = .get
    var headers: [String: String]?
    var baseUrl: String = MyApiInformation().dataSource.baseUrl
    var methodPath: String? = "blog.json"
    var query: String?
    var body: Data?
}
