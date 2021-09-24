//
//  Array.swift
//  PharmacyPortal
//
//  Created by user on 07.12.2020.
//  Copyright © 2020 com.chisw. All rights reserved.
//

import Foundation

extension Array {
    func isValidIndex(_ index : Int) -> Bool {
        return index < self.count
    }
}
