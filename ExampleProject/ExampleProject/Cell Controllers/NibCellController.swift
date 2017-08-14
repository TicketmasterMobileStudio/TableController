//
//  NibCellController.swift
//  ExampleProject
//
//  Created by Duncan Lewis on 8/14/17.
//  Copyright © 2017 Duncan Lewis. All rights reserved.
//

import TableController


class NibCellController: CellController {

    var title: String = "From Nib"

    override var cellType: TableReusableViewType {
        return .nib(nibName: "NibCell", bundle: Bundle.main, identifier: "NibCell")
    }

    override func configure(_ cell: UITableViewCell) {
        cell.textLabel?.text = title
    }

}
