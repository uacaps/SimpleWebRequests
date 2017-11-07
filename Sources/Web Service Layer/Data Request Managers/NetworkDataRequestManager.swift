//
//  ApiRequests.swift
//  SimpleWebServiceRequestsDemo
//
//  Created by Niklas Fahl on 10/13/17.
//  Copyright © 2017 Niklas Fahl. All rights reserved.
//

import Foundation

public class NetworkDataRequestManager: NetworkRequest {
    public init() {}
    
    func loadNetworkRequest(with resource: DataResource, completion: @escaping (Data?, Error?) -> Void) -> URLSessionTask {
        guard let url = resource.url else { return URLSessionTask() }
        
        // Make network request
        return load(url, httpMethod: resource.httpMethod, configuration: resource.urlSessionConfiguration, headers: resource.headers, body: resource.body, completion: { (data, response, error) in
            let responseData = data
            var responseError = error
            
            // HTTP Error
            if let httpResponse = response as? HTTPURLResponse, !(200...299 ~= httpResponse.statusCode) {
                responseError = NSError(domain: "Network Request", code: httpResponse.statusCode, userInfo: nil)
            }
            
            completion(responseData, responseError)
        })
    }
}

extension NetworkDataRequestManager: DataRequest {
    public func loadRequest<Model>(with resource: DataResource, completion: @escaping (Model?, Error?) -> Void) -> URLSessionTask where Model : Decodable, Model : Encodable {
        return loadNetworkRequest(with: resource, completion: { (data, error) in
            let response: (Model?, Error?) = DataResponse().decodeResponse(data: data, error: error)
            completion(response.0, response.1)
        })
    }
    
    public func loadVoidRequest(with resource: DataResource, completion: @escaping (Error?) -> Void) -> URLSessionTask {
        return loadNetworkRequest(with: resource, completion: { (_, error) in
            completion(error)
        })
    }
}
