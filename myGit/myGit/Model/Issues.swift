//
//  Events.swift
//  myGit
//
//  Created by 박하늘 on 22/01/2019.
//  Copyright © 2019 haneulPark. All rights reserved.
//

import Foundation

struct Issues : Codable{
    let id: Int?
    let number: Int?
    let state: String?
    let title: String?
    let body: String?
    let user: Owner? // i use same data type[ Owner ]
    //let labels: [Labels]
    let comments: Int?
    let closed_at: String?
    let created_at: String?
    let updated_at: String?
    let repository: Repository?
}
