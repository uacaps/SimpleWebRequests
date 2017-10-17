//
//  ApiRequests.swift
//  WebserviceOnSteroids
//
//  Created by Niklas Fahl on 10/13/17.
//  Copyright © 2017 Niklas Fahl. All rights reserved.
//

import Foundation

public struct NetworkDataRequestManager: NetworkRequest {
    public init() {}
}

extension NetworkDataRequestManager: DataRequest {
    public func loadRequest<Resource: DataResource>(with resource: Resource, completion: @escaping (DataResponse<Resource.Model>) -> Void) -> URLSessionTask {
        // Get parameters to make network request
        guard let url = resource.url else { return URLSessionTask() }
        let httpMethod = resource.httpMethod
        let configuration = resource.urlSessionConfiguration
        let headers = resource.headers
        let body = resource.body
        
        // Make network request
        return load(url, httpMethod: httpMethod, configuration: configuration, headers: headers, body: body, completion: { (data, response, error) in
            let networkResponseManager = NetworkResponseManager<Resource.Model>(data: data, response: response, error: error)
            completion(networkResponseManager.dataResponse())
        })
    }
}
