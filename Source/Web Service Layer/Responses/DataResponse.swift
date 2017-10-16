//
//  DataResponse.swift
//  WebserviceOnSteroids
//
//  Created by Niklas Fahl on 10/13/17.
//  Copyright © 2017 Niklas Fahl. All rights reserved.
//

import Foundation

public enum DataResponse<Model: Codable> {
    case success(model: Model)
    case httpError(statusCode: Int)
    case error(error: Error)
}
