//
//  AppType.swift
//  myGit
//
//  Created by 박하늘 on 05/02/2019.
//  Copyright © 2019 haneulPark. All rights reserved.
//

import Foundation

struct AppType : CustomInfoType{
    var data : JSON = [
        "url": "",
        "name": "",
        "client_id": ""
    ]
    
    init(_ json: JSON) {
        let json = json
        for (key,value) in json{
            if data.keys.contains(key){
                data[key] = value
            } else{
                print("AppType data [" + key + "] is not mapping")
            }
        }
    }
    
    func get(_ key: String) -> Any? {
        if data.keys.contains(key) && !(data[key] is NSNull){
            return data[key]
        }
        
        return nil
    }
}
