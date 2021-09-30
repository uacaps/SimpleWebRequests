//
//  JSONCoder.swift
//  SimpleWebServiceRequestsDemo
//
//  Created by Niklas Fahl on 10/11/17.
//  Copyright © 2017 Niklas Fahl. All rights reserved.
//

import Foundation

public final class JSONCoder {
    
    public class func encode<T>(object: T, dateEncodingStrategy: JSONEncoder.DateEncodingStrategy = .iso8601) -> Data? where T: Encodable {
        do {
            let encoder = JSONEncoder()
            encoder.dateEncodingStrategy = dateEncodingStrategy
            return try encoder.encode(object)
        } catch let error {
            print("JSON Coder: Could not encode object to JSON data. Error: \(error)")
            return nil
        }
    }
    
    public class func decode<T>(data: Data?, dateDecodingStrategy: JSONDecoder.DateDecodingStrategy = .iso8601) -> T? where T: Decodable {
        guard let data = data else { return nil }
        
        do {
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = dateDecodingStrategy
            return try decoder.decode(T.self, from: data)
        } catch let error {
            print("JSON Coder: Could not decode JSON data to object. Error: \(error)")
            return nil
        }
    }
}
