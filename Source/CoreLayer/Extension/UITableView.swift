//
//  UITableView.swift
//

import Foundation
import UIKit

extension UITableView {
    public func regiserCellByClass<T: UITableViewCell>(cellClass: T.Type) {
        let className = String(describing: cellClass)
        let bundle = Bundle(identifier: "com.chisw.PharmacyPortal")
        register(UINib(nibName: className, bundle: bundle), forCellReuseIdentifier: className)
    }

    public func dequeueCellBy<T: UITableViewCell>(cellClass: T.Type, indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: String(describing: cellClass), for: indexPath) as? T else {
            fatalError("dequeueCellBy method has not worked correctly")
        }
        return cell
    }
    
    func scrollToBottom(animated: Bool = true) {
        let section = self.numberOfSections
        if section > 0 {
            let row = self.numberOfRows(inSection: section - 1)
            if row > 0 {

                self.scrollToRow(at: IndexPath(row: row-1, section: section-1), at: .bottom, animated: animated)
            }
        }
    }
}

extension UITableView {

    func setEmptyView(_ view: UIView) {
        self.backgroundView = view
    }

    func restore() {
        self.backgroundView = nil
    }
    
    public func regiserCell(_ cellID: String) {
        let bundle = Bundle(identifier: "com.chisw.PharmacyPortal")
        register(UINib(nibName: cellID, bundle: bundle), forCellReuseIdentifier: cellID)
    }
}
