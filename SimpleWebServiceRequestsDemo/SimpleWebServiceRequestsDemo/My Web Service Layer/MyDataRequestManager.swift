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
    public var onlineDataRequest: NetworkDataRequest = NetworkDataRequest()
    public var localDataRequest: LocalDataRequest? = MyLocalDataRequest()
    public var mockDataRequest: MockDataRequest? = MyMockDataRequest()
    
    public static var shared: MyDataRequestManager = MyDataRequestManager()
}
