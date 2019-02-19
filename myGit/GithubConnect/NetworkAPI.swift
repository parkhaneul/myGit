//
//  GithubAPI.swift
//  myGit
//
//  Created by 박하늘 on 15/01/2019.
//  Copyright © 2019 haneulPark. All rights reserved.
//

import Alamofire
import Foundation

public typealias completionType = (Data?,URLResponse?,Error?) -> Swift.Void

struct NetworkAPI{
    //static let shared = URLSession(configuration : .default)
    public func get(url : String, parameters : [String : String]? = nil, headers : [String : String]? = nil, completion : @escaping (DataResponse<Any>) -> ()){
        guard let headers = headers else{
            return
        }
        let httpHeaders = HTTPHeaders(headers)
        AF.request(url, parameters: parameters, headers: httpHeaders)
            .validate(statusCode: 200..<300)
            .responseJSON{ response in
                completion(response)
        }
    }
    
    public func post(url : String, parameters : [String : String]? = nil, headers : [String : String]? = nil, completion : @escaping (DataResponse<Any>) -> ()){
        guard let headers = headers else{
            return
        }
        let httpHeaders = HTTPHeaders(headers)
        AF.request(url, method : .post, parameters: parameters, headers: httpHeaders)
            .validate(statusCode: 200..<300)
            .responseJSON{ response in
                completion(response)
        }
    }
}


    /*
    public func get(url : String, parameters : [String : String]? = nil, headers : [String : String]? = nil, completion : @escaping completionType){
        let request = Request(url: url, method: .GET, parameters: parameters, headers: headers)
        action(request, completion: completion)
    }*/

    /*
    public func post(url : String, parameters : [String : String]? = nil, headers : [String : String]? = nil, completion : @escaping completionType){
        let request = Request(url: url, method: .POST, parameters: parameters, headers: headers)
        action(request, completion: completion)
    }*/

    /*
    public func action(_ request : Request, completion : @escaping completionType){
        let buildRequest = request.request()
        guard let urlRequest = buildRequest.request else {
            completion(nil,nil,buildRequest.error)
            return
        }
        let task = NetworkAPI.shared.dataTask(with:urlRequest){(data,response,error) in
            if let error = error{
                completion(nil,nil,error)
            }
            
            guard let response = response as? HTTPURLResponse else{
                completion(nil,nil,ConnectionError.responseIsNil)
                return
            }
            
            guard (200..<300).contains(response.statusCode) else{
                completion(nil,nil,ConnectionError.outOfResponseStatusCode)
                return
            }
            
            guard let data = data else{
                completion(nil,nil,ConnectionError.dataIsNil)
                return
            }
            completion(data,response,error)
        }
        task.resume()
    }*/
