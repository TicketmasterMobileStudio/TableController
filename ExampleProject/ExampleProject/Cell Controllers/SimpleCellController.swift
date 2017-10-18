//
//  SimpleCellController.swift
//  ExampleProject
//
//  Created by Duncan Lewis on 8/14/17.
//  Copyright © 2017 Duncan Lewis. All rights reserved.
//

import TableController


class SimpleCellController: CellController {

    var title: String = "Default"
    private let deletionBlock: (SimpleCellController)->Void
    
    init(title: String, deletionBlock: @escaping (SimpleCellController)->Void) {
        self.deletionBlock = deletionBlock

        super.init()

        self.title = title
        self.cellHeight = 60.0
    }

    override var cellType: TableReusableViewType {
        return .class(viewClass: UITableViewCell.self, identifier: "SimpleCell")
    }

    override func configure(_ cell: UITableViewCell) {
        cell.textLabel?.text = title
        if (cell.accessoryView as? UIButton == nil) {
            let button = UIButton(type: .custom)
            button.setTitle("Delete", for: .normal)
            button.setTitleColor(.red, for: .normal)
            button.sizeToFit()
            cell.accessoryView = button
        }
        (cell.accessoryView as? UIButton)?.addTarget(self, action: #selector(SimpleCellController.deleteButtonAction(_:)), for: .touchUpInside)
    }
    
    @objc
    private func deleteButtonAction(_ sender: Any?) {
        self.deletionBlock(self)
    }
}
