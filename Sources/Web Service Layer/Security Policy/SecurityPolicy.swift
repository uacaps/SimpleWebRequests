//
//  SecurityPolicy.swift
//  SimpleWebServiceRequestsDemo
//
//  Created by Niklas Fahl on 11/14/17.
//  Copyright © 2017 Niklas Fahl. All rights reserved.
//

import Foundation

public protocol SecurityPolicy {
    func addPolicy(for resource: DataResource) -> DataResource
}
