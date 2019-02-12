//
//  Events.swift
//  myGit
//
//  Created by 박하늘 on 22/01/2019.
//  Copyright © 2019 haneulPark. All rights reserved.
//

import Foundation

struct Issues : CustomInfoType{
    var data : JSON = [
        "id": 0,
        "node_id": "",
        "url": "",
        "repository_url": "",
        "labels_url": "",
        "comments_url": "",
        "events_url": "",
        "html_url": "",
        "number": 0,
        "state": "",
        "title": "",
        "body": "",
        "user": Owner([:]), // i use same data type[ Owner ]
        "labels": [Labels](),
        "assignee": Owner([:]), // i use same data type[ Owner ]
        "assignees": [Owner](),
        "milestone": MileStone([:]),
        "locked": false,
        "active_lock_reason": "",
        "comments": 0,
        "pull_request": Pull_Request([:]),
        "closed_at": "",
        "created_at": "",
        "updated_at": "",
        "repository": Repository([:]),
        "author_association" : ""
    ]
    
    init(_ json: JSON) {
        let json = json
        for (key,value) in json{
            if data.keys.contains(key){
                if !(value is NSNull){
                    if(key == "user" || key == "assignee") { data[key] = Owner(value as! JSON) }
                    else if(key == "milestone"){ data[key] = MileStone(value as! JSON) }
                    else if(key == "pull_request"){ data[key] = Pull_Request(value as! JSON) }
                    else if(key == "repository"){ data[key] = Repository(value as! JSON) }
                    else if(key == "labels"){
                        for d in (value as! [JSON]){
                            var m = data[key] as! [Labels]
                            m.append(Labels(d))
                        }
                    }
                    else if(key == "assignees"){
                        for d in (value as! [JSON]){
                            var m = data[key] as! [Owner]
                            m.append(Owner(d))
                        }
                    }
                }
                data[key] = value
            } else{
                print("Issues data [" + key + "] is not mapping")
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
