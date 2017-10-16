//
//  MyLocalDataRequest.swift
//  WebserviceOnSteroids
//
//  Created by Niklas Fahl on 10/16/17.
//  Copyright © 2017 Niklas Fahl. All rights reserved.
//

import Foundation

public class MyLocalDataRequest: LocalDataRequest {
    public override func loadRequest<Resource: DataResource>(with resource: Resource, completion: @escaping (DataResponse<Resource.Model>) -> Void) -> URLSessionTask {
        // Get offline data
        return handleRequest(with: resource, completion: completion)
    }
}

extension MyLocalDataRequest {
    
    // MARK: - Handle Request
    
    func handleRequest<Resource: DataResource>(with resource: Resource, completion: @escaping (DataResponse<Resource.Model>) -> Void) -> URLSessionTask {
        switch resource.self {
        case is GetArticlesResource:
            let error = NSError(domain: "Local Data Fetch Error", code: 1, userInfo: nil)
            let response: DataResponse = DataResponse<Resource.Model>.error(error: error)
            completion(response)
        default:
            return URLSessionTask()
        }
        return URLSessionTask()
    }
}
