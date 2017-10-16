//
//  NetworkResponseManager.swift
//  WebserviceOnSteroids
//
//  Created by Niklas Fahl on 10/13/17.
//  Copyright © 2017 Niklas Fahl. All rights reserved.
//

import Foundation

public struct NetworkResponseManager<Model: Codable> {
    public var data: Data?
    public var response: URLResponse?
    public var error: Error?
    
    public func dataResponse() -> DataResponse<Model> {
        guard error == nil && data != nil else {
            // General Error
            return .error(error: error!)
        }
        
        // HTTP Error
        if let httpResponse = response as? HTTPURLResponse, !(200...299 ~= httpResponse.statusCode) {
            return .httpError(statusCode: httpResponse.statusCode)
        }
        
        guard let model: Model = JSONCoder().decode(data: data) else {
            // JSON Decode Error
            return .error(error: error!)
        }
        
        return .success(model: model)
    }
}
