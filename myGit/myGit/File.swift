//
//  File.swift
//  myGit
//
//  Created by 박하늘 on 14/01/2019.
//  Copyright © 2019 haneulPark. All rights reserved.
//

import Foundation

enum gitURL : String{
    case base = "https://api.github.com"
    case test = "https://api.github.com/users/whatever?client_id=2ac74195efa983ff6927&client_secret=c7a393663ba9511c9e46c66bf029071a6652cb97"
}

struct auth{
    let id : String = "2ac74195efa983ff6927"
    let secret : String = "7a393663ba9511c9e46c66bf029071a6652cb97"
}
