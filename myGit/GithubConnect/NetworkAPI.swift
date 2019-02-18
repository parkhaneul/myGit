//
//  GithubAPI.swift
//  myGit
//
//  Created by 박하늘 on 15/01/2019.
//  Copyright © 2019 haneulPark. All rights reserved.
//

import Foundation

public typealias completionType = (Data?,URLResponse?,Error?) -> Swift.Void

struct NetworkAPI{
    static let shared = URLSession(configuration : .default)
    
    public func put(url : String, parameters : [String : String]? = nil, headers : [String : String]? = nil, completion : @escaping completionType){
        let request = Request(url: url, method: .PUT, parameters: parameters, headers: headers)
        action(request, completion: completion)
    }
    
    public func get(url : String, parameters : [String : String]? = nil, headers : [String : String]? = nil, completion : @escaping completionType){
        let request = Request(url: url, method: .GET, parameters: parameters, headers: headers)
        action(request, completion: completion)
    }
    
    public func post(url : String, parameters : [String : String]? = nil, headers : [String : String]? = nil, completion : @escaping completionType){
        let request = Request(url: url, method: .POST, parameters: parameters, headers: headers)
        action(request, completion: completion)
    }
    
    public func action(_ request : Request, completion : @escaping completionType){
        let buildRequest = request.request()
        guard let urlRequest = buildRequest.request else {
            completion(nil,nil,buildRequest.error)
            return
        }
        let task = NetworkAPI.shared.dataTask(with: urlRequest, completionHandler: completion)
        task.resume()
    }
}
