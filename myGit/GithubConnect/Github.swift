//
//  Github.swift
//  myGit
//
//  Created by 박하늘 on 15/01/2019.
//  Copyright © 2019 haneulPark. All rights reserved.
//

import Foundation
import RxSwift

struct Github{
    let authentication : Authentication?
    let network : NetworkAPI = NetworkAPI.shared
    let disposebag = DisposeBag()
    
    var defaultHeaders = [
        "Accept" : "application/vnd.github.v3+json",
        RequestHeaderFields.acceptEncoding.rawValue : "gzip",
        "Content-Type" : "application/json; charset=utf-8"
    ]
    
    private init(authentication : Authentication?){
        self.authentication = authentication
    }
    
    public static func api(authentication : Authentication? = shared_authentication) -> Github{
        return Github(authentication: authentication)
    }
    
    public func post(path: String, parameters: [String : String]? = nil, headers: [String: String]? = nil) -> Observable<Data>{
        return post(full_path: gitURL.base.rawValue + path, parameters: parameters, headers: headers)
    }
    
    public func get(path: String, parameters: [String : String]? = nil, headers: [String: String]? = nil) -> Observable<Data>{
        return get(full_path: gitURL.base.rawValue + path, parameters: parameters, headers: headers)
    }
    
    public func post(full_path: String, parameters: [String : String]? = nil, headers: [String: String]? = nil) -> Observable<Data>{
        let (newHeaders, newParameters) = addAuthenticationIfNeeded(headers: headers, parameters: parameters)
        return self.network.post(url: full_path, parameters: newParameters, headers: newHeaders).map {
            return $0.data ?? Data()
        }
    }
    
    public func getNonAuth(full_path: String, parameters: [String : String]? = nil, headers: [String: String]? = nil) -> Observable<Data>{
        return self.network.get(url: full_path, parameters: parameters, headers: headers).map {
            return $0.data ?? Data()
        }
    }
    
    public func get(full_path: String, parameters: [String : String]? = nil, headers: [String: String]? = nil) -> Observable<Data>{
        let (newHeaders, newParameters) = addAuthenticationIfNeeded(headers: headers, parameters: parameters)
        return self.network.get(url: full_path, parameters: newParameters, headers: newHeaders).map {
            return $0.data ?? Data()
        }
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
