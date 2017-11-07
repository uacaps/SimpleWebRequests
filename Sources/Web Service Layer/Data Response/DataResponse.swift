//
//  DataResponseManager.swift
//  SimpleWebServiceRequestsDemo
//
//  Created by Niklas Fahl on 11/7/17.
//  Copyright © 2017 Niklas Fahl. All rights reserved.
//

import Foundation

class DataResponse {
    
    func decodeResponse<Model: Codable>(data: Data?, error: Error?) -> (model: Model?, error: Error?) {
        // Check if data came back from web call
        guard let data = data else {
            return (nil, error)
        }
        
        // Decode JSON data into object if data is available
        do {
            let model: Model = try JSONDecoder().decode(Model.self, from: data)
            return (model, nil)
        } catch let error {
            print("JSON Coder: Could not decode JSON data to object. Error: \(error)")
            return (nil, error)
        }
    }
}
