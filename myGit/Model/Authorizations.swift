//
//  Auth.swift
//  myGit
//
//  Created by 박하늘 on 05/02/2019.
//  Copyright © 2019 haneulPark. All rights reserved.
//

import Foundation

struct Authorizations : Codable,Equatable{
    let id: Int?
    let url: String?
    let token: String?
    let hashed_token: String?
    let note: String?
    let updated_at: String?
    let created_at: String?
    
    static func == (lhs: Authorizations, rhs: Authorizations) -> Bool {
        return lhs.id == rhs.id
    }
}
