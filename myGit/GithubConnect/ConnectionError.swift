//
//  ConnectionError.swift
//  myGit
//
//  Created by parkhaneul on 18/02/2019.
//  Copyright © 2019 haneulPark. All rights reserved.
//

import Foundation

enum ConnectionError : Error{
    case dataIsNil
    case outOfResponseStatusCode
    case responseIsNil
}
