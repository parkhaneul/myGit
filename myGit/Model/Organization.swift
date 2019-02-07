//
//  Organization.swift
//  myGit
//
//  Created by 박하늘 on 07/02/2019.
//  Copyright © 2019 haneulPark. All rights reserved.
//

import Foundation

struct Organization : CustomInfoType{
    var data : JSON = [
        "login": "",
        "id": 0,
        "node_id": "",
        "url": "",
        "repos_url": "",
        "events_url": "",
        "hooks_url": "",
        "issues_url": "",
        "members_url": "",
        "public_members_url": "",
        "avatar_url": "",
        "description": "",
        "name": "",
        "company": "",
        "blog": "",
        "location": "",
        "email": "",
        "is_verified": false,
        "has_organization_projects": false,
        "has_repository_projects": false,
        "public_repos": 0,
        "public_gists": 0,
        "followers": 0,
        "following": 0,
        "html_url": "",
        "created_at": "",
        "type": "",
        "total_private_repos": 0,
        "owned_private_repos": 0,
        "private_gists": 0,
        "disk_usage": 0,
        "collaborators": 0,
        "billing_email": "",
        "plan": Plan([:]),
        "default_repository_settings": "",
        "members_can_create_repositories": false,
        "two_factor_requirement_enabled": false,
        "members_allowed_repository_creation_type": ""
    ]
    
    init(_ json : JSON){
        let json = json
        for (key,value) in json{
            if data.keys.contains(key) && !(value is NSNull){
                if(key == "plan"){
                    data[key] = Plan(value as! JSON)
                }
                data[key] = value
            } else{
                print("Organization data [" + key + "] is not mapping")
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

struct Plan : CustomInfoType{
    var data : JSON = [
        "name": "",
        "space": 0,
        "private_repos": 0
    ]
    
    init(_ json : JSON){
        let json = json
        for (key,value) in json{
            if data.keys.contains(key) && !(value is NSNull){
                data[key] = value
            } else{
                print("Plan data [" + key + "] is not mapping")
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
