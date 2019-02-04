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
    var session : URLSession
    
    public init(){
        session = URLSession(configuration: .default)
    }
    
    public init(session : URLSession){
        self.session = session
    }
    
    public func get(url : String, parameters : [String : String]? = nil, headers : [String : String]? = nil, completion : @escaping completionType){
        let request = Request(url: url, method: .GET, parameters: parameters, headers: headers)
        let buildRequest = request.request()
        guard let urlRequest = buildRequest.request else {
            completion(nil,nil,buildRequest.error)
            return
        }
        let task = session.dataTask(with: urlRequest, completionHandler: completion)
        task.resume()
    }
}
