//
//  UsersRepos.swift
//  myGit
//
//  Created by 박하늘 on 18/01/2019.
//  Copyright © 2019 haneulPark. All rights reserved.
//

import Foundation

struct Repository : CustomInfoType, Equatable{
    var data : JSON = [
        "id" : 0,
        "node_id" : "",
        "name" : "",
        "full_name" : "",
        "setPrivate" : false,
        "private" : false,
        "permissions" : "",
        "decription" : "",
        "fork" : false,
        "url" : "",
        "forks_url" : "",
        "keys_url" : "",
        "collaborators_url" : "",
        "teams_url" : "",
        "hooks_url" : "",
        "events_url" : "",
        "issue_events_url" : "",
        "assignees_url" : "",
        "branches_url" : "",
        "tags_url" : "",
        "blobs_url" : "",
        "git_tags_url" : "",
        "git_refs_url" : "",
        "trees_url" : "",
        "statuses_url" : "",
        "alnguages_url" : "",
        "stargazers_url" : "",
        "contributors_url" : "",
        "subscribers_url" : "",
        "subcription_url" : "",
        "commits_url" : "",
        "git_commits_url" : "",
        "comments_url" : "",
        "merges_url" : "",
        "description" : "",
        "subscription_url" : "",
        "issue_comment_url" : "",
        "contents_url" : "",
        "compare_url" : "",
        "archive_url" : "",
        "downloads_url" : "",
        "issues_url" : "",
        "pulls_url" : "",
        "milestones_url" : "",
        "notifications_url" : "",
        "labels_url" : "",
        "releases_url" : "",
        "deployments_url" : "",
        "created_at" : "",
        "updated_at" : "",
        "pushed_at" : "",
        "git_url" : "",
        "ssh_url" : "",
        "clone_url" : "",
        "svn_url" : "",
        "homepage" : "",
        "languages_url" : "",
        "html_url" : "",
        "size" : 0,
        "stargazers_count" : 0,
        "watchers_count" : 0,
        "language" : "",
        "owner" : Owner([:]),
        "has_issues" : false,
        "has_projects" : false,
        "has_downloads" : false,
        "has_wiki" : false,
        "has_pages" : false,
        "forks_count" : 0,
        "mirror_url" : "",
        "archived" : false,
        "open_issues_count" : 0,
        "license" : "",
        "forks" : 0,
        "open_issues" : 0,
        "watchers" : 0,
        "default_branch" : "",
        "state" : "Owner" // custom option
    ]
    
    init(_ json: JSON) {
        let json = json
        for (key,value) in json{
            if data.keys.contains(key){
                if(key == "owner" && !(value is NSNull)){
                    data[key] = Owner(value as! JSON)
                }
                data[key] = value
            } else{
                print("Repository data [" + key + "] is not mapping")
            }
        }
    }
    
    static func == (lhs: Repository, rhs: Repository) -> Bool {
        return (lhs.data["full_name"] as! String) == (rhs.data["full_name"] as! String)
    }
    
    func get(_ key : String) -> Any?{
        if data.keys.contains(key) && !(data[key] is NSNull){
            return data[key]
        }
        
        return nil
    }
}
