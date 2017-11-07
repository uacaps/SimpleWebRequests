//
//  MyMockDataRequest.swift
//  SimpleWebServiceRequestsDemo
//
//  Created by Niklas Fahl on 10/13/17.
//  Copyright © 2017 Niklas Fahl. All rights reserved.
//

import Foundation

public class MyMockDataRequestManager: APIMethods {
    // All your custom variables to allow mocking your server
    var articles: [Article] = [Article(title: "Mock 1", description: "Mocking an article."), Article(title: "Mock 2", description: "Mocking an article again.")]
    
    public func getArticles(completion: @escaping ([Article]?, Error?) -> Void) -> URLSessionTask {
        return URLSessionTask()
    }
}
