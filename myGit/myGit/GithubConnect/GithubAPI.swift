//
//  GithubAPI.swift
//  myGit
//
//  Created by 박하늘 on 15/01/2019.
//  Copyright © 2019 haneulPark. All rights reserved.
//

import Foundation

class GithubAPI : Github{
    public func getUser(username : String,completion: @escaping(Data?, Error?) -> Void) {
        let encodedUsername = username.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed)!
        self.get(path: "/users\(encodedUsername)", completion: completion)
    }
    
    public func getUserByToken(completion : @escaping(Data?, Error?) -> Void){
        self.get(path: "/user", completion : completion)
    }
    
    public func getUserReposByToken(completion : @escaping(Data?, Error?) -> Void){
        self.get(path: "/users/parkhaneul/repos", completion : completion)
    }
}
