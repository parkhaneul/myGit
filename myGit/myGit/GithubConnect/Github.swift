//
//  Github.swift
//  myGit
//
//  Created by 박하늘 on 15/01/2019.
//  Copyright © 2019 haneulPark. All rights reserved.
//

import Foundation

class Github{
    var authentication : Authentication?
    var network : NetworkAPI?
    
    var defaultHeaders = [
        "Accept" : "application/vnd.github.v3+json",
        RequestHeaderFields.acceptEncoding.rawValue : "gzip",
        "Content-Type" : "application/json; charset=utf-8"
    ]
    
    public init(authentication : Authentication? = nil){
        self.authentication = authentication
        network = NetworkAPI()
    }
    
    public func get(path: String, parameters: [String : String]? = nil, headers: [String: String]? = nil, completion: @escaping (Data?, Error?) -> ()){
        let (newHeaders, newParameters) = addAuthenticationIfNeeded(headers: headers, parameters: parameters)
        network?.get(url: gitURL.base.rawValue + path, parameters: newParameters, headers: newHeaders, completion: {(data,_,error) in
            guard let data = data else {
                completion(nil,error)
                return
            }
            do{
                completion(data,error)
            } catch{
                completion(nil,error)
            }
        })
    }
    
    func addAuthenticationIfNeeded(headers: [String : String]?, parameters: [String : String]?) -> (headers: [String : String]?, parameters: [String : String]?)
    {
        var newHeaders = headers
        var newParameters = parameters
        if let authentication = self.authentication {
            if authentication.type == .headers {
                if var newHeaders = newHeaders {
                    newHeaders[authentication.key] = authentication.value
                    return (newHeaders, newParameters)
                } else {
                    newHeaders = [String : String]()
                    newHeaders![authentication.key] = authentication.value
                    return (newHeaders, newParameters)
                }
            } else if authentication.type == .parameters {
                if var newParameters = newParameters {
                    newParameters[authentication.key] = authentication.value
                    return (newHeaders, newParameters)
                } else {
                    newParameters = [String : String]()
                    newParameters![authentication.key] = authentication.value
                    return (newHeaders, newParameters)
                }
            }
        }
        return (headers, parameters)
    }
}
