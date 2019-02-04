//
//  DateExtension.swift
//  myGit
//
//  Created by 박하늘 on 04/02/2019.
//  Copyright © 2019 haneulPark. All rights reserved.
//

import Foundation

extension Date{
    func compareNow(_ type : Calendar.Component) -> Int{
        let cal = Calendar.current
        return cal.component(type, from: Date()) - cal.component(type, from: self)
    }
}
