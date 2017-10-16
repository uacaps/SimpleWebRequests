//
//  JSONCoder.swift
//  WebserviceOnSteroids
//
//  Created by Niklas Fahl on 10/11/17.
//  Copyright © 2017 Niklas Fahl. All rights reserved.
//

import Foundation

public final class JSONCoder {
    
    public class func encode<T>(object: T) -> Data? where T: Encodable {
        do {
            return try JSONEncoder().encode(object)
        } catch let error {
            print("JSON Coder: Could not encode object to JSON data. Error: \(error)")
            return nil
        }
    }
    
    public class func decode<T>(data: Data?) -> T? where T: Decodable {
        guard let data = data else { return nil }
        
        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch let error {
            print("JSON Coder: Could not decode JSON data to object. Error: \(error)")
            return nil
        }
    }
}
