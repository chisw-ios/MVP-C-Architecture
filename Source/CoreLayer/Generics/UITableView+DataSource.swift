//
//  UITableView+DataSource.swift.swift
//

import UIKit

protocol CellConfigurable {
    func setModel(_ model: BaseCellProtocol)
}

// CellTableViewDataSource generic
final class CellTVDS<Model: BaseCellProtocol, Cell: UITableViewCell>: NSObject, UITableViewDelegate, UITableViewDataSource where Cell: Reusable, Cell: CellConfigurable {

    var dataObject: Array<Model> = Array() {
        didSet {
            tableView.reloadData()
        }
    }
    fileprivate unowned var tableView: UITableView

    init(forTableView tableView: UITableView, models: Array<Model>) {
        self.tableView = tableView
        self.dataObject = models
    }

    // MARK: TableViewDataSource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataObject.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: Cell = tableView.dequeueReusableCell(with: indexPath)
        cell.setModel(dataObject[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return dataObject[indexPath.row].rowHeight
    }
}
