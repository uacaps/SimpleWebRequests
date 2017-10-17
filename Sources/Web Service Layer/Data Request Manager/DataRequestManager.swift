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
    var onlineDataRequestManager: NetworkDataRequestManager { get }
    var localDataRequestManager: LocalDataRequestManager? { get }
    var mockDataRequestManager: MockDataRequestManager? { get }
    
    static var shared: Self { get }
}

extension DataRequestManager {
    public func loadRequest<Resource: DataResource>(with resource: Resource, completion: @escaping (DataResponse<Resource.Model>) -> Void) -> URLSessionTask {
        switch apiInformation.dataSource.type {
        case .release, .development:
            return onlineDataRequestManager.loadRequest(with: resource, completion: completion)
        case .local:
            return localDataRequestManager?.loadRequest(with: resource, completion: completion) ?? URLSessionTask()
        case .mock:
            return mockDataRequestManager?.loadRequest(with: resource, completion: completion) ?? URLSessionTask()
        }
    }
}
