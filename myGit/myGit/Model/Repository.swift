//
//  UsersRepos.swift
//  myGit
//
//  Created by 박하늘 on 18/01/2019.
//  Copyright © 2019 haneulPark. All rights reserved.
//

import Foundation

struct Repository : Codable, Equatable, Hashable{
    let id : Int?
    let name : String?
    let full_name : String?
    let decription : String?
    let owner : Owner?
    let state : String?
    let updated_at : String?
    let created_at : String?
    let language : String?
    let watchers : Int?
    let stargazers_count : Int?
    let forks : Int?
    let url : String?
    let size : Int?
    
    static func == (lhs: Repository, rhs: Repository) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(id)
    }
}
