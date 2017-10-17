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
