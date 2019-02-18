//
//  toModel.swift
//  myGit
//
//  Created by 박하늘 on 13/02/2019.
//  Copyright © 2019 haneulPark. All rights reserved.
//

import Foundation

func toModel<E:Codable>(_ json : Data) -> E?{
    return try? JSONDecoder().decode(E.self, from: json)
}
