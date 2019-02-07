//
//  UserPlan.swift
//  myGit
//
//  Created by 박하늘 on 15/01/2019.
//  Copyright © 2019 haneulPark. All rights reserved.
//

import Foundation

public struct UserPlan : Codable {
    public let collaborators : Int?
    public let name : String?
    public let privateRepos : Int?
    public let space : Int?
    
    enum CodingKeys: String, CodingKey {
        case collaborators
        case name
        case privateRepos = "private_repos"
        case space
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        collaborators = try values.decodeIfPresent(Int.self, forKey: .collaborators)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        privateRepos = try values.decodeIfPresent(Int.self, forKey: .privateRepos)
        space = try values.decodeIfPresent(Int.self, forKey: .space)
    }
}
