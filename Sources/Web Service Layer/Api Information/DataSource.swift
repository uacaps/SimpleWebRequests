//
//  DataSource.swift
//  SimpleWebServiceRequestsDemo
//
//  Created by Niklas Fahl on 10/13/17.
//  Copyright © 2017 Niklas Fahl. All rights reserved.
//

import Foundation

public enum DataSourceType {
    case release
    case development
    case local
    case mock
}

public struct DataSource {
    public var type: DataSourceType
    public var baseUrl: String
    
    public init(type: DataSourceType, baseUrl: String) {
        self.type = type
        self.baseUrl = baseUrl
    }
}
