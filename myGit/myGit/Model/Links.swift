//
//  Links.swift
//  myGit
//
//  Created by 박하늘 on 28/01/2019.
//  Copyright © 2019 haneulPark. All rights reserved.
//

import Foundation

struct Links : CustomInfoType{
    var data : JSON = [
        "git": "",
        "self": "",
        "html": ""
    ]
    
    init(_ json: JSON) {
        let json = json
        for (key,value) in json{
            if data.keys.contains(key){
                data[key] = value
            } else{
                print("link data [" + key + "] is not mapping")
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
