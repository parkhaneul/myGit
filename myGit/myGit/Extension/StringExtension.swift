//
//  StringExtension.swift
//  myGit
//
//  Created by 박하늘 on 15/01/2019.
//  Copyright © 2019 haneulPark. All rights reserved.
//

import Foundation

extension String
{
    func fromBase64() -> String?{
        guard let data = Data(base64Encoded: self, options: Data.Base64DecodingOptions(rawValue: 0)) else{
            return nil
        }
        
        return String(data: data as Data, encoding: .utf8)
    }
    
    func toBase64() -> String?{
        guard let data = self.data(using: .utf8) else{
            return nil
        }
        
        return data.base64EncodedString(options: .init(rawValue: 0))
    }
}
