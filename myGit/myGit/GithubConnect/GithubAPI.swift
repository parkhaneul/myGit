//
//  GithubAPI.swift
//  myGit
//
//  Created by 박하늘 on 15/01/2019.
//  Copyright © 2019 haneulPark. All rights reserved.
//

import Foundation

class GithubAPI : Github{
    let userName = "parkhaneul"//"mojombo"
    
    public func getUser(username : String,completion: @escaping(Data?, Error?) -> Void) {
        let encodedUsername = username.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed)!
        self.get(path: "/users\(encodedUsername)", completion: completion)
    }
    
    public func getUserByToken(completion : @escaping(Data?, Error?) -> Void){
        self.get(path: "/user", completion : completion)
    }
    
    public func getUserReposByToken(completion : @escaping(Data?, Error?) -> Void){
        self.get(path: "/users/\(userName)/repos", completion : completion)
    }
    
    public func getUserIssuesByToken(completion : @escaping(Data?, Error?) -> Void){
        self.get(path: "/user/issues", completion: completion)
    }
    
    public func getUserIssuesByRepos(repos : String, completion : @escaping(Data?, Error?) -> Void){
        self.get(path: "/repos/\(userName)/\(repos)/issues", completion: completion)
    }
    
    public func getDataFromString(URLString : String, completion : @escaping(Data?, Error?) -> Void){
        self.get(full_path: URLString, completion: completion)
    }
    
    public func getUserReadMeByRepos(repos: String, completion : @escaping(Data?, Error?) -> Void){
        self.get(path: "/repos/\(userName)/\(repos)/readme", completion: completion)
    }
}
