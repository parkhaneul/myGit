//
//  ReadMe.swift
//  myGit
//
//  Created by 박하늘 on 23/01/2019.
//  Copyright © 2019 haneulPark. All rights reserved.
//

import Foundation

struct Contents : Codable, Equatable{
    let type: String?
    let encoding: String?
    let size: Int?
    let name: String?
    let path: String?
    let content: String?
    
    static func == (lhs: Contents, rhs: Contents) -> Bool {
        return lhs.path == rhs.path
    }
}
