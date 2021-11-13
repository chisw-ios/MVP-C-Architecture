//
//  BaseCell.swift
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
