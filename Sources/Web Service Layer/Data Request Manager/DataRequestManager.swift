//
//  DataRequestManager.swift
//  SimpleWebServiceRequestsDemo
//
//  Created by Niklas Fahl on 10/13/17.
//  Copyright © 2017 Niklas Fahl. All rights reserved.
//

import Foundation

public protocol DataRequestManager {
    associatedtype APIMethodsProtocol
    var apiInformation: ApiInformation { get }
    var securityPolicy: SecurityPolicy? { get }
    var requestManager: APIMethodsProtocol { get }
    
    static var shared: Self { get }
}
