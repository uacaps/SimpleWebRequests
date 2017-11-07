//
//  MyNetworkDataRequestManager.swift
//  SimpleWebServiceRequestsDemo
//
//  Created by Niklas Fahl on 11/7/17.
//  Copyright © 2017 Niklas Fahl. All rights reserved.
//

import Foundation

class MyNetworkDataRequestManager: NetworkDataRequestManager, APIMethods {
    public func getArticles(completion: @escaping ([Article]?, Error?) -> Void) -> URLSessionTask {
        let resource = DataResource(urlSessionConfiguration: .ephemeral,
                                    httpMethod: .get,
                                    headers: nil,
                                    baseUrl: MyApiInformation().dataSource.baseUrl,
                                    methodPath: "blog.json",
                                    query: nil,
                                    body: nil)
        return self.loadRequest(with: resource, completion: completion)
    }
}
