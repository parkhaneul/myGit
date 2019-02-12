//
//  WebConnection.swift
//  myGit
//
//  Created by 박하늘 on 14/01/2019.
//  Copyright © 2019 haneulPark. All rights reserved.
//

import Foundation

class WebConnection : NSObject{
    let parser = JsonParser()
    let session = URLSession.shared
    
    override init(){
        super.init()
    }
    
    func getJSON(url : String){
        urlRequest(url: url, callback: {(json) -> () in
            self.parser.jsonDescription(json: json)
        })
    }
    
    func getResponse(url : String){
        urlResponse(url: url, callback: {(response) -> () in
            print(response)
        })
    }
    
    private func urlRequest(url : String, callback : (([String:Any])->())?){
        let request = URLRequest(url : URL(string: url)!)
        var jsonData : [String : Any]!
        
        let task = session.dataTask(with: request, completionHandler: {data, response, error -> Void in
                jsonData = try! JSONSerialization.jsonObject(with: data!, options: []) as? [String : Any]
                callback!(jsonData)
            })
        task.resume()
    }
    
    private func urlResponse(url : String, callback : ((URLResponse)->())?){
        let request = URLRequest(url : URL(string: url)!)
        let task = session.dataTask(with: request, completionHandler: {data, response, error -> Void in
            callback!(response!)
        })
        task.resume()
    }
    
    public func get(url : String, parameters : [String:String]? = nil, header : [String : String]? = nil) -> (request : URLRequest?, error : Error?){
        if let useURL : String = urlAddParameters(url: url, parameters: parameters){
            var request = URLRequest(url: URL(string: useURL)!)
            
            if let headers : [String : String] = header{
                for key in headers.keys{
                    request.addValue(headers[key]!, forHTTPHeaderField: key)
                }
            }
            
            request.httpMethod = RequestMethod.GET.rawValue
            return (request, nil)
        } else{
            return (nil, "Unable to create URL" as! Error)
        }
        
        
    }


    public func get(url: String, parameters: [String : String]? = nil, headers: [String: String]? = nil, completion: @escaping BaseAPICompletion) {
        let request = Request(url: url, method: .GET, parameters: parameters, headers: headers, body: nil)
        let buildRequest = request.request()
        if let urlRequest = buildRequest.request {
            let task = session.dataTask(with: urlRequest, completionHandler: completion)
            task.resume()
        } else {
            completion(nil, nil, buildRequest.error)
        }
    }
    
    public func get(url: String, parameters: [String : String]? = nil, headers: [String: String]? = nil) -> BaseAPIResult {
        let request = Request(url: url, method: .GET, parameters: parameters, headers: headers, body: nil)
        let buildRequest = request.request()
        if let urlRequest = buildRequest.request {
            return session.synchronousDataTask(request: urlRequest)
        } else {
            return (nil, nil, buildRequest.error)
        }
    }
    
    func urlAddParameters(url : String, parameters : [String : String]? = nil) -> String{
        var returnURL = url
        guard let param = parameters else{ return returnURL }
        
        returnURL.append("?")
        param.keys.forEach {
            guard let value = param[$0] else { return returnURL }
            if let escapedValue = value.addingPercentEncoding(withAllowedCharacters: .BaseAPI_URLQueryAllowedCharacterSet()){
                returnURL.append("\($0)=\(escapedValue)&")
            }
        }
        returnURL.removeLast()
        return returnURL
    }
}
