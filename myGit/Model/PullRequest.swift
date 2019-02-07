//
//  PullRequest.swift
//  myGit
//
//  Created by 박하늘 on 25/01/2019.
//  Copyright © 2019 haneulPark. All rights reserved.
//

import Foundation

struct PullRequest : CustomInfoType {
    var data : JSON = [
        "url": "",
        "id": 0,
        "node_id": "",
        "html_url": "",
        "diff_url": "",
        "patch_url": "",
        "issue_url": "",
        "commits_url": "",
        "review_comments_url": "",
        "review_comment_url": "",
        "comments_url": "",
        "statuses_url": "",
        "number": 0,
        "state": "",
        "locked": true,
        "title": "",
        "user": Owner([:]),
        "body": "",
        "labels": [Labels([:])],
        "milestone": MileStone([:]),
        "active_lock_reason": "",
        "created_at": "",
        "updated_at": "",
        "closed_at": "",
        "merged_at": "",
        "merge_commit_sha": "",
        "assignee": Owner([:]),
        "assignees": [Owner([:])],
        "requested_reviewers": [Owner([:])],
        "requested_teams": [Team([:])],
        "head": Base([:]),
        "base": Base([:]),
        "_links": HyperLinks([:]),
        "author_association": ""
    ]
    
    init(_ json : JSON){
        let json = json
        for (key,value) in json{
            if data.keys.contains(key){
                if !(value is NSNull){
                    if(key == "user" || key == "assignee"){ data[key] = Owner(value as! JSON) }
                    else if(key == "labels"){
                        var arr = data[key] as! [Labels]
                        for v in (value as! JSON){
                            arr.append(Labels(v as! JSON))
                        }
                    } else if(key == "milestone"){ data[key] = MileStone(value as! JSON) }
                    else if(key == "assignees" || key == "requested_reviewers"){
                        var arr = data[key] as! [Owner]
                        for v in (value as! JSON){
                            arr.append(Owner(v as! JSON))
                        }
                    } else if(key == "requested_teams"){
                        var arr = data[key] as! [Owner]
                        for v in (value as! JSON){
                            arr.append(Owner(v as! JSON))
                        }
                    } else if(key == "head" || key == "base"){ data[key] = Base(value as! JSON) }
                    else if(key == "_links"){ data[key] = HyperLinks(value as! JSON) }
                } else{
                    data[key] = value
                }
            }else{
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
