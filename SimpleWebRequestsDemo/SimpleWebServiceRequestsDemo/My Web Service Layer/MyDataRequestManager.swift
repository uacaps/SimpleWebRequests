//
//  MyDataRequestManager.swift
//  WebserviceOnSteroids
//
//  Created by Niklas Fahl on 10/13/17.
//  Copyright © 2017 Niklas Fahl. All rights reserved.
//

import Foundation

public struct MyDataRequestManager: DataRequestManager {
    public typealias Resource = DataResource
    public var apiInformation: ApiInformation = MyApiInformation()
    public var onlineDataRequestManager: NetworkDataRequestManager = NetworkDataRequestManager()
    public var localDataRequestManager: LocalDataRequestManager? = MyLocalDataRequestManager()
    public var mockDataRequestManager: MockDataRequestManager? = MyMockDataRequestManager()
    
    public static var shared: MyDataRequestManager = MyDataRequestManager()
}

// MARK: - Web Service Functions

extension MyDataRequestManager {

    // Articles
    
    // Example including setting a query
    func getArticles(completion: @escaping (DataResponse<[Article]>) -> Void) -> URLSessionTask {
        let resource = GetArticlesResource()
//        resource.setQuery(query: resource.articlesQuery())
        return MyDataRequestManager.shared.loadRequest(with: resource, completion: completion)
    }
    
    // Example including setting a body
//    func addArticle(with body: Article, completion: @escaping (DataResponse<Article>) -> Void) -> URLSessionTask {
//        let resource = AddArticlesResource()
//        resource.setBody(body: JSONCoder.encode(object: body))
//        return MyDataRequestManager.shared.loadRequest(with: resource, completion: completion)
//    }
}
