//
//  ReadMe.swift
//  myGit
//
//  Created by 박하늘 on 23/01/2019.
//  Copyright © 2019 haneulPark. All rights reserved.
//

import Foundation

struct Contents : CustomInfoType{
    
    var data : JSON = [
        "type": "",
        "encoding": "",
        "size": 0,
        "name": "",
        "path": "",
        "content": "",
        "sha": "",
        "url": "",
        "git_url": "",
        "html_url": "",
        "download_url": "",
        "_links": Links([:])
    ]
    
    init(_ json: JSON) {
        let json = json
        for (key,value) in json{
            if data.keys.contains(key){
                if(key == "_links" && !(value is NSNull)){
                    data[key] = Links(value as! JSON)
                } else{
                    data[key] = value
                }
            } else{
                print("Contents data [" + key + "] is not mapping")
            }
        }
    }
    
    func get(_ key : String) -> Any?{
        if data.keys.contains(key) && !(data[key] is NSNull){
            return data[key]
        }
        
        return nil
    }
}
