//
//  WebConnection.swift
//  myGit
//
//  Created by 박하늘 on 14/01/2019.
//  Copyright © 2019 haneulPark. All rights reserved.
//

import Foundation

class WebConnection : NSObject{
    var data : [String : Any]!
    
    override init(){
        super.init()
    }
    
    func getJSON(url : String){
        urlRequest(url: url, callback: {(json) -> () in
            print(json)
        })
    }
    
    private func urlRequest(url : String, callback : (([String:Any])->())?){
        let session = URLSession.shared
        let request = URLRequest(url : URL(string: url)!)
        var jsonData : [String : Any]!
        
        let task = session.dataTask(with: request, completionHandler: {data, response, error -> Void in
                jsonData = try! JSONSerialization.jsonObject(with: data!, options: []) as? [String : Any]
                callback!(jsonData)
            })
        task.resume()
    }
}
