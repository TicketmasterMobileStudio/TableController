//
//  ResizingCellController.swift
//  ExampleProject
//
//  Created by Duncan Lewis on 7/14/17.
//  Copyright © 2017 Duncan Lewis. All rights reserved.
//

import TableController

class ResizingCellController: CellControllerType {

    var cellHeight: CGFloat = 44.0
    var cellType: TableReusableViewType = .class(viewClass: UITableViewCell.self, identifier: "ResizingCellController")
    var delegate: CellControllerDelegate?

    func configure(_ cell: UITableViewCell) {
        cell.textLabel?.text = "Tap to Resize"
    }

    var expanded: Bool = false

    func performSelectionAction() {
        self.expanded = !self.expanded
        self.cellHeight = self.expanded ? 88.0 : 44.0
        self.delegate?.cellControllerNeedsAnimatedHeightChange(self)
    }

}
