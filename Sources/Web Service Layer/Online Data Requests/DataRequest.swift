//
//  Request.swift
//  SimpleWebServiceRequestsDemo
//
//  Created by Niklas Fahl on 10/13/17.
//  Copyright © 2017 Niklas Fahl. All rights reserved.
//

import Foundation

public protocol DataRequest {
    func loadRequest<Model: Codable>(with resource: DataResource, completion: @escaping (Model?, Error?) -> Void) -> URLSessionTask
    func loadVoidRequest(with resource: DataResource, completion: @escaping (Error?) -> Void) -> URLSessionTask
}
