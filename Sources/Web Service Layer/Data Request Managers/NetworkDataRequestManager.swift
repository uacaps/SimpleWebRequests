//
//  ApiRequests.swift
//  SimpleWebServiceRequestsDemo
//
//  Created by Niklas Fahl on 10/13/17.
//  Copyright © 2017 Niklas Fahl. All rights reserved.
//

import Foundation

open class NetworkDataRequestManager: NetworkRequest {
    public var securityPolicy: SecurityPolicy?
    
    public init() {}
    
    public init(securityPolicy: SecurityPolicy?) {
        self.securityPolicy = securityPolicy
    }
    
    public func loadNetworkRequest(with resource: DataResource, completion: @escaping (Data?, Error?) -> Void) -> URLSessionTask {
        guard let url = resource.url else { return URLSessionTask() }
        
        // Security Policy
        if let securityPolicy = securityPolicy {
            let secureResource = securityPolicy.addPolicy(for: resource)
            return makeNetworkRequest(with: url, httpMethod: secureResource.httpMethod, configuration: secureResource.urlSessionConfiguration, headers: secureResource.headers, body: secureResource.body, completion: completion)
        }
        
        // Make network request without security policy
        return makeNetworkRequest(with: url, httpMethod: resource.httpMethod, configuration: resource.urlSessionConfiguration, headers: resource.headers, body: resource.body, completion: completion)
    }
    
    func makeNetworkRequest(with url: URL, httpMethod: HttpMethod, configuration: URLSessionConfiguration, headers: [String: String]?, body: Data?, completion: @escaping (Data?, Error?) -> Void) -> URLSessionTask {
        return load(url, httpMethod: httpMethod, configuration: configuration, headers: headers, body: body, completion: { (data, response, error) in
            self.handleNetworkResponse(data: data, urlResponse: response, error: error, completion: completion)
        })
    }
    
    func handleNetworkResponse(data: Data?, urlResponse: URLResponse?, error: Error?, completion: @escaping (Data?, Error?) -> Void) {
        let responseData = data
        var responseError = error
        
        // HTTP Error
        if let httpResponse = urlResponse as? HTTPURLResponse, !(200...299 ~= httpResponse.statusCode) {
            responseError = NSError(domain: "Network Request", code: httpResponse.statusCode, userInfo: nil)
        }
        
        completion(responseData, responseError)
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
