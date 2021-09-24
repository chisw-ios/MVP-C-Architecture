//
//  UICollectionView.swift
//  PharmacyPortal
//
//  Created by user on 21.10.2020.
//  Copyright © 2020 com.chisw. All rights reserved.
//

import Foundation
import UIKit

extension UICollectionView {
    public func regiserCellByClass<T: UICollectionViewCell>(cellClass: T.Type) {
        let className = String(describing: cellClass)
        let bundle = Bundle(identifier: "com.chisw.PharmacyPortal")
        register(UINib(nibName: className, bundle: bundle), forCellWithReuseIdentifier: className)
    }
    
    public func regiserHeaderByClass<T: UICollectionReusableView>(cellClass: T.Type) {
        let className = String(describing: cellClass)
        let bundle = Bundle(identifier: "com.chisw.PharmacyPortal")
        register(UINib(nibName: className, bundle: bundle), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: className)
    }
    
    public func regiserFooterByClass<T: UICollectionReusableView>(cellClass: T.Type) {
        let className = String(describing: cellClass)
        let bundle = Bundle(identifier: "com.chisw.PharmacyPortal")
        register(UINib(nibName: className, bundle: bundle), forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: className)
    }

    public func dequeueCellBy<T: UICollectionViewCell>(cellClass: T.Type, indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: String(describing: cellClass), for: indexPath) as? T else {
            fatalError("dequeueCellBy method has not worked correctly")
        }
        return cell
    }
    
    public func scrollToBottom(animated: Bool = true) {
        let section = self.numberOfSections
        if section > 0 {
            let row = self.numberOfItems(inSection: section - 1)
            if row > 0 {
                self.scrollToItem(at: IndexPath(row: row - 1, section: section - 1), at: .bottom, animated: animated)
            }
        }
    }
}

extension UICollectionView {

    func setEmptyView(_ view: UIView) {
        self.backgroundView = view
    }

    func restore() {
        self.backgroundView = nil
    }

}

