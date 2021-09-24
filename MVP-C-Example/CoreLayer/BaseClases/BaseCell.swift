//
//  BaseCell.swift
//  MVP-C-Example
//
//  Created by vlad.kosyi on 02.07.2021.
//

import UIKit

protocol BaseCellProtocol {
    var rowHeight: CGFloat { get set }
    var title: String { get set }
}

class BaseCell: UITableViewCell, CellConfigurable {
    
    func setModel(_ model: BaseCellProtocol) {
        
    }
}
