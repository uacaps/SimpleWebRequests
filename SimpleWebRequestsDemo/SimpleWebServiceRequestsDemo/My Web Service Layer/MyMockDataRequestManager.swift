//
//  MyMockDataRequest.swift
//  WebserviceOnSteroids
//
//  Created by Niklas Fahl on 10/13/17.
//  Copyright © 2017 Niklas Fahl. All rights reserved.
//

import Foundation

public class MyMockDataRequestManager: MockDataRequestManager {
    // All your custom variables to allow mocking your server
    var articles: [Article] = [Article(title: "Mock 1", description: "Mocking an article."), Article(title: "Mock 2", description: "Mocking an article again.")]
    
    public override func loadRequest<Resource: DataResource>(with resource: Resource, completion: @escaping (DataResponse<Resource.Model>) -> Void) -> URLSessionTask {
        return handleRequest(with: resource, completion: completion)
    }
}

extension MyMockDataRequestManager {
    
    // MARK: - Handle Request
    
    func handleRequest<Resource: DataResource>(with resource: Resource, completion: @escaping (DataResponse<Resource.Model>) -> Void) -> URLSessionTask {
        switch resource.self {
        case is GetArticlesResource:
            getArticles(completion: completion as! (DataResponse<GetArticlesResource.Model>) -> Void)
        default:
            return URLSessionTask()
        }
        return URLSessionTask()
    }
}

extension MyMockDataRequestManager {
    
    // MARK: - Rolls (GET, POST)
    
    func getArticles(completion: @escaping (DataResponse<GetArticlesResource.Model>) -> Void)  {
        let response: DataResponse = .success(model: articles)
        completion(response)
    }
}
