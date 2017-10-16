//
//  MyApiInformation.swift
//  WebserviceOnSteroids
//
//  Created by Niklas Fahl on 10/13/17.
//  Copyright © 2017 Niklas Fahl. All rights reserved.
//

import Foundation

struct MyApiInformation: ApiInformation {
    #if DEBUG
    var dataSource: DataSource = DataSource(type: .mock, baseAddress: "")
    #else
    var dataSource: DataSource = DataSource(type: .development, baseAddress: "https://swift.mrgott.pro")
    #endif
}
