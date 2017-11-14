//
//  JWTBearerPolicy.swift
//  SimpleWebServiceRequestsDemo
//
//  Created by Niklas Fahl on 11/14/17.
//  Copyright © 2017 Niklas Fahl. All rights reserved.
//

import Foundation

public class JWTBearerPolicy: SecurityPolicy {
    var tokenEndpoint: String = ""
    var clientId: String = ""
    var clientSecret: String = ""
    var scopes: [String]?
    
    var authenticationToken: String?
    var authorizationToken: String?
    
    public init(with tokenEndpoint: String, clientId: String, clientSecret: String, scopes: [String]? = nil) {
        self.tokenEndpoint = tokenEndpoint
        self.clientId = clientId
        self.clientSecret = clientSecret
        self.scopes = scopes
    }
    
    public func addPolicy(for resource: DataResource) -> DataResource {
        if let authenticationToken = authenticationToken {
            //Authentication Token Present
            var secureResource = resource
            secureResource.headers = ["Authorization": "Bearer \(authenticationToken)"]
            return secureResource
        }
        else if let authorizationToken = authorizationToken {
            // Authorization Token Present
            var secureResource = resource
            secureResource.headers = ["Authorization": "Bearer \(authorizationToken)"]
            return secureResource
        } else {
            // Get token for next call
            getToken()
        }
        return resource
    }
    
    public func getToken() {
        let resource = DataResource(urlSessionConfiguration: .ephemeral,
                                    httpMethod: .post,
                                    headers: nil,
                                    baseUrl: tokenEndpoint,
                                    methodPath: "",
                                    query: "?clientId=\(clientId)&clientSecret=\(clientSecret)",
                                    body: nil)
        let _ = NetworkDataRequestManager().loadNetworkRequest(with: resource) { [weak self] (data, error) in
            if let data = data {
                let token = String(data: data, encoding: .utf8)
                print("Token: \(token ?? "")")
                self?.authorizationToken = token
            }
        }
    }
}
