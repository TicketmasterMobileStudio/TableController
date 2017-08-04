//
//  ResizingCellController.swift
//  ExampleProject
//
//  Created by Duncan Lewis on 7/14/17.
//  Copyright © 2017 Duncan Lewis. All rights reserved.
//

import TableController

class ResizingCellController: CellController {

    override init() {
        super.init()
        self.cellHeight = 44.0
    }

    override var cellType: TableReusableViewType {
        return .class(viewClass: UITableViewCell.self, identifier: "ResizingCellController")
    }

    override func configure(_ cell: UITableViewCell) {
        cell.textLabel?.text = "Tap to Resize"
    }

    var expanded: Bool = false

    override func performSelectionAction() {
        self.delegate?.cellControllerNeedsAnimatedChanges(self) {
            self.expanded = !self.expanded
            self.cellHeight = self.expanded ? 88.0 : 44.0
        }
    }

}
