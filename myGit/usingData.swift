//
//  File.swift
//  myGit
//
//  Created by 박하늘 on 14/01/2019.
//  Copyright © 2019 haneulPark. All rights reserved.
//

import Foundation

enum login : String{
    case authNote = "newTokenForMyGitAppExample"
}

enum gitURL : String{
    case base = "https://api.github.com"
    case test = "https://api.github.com/users/whatever?client_id=2ac74195efa983ff6927&client_secret=c7a393663ba9511c9e46c66bf029071a6652cb97"
    case login = "https://api.github.com/repos/user/repo"
}

enum auth : String{
    case name = "parkhaneul"
    case password = "house2060"
    case client_id = "2ac74195efa983ff6927"
    case client_secret = "7a393663ba9511c9e46c66bf029071a6652cb97"
}

enum token : String{
    case personal_Token = "dd3d6e458a3315dde3c9efc506dfd21a4ca57204"
}
