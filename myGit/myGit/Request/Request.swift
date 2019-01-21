//
//  Request.swift
//  myGit
//
//  Created by 박하늘 on 15/01/2019.
//  Copyright © 2019 haneulPark. All rights reserved.
//

import Foundation

class Request{
    private var url : String
    private var method : RequestMethod
    private var parameters : [String : String]? = nil
    private var headers : [String : String]? = nil
    private var body : Data? = nil
    
    public init(url : String, method : RequestMethod){
        self.url = url
        self.method = method
    }
    
    public func parameters(parameters : [String : String]?) -> Request{
        self.parameters = parameters
        return self
    }
    
    public func headers(headers : [String : String]?) -> Request{
        self.headers = headers
        return self
    }
    
    public func body(body : Data?) -> Request{
        self.body = body
        return self
    }
    
    public func request() -> (request : URLRequest?, error : Error?){
        if let url = URL(string: urlWithParameters()){
            var request = URLRequest(url: url)
            if let headers = headers{
                for key in headers.keys{
                    request.addValue(headers[key]!, forHTTPHeaderField: key)
                }
            }
            request.httpMethod = method.rawValue
            request.httpBody = body
            return (request, nil)
        }
        return(nil, "Unable to create URL" as? Error)
    }
    
    func urlWithParameters() -> String {
        var returnUrl = url
        guard let parameters = parameters else { return returnUrl }
        returnUrl.append("?")
        parameters.keys.forEach{
            guard let value = parameters[$0] else { return }
            if let escapedValue = value.addingPercentEncoding(withAllowedCharacters: .URLQueryAllowedCharacterSet()){
                returnUrl.append("\($0)=\(escapedValue)&")
            }
        }
        returnUrl.removeLast()
        return returnUrl
    }
}
