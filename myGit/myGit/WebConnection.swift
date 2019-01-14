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
}
