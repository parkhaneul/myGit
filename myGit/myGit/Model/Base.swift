//
//  Base.swift
//  myGit
//
//  Created by 박하늘 on 25/01/2019.
//  Copyright © 2019 haneulPark. All rights reserved.
//

import Foundation

struct Base : Codable{
    let label : String?
    let ref : String?
    let sha : String?
    let user : Owner?
    let repo : Repository?
}
