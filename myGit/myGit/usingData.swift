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
    case login = "https://api.github.com/repos/user/repo"
}

struct auth{
    let name : String = "parkhaneul"
    let password :String = "house2060"
    let client_id : String = "2ac74195efa983ff6927"
    let client_secret : String = "7a393663ba9511c9e46c66bf029071a6652cb97"
    let access_token : String = "0cda97080aa53f1cce8eb02369945e0f53631161"
}

struct info{
    let id : String = ""
    let pwd : String = ""
}
