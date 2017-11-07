//
//  MyApiInformation.swift
//  SimpleWebServiceRequestsDemo
//
//  Created by Niklas Fahl on 10/13/17.
//  Copyright © 2017 Niklas Fahl. All rights reserved.
//

import Foundation

struct MyApiInformation: ApiInformation {
    #if DEBUG
    var dataSource: DataSource = DataSource(type: .mock, baseUrl: "")
    #else
    var dataSource: DataSource = DataSource(type: .development, baseUrl: "https://swift.mrgott.pro")
    #endif
}

public protocol APIMethods {
    func getArticles(completion: @escaping ([Article]?, Error?) -> Void) -> URLSessionTask
}
