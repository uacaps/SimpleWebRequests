//
//  NetworkRequest.swift
//  SimpleWebServiceRequestsDemo
//
//  Created by Niklas Fahl on 10/13/17.
//  Copyright © 2017 Niklas Fahl. All rights reserved.
//

import UIKit

public enum HttpMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

public protocol NetworkRequest {
    var securityPolicy: SecurityPolicy? { get set }
}

public extension NetworkRequest {
    public func load(_ url: URL, httpMethod: HttpMethod, configuration: URLSessionConfiguration, headers: [String: String]?, body: Data?, completion: @escaping (_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Void) -> URLSessionTask {
        // Show loading indicator
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        // Create Session
        let session = URLSession(configuration: configuration, delegate: nil, delegateQueue: OperationQueue.main)
        
        // Create Request With Method and Body (optional)
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod.rawValue
        request.httpBody = body ?? nil
        
        // Add HTTP Header Fields
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        for header in (headers ?? [:]) { request.addValue(header.value, forHTTPHeaderField: header.key) }
        
        // Run Task
        let task = session.dataTask(with: request, completionHandler: { (data: Data?, response: URLResponse?, error: Error?) -> Void in
            // Hide loading indicator
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            
            completion(data, response, error)
        })
        task.resume()
        return task
    }
}
