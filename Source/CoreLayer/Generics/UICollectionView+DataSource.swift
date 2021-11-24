//
//  UICollectionView+DataSource.swift
//

import UIKit

final class CellCVDS<Model: BaseCellProtocol, Cell: UICollectionViewCell>: NSObject, UICollectionViewDelegate, UICollectionViewDataSource where Cell: Reusable, Cell: CellConfigurable {
    
    var dataObject: Array<Model> = Array() {
        didSet {
            collectionView.reloadData()
        }
    }
    fileprivate unowned var collectionView: UICollectionView

    init(forCollectionView collectionView: UICollectionView, models: Array<Model>) {
        self.collectionView = collectionView
        self.dataObject = models
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataObject.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: Cell = collectionView.dequeueReusableCell(with: indexPath)
        cell.setModel(dataObject[indexPath.row])
        return cell
    }
}
