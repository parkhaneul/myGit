//
//  Comment.swift
//  myGit
//
//  Created by 박하늘 on 28/01/2019.
//  Copyright © 2019 haneulPark. All rights reserved.
//

import Foundation

struct Comment : Codable{
    let id: Int?
    let user: Owner?
    let created_at: String?
    let updated_at: String?
    let body: String?
}
