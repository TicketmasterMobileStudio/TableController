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

    init(title: String) {
        super.init()

        self.title = title
        self.cellHeight = 60.0
    }

    override var cellType: TableReusableViewType {
        return .class(viewClass: UITableViewCell.self, identifier: "SimpleCell")
    }

    override func configure(_ cell: UITableViewCell) {
        cell.textLabel?.text = title
    }
    
}
