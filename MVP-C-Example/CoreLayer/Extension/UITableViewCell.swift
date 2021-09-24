//
//  UITableViewCell.swift
//  PharmacyPortal
//
//  Created by vlad.kosyi on 03.11.2020.
//  Copyright © 2020 com.chisw. All rights reserved.
//

import UIKit

extension UITableViewCell {
    
    static var reuseIdentifier: String {
      return String(describing: self)
    }
}
