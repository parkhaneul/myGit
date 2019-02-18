//
//  StringExtension.swift
//  myGit
//
//  Created by 박하늘 on 15/01/2019.
//  Copyright © 2019 haneulPark. All rights reserved.
//

import Foundation

//base64 decode
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
    
    func decodeBase64() -> String?{
        if self != ""{
            let str = self.filter({ !" \n\t\r".contains($0) })
            guard let data = Data(base64Encoded: str) else{
                return "couldn't read"
            }
            return String(data: data, encoding : .utf8)
        }
        return nil
    }
}

// spilt
extension String{
    func splitToOffset(offsetBy : Int) -> String{
        return String(self[..<self.index(self.startIndex, offsetBy: offsetBy)])
    }
    
    func splitEndOffset(offsetBy : Int) -> String{
        return String(self[..<self.index(self.endIndex, offsetBy: -offsetBy)])
    }
    
    func splitToEndOffset(offsetBy : Int) -> String{
        return String(self[self.index(self.endIndex, offsetBy: -offsetBy)...])
    }
}

// date relationship
extension String{
    func dateCalcul() -> String{
        let str = self
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        var date = dateFormatter.date(from: str.splitToOffset(offsetBy: 10))
        let now = Date()
        
        if date!.compareNow(.year) < 1 {
            if date!.compareNow(.month) < 1{
                if date!.compareNow(.day) < 1 {
                    dateFormatter.dateFormat = "hh:mm:ss"
                    let hourStr = str.splitToEndOffset(offsetBy: 9).splitToOffset(offsetBy: 8)
                    date = dateFormatter.date(from: hourStr)
                    if date!.compareNow(.hour) < 1{
                        return "\(-date!.compare(now).rawValue) minutes ago"
                    }
                    return "\(-date!.compare(now).rawValue) hours ago"
                }
                return "\(-date!.compare(now).rawValue) days ago"
            }
            return "\(-date!.compare(now).rawValue) months ago"
        }
        return self.splitToOffset(offsetBy: 10)
    }
}
