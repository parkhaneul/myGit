//
//  Authentication.swift
//  myGit
//
//  Created by 박하늘 on 15/01/2019.
//  Copyright © 2019 haneulPark. All rights reserved.
//

import Foundation

public enum AuthenticationType{
    case none
    case headers
    case parameters
}

protocol Authentication{
    var type : AuthenticationType { get }
    var key : String { get }
    var value : String { get }
    
    func header() -> [String : String]
}
