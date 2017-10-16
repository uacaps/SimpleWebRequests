//
//  DataRequestManager.swift
//  WebserviceOnSteroids
//
//  Created by Niklas Fahl on 10/13/17.
//  Copyright © 2017 Niklas Fahl. All rights reserved.
//

import Foundation

public protocol DataRequestManager {
    var apiInformation: ApiInformation { get }
    var onlineDataRequest: NetworkDataRequest { get }
    var localDataRequest: LocalDataRequest? { get }
    var mockDataRequest: MockDataRequest? { get }
    
    static var shared: Self { get }
}

extension DataRequestManager {
    public func loadRequest<Resource: DataResource>(with resource: Resource, completion: @escaping (DataResponse<Resource.Model>) -> Void) -> URLSessionTask {
        switch apiInformation.dataSource.type {
        case .release, .development:
            return onlineDataRequest.loadRequest(with: resource, completion: completion)
        case .local:
            return localDataRequest?.loadRequest(with: resource, completion: completion) ?? URLSessionTask()
        case .mock:
            return mockDataRequest?.loadRequest(with: resource, completion: completion) ?? URLSessionTask()
        }
    }
}
