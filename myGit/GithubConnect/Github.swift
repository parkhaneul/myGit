//
//  Github.swift
//  myGit
//
//  Created by 박하늘 on 15/01/2019.
//  Copyright © 2019 haneulPark. All rights reserved.
//

import Foundation

struct Github{
    var authentication : Authentication?
    var network : NetworkAPI?
    
    var defaultHeaders = [
        "Accept" : "application/vnd.github.v3+json",
        RequestHeaderFields.acceptEncoding.rawValue : "gzip",
        "Content-Type" : "application/json; charset=utf-8"
    ]
    
    public init(authentication : Authentication? = shared_authentication){
        self.authentication = authentication
        network = NetworkAPI()
    }
    
    public func post(path: String, parameters: [String : String]? = nil, headers: [String: String]? = nil, completion: @escaping (Data?, Error?) -> ()){
        post(full_path: gitURL.base.rawValue + path,
             parameters: parameters,
             headers: headers,
             completion: completion)
    }
    
    public func put(path: String, parameters: [String : String]? = nil, headers: [String: String]? = nil, completion: @escaping (Data?, Error?) -> ()){
        put(full_path: gitURL.base.rawValue + path,
            parameters: parameters,
            headers: headers,
            completion: completion)
    }
    
    public func get(path: String, parameters: [String : String]? = nil, headers: [String: String]? = nil, completion: @escaping (Data?, Error?) -> ()){
        get(full_path: gitURL.base.rawValue + path,
            parameters: parameters,
            headers: headers,
            completion: completion)
    }
    
    public func put(full_path: String, parameters: [String : String]? = nil, headers: [String: String]? = nil, completion: @escaping (Data?, Error?) -> ()){
        let (newHeaders, newParameters) = addAuthenticationIfNeeded(headers: headers, parameters: parameters)
        network?.put(url: full_path, parameters: newParameters, headers: newHeaders, completion: {(data,response,error) in
            guard let data = data else {
                completion(nil,error)
                return
            }
            do{
                completion(data,error)
            }
        })
    }
    
    public func post(full_path: String, parameters: [String : String]? = nil, headers: [String: String]? = nil, completion: @escaping (Data?, Error?) -> ()){
        let (newHeaders, newParameters) = addAuthenticationIfNeeded(headers: headers, parameters: parameters)
        network?.post(url: full_path, parameters: newParameters, headers: newHeaders, completion: {(data,_,error) in
            guard let data = data else {
                completion(nil,error)
                return
            }
            do{
                completion(data,error)
            }
        })
    }
    
    public func getNonAuth(full_path: String, parameters: [String : String]? = nil, headers: [String: String]? = nil, completion: @escaping (Data?, Error?) -> ()){
        network?.get(url: full_path, parameters: parameters, headers: headers, completion: {(data,_,error) in
            guard let data = data else {
                completion(nil,error)
                return
            }
            do{
                completion(data,error)
            }
        })
    }
    
    public func get(full_path: String, parameters: [String : String]? = nil, headers: [String: String]? = nil, completion: @escaping (Data?, Error?) -> ()){
        let (newHeaders, newParameters) = addAuthenticationIfNeeded(headers: headers, parameters: parameters)
        network?.get(url: full_path, parameters: newParameters, headers: newHeaders, completion: {(data,_,error) in
            guard let data = data else {
                completion(nil,error)
                return
            }
            do{
                completion(data,error)
            }
        })
    }
    
    func addAuthenticationIfNeeded(headers: [String : String]?, parameters: [String : String]?) -> (headers: [String : String]?, parameters: [String : String]?)
    {
        var newHeaders = headers
        if newHeaders == nil{
            newHeaders = defaultHeaders
        }
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
