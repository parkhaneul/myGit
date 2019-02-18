//
//  GithubData.swift
//  myGit
//
//  Created by 박하늘 on 16/01/2019.
//  Copyright © 2019 haneulPark. All rights reserved.
//

import Foundation

struct Owner : Codable{
    let login : String?
    let id : Int?
    let node_id : String?
    let avatar_url : String?
    let followers_url : String?
    let following_url : String?
    let starred_url : String?
    let organizations_url : String?
    let repos_url : String?
    let followers : Int?
    let following : Int?
    let name : String?
    let company : String?
}
