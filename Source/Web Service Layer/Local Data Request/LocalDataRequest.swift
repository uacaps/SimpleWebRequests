//
//  LocalDataRequest.swift
//  WebserviceOnSteroids
//
//  Created by Niklas Fahl on 10/16/17.
//  Copyright © 2017 Niklas Fahl. All rights reserved.
//

import Foundation

public class LocalDataRequest: DataRequest {
    public func loadRequest<Resource: DataResource>(with resource: Resource, completion: @escaping (DataResponse<Resource.Model>) -> Void) -> URLSessionTask {
        // Override in your custom class
        fatalError("Must override. Handle load request in custom class.")
    }
}
