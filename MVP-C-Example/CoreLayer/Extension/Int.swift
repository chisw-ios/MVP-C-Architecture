//
//  Int.swift
//  PharmacyPortal
//
//  Created by user on 22.04.2021.
//  Copyright © 2021 com.chisw. All rights reserved.
//

import Foundation

extension Int {
    var boolValue: Bool { return self != 0 }
}

extension Double {
    var clean: String {
       return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
    }
}
