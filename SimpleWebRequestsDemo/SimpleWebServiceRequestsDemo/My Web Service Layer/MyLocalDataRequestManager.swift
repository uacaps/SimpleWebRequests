//
//  MyLocalDataRequest.swift
//  SimpleWebServiceRequestsDemo
//
//  Created by Niklas Fahl on 10/16/17.
//  Copyright © 2017 Niklas Fahl. All rights reserved.
//

import Foundation

public class MyLocalDataRequestManager: APIMethods {
    public func getArticles(completion: @escaping ([Article]?, Error?) -> Void) -> URLSessionTask {
        return URLSessionTask()
    }
}
