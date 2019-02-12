//
//  HyperLinks.swift
//  myGit
//
//  Created by 박하늘 on 28/01/2019.
//  Copyright © 2019 haneulPark. All rights reserved.
//

import Foundation

struct HyperLinks : CustomInfoType{
    var data : JSON = [
        "self": Hyper([:]),
        "html": Hyper([:]),
        "issue": Hyper([:]),
        "comments": Hyper([:]),
        "review_comments": Hyper([:]),
        "review_comment": Hyper([:]),
        "commits": Hyper([:]),
        "statuses": Hyper([:])
    ]
    
    init(_ json : JSON){
        let json = json
        for (key,value) in json{
            if data.keys.contains(key) && !(value is NSNull){
                data[key] = Hyper(value as! JSON)
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
