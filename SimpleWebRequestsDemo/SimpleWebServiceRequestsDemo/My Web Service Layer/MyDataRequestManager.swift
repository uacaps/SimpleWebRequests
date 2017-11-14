//
//  MyDataRequestManager.swift
//  SimpleWebServiceRequestsDemo
//
//  Created by Niklas Fahl on 10/13/17.
//  Copyright © 2017 Niklas Fahl. All rights reserved.
//

import Foundation

public struct MyDataRequestManager: DataRequestManager {
    public typealias APIMethodsProtocol = APIMethods
    
    public typealias Resource = DataResource
    public var apiInformation: ApiInformation = MyApiInformation()
    public var securityPolicy: SecurityPolicy? = JWTBearerPolicy(with: "", clientId: "", clientSecret: "")
    public var requestManager: APIMethodsProtocol {
        switch apiInformation.dataSource.type {
        case .release, .development:
            if let securityPolicy = securityPolicy {
                return MyNetworkDataRequestManager(securityPolicy: securityPolicy)
            }
            return MyNetworkDataRequestManager()
        case .local:
            return MyLocalDataRequestManager()
        case .mock:
            return MyMockDataRequestManager()
        }
    }
    
    public static var shared: MyDataRequestManager = MyDataRequestManager()
}

// MARK: - Web Service Functions

extension MyDataRequestManager: APIMethods {

    // Articles
    
    // Example including setting a query
    public func getArticles(completion: @escaping ([Article]?, Error?) -> Void) -> URLSessionTask {
        return requestManager.getArticles(completion: completion)
    }
}
