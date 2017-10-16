//
//  MockDataRequestManager.swift
//  WebserviceOnSteroids
//
//  Created by Niklas Fahl on 10/13/17.
//  Copyright © 2017 Niklas Fahl. All rights reserved.
//

import Foundation

open class MockDataRequest: DataRequest {
    public init() {}
    
    open func loadRequest<Resource: DataResource>(with resource: Resource, completion: @escaping (DataResponse<Resource.Model>) -> Void) -> URLSessionTask {
        // Override in your custom class
        fatalError("Must override. Handle load request in custom class.")
    }
}
