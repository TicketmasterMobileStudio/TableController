//
//  ResizingHeaderController.swift
//  ExampleProject
//
//  Created by Duncan Lewis on 7/14/17.
//  Copyright © 2017 Duncan Lewis. All rights reserved.
//

import TableController

class ResizingHeaderController: HeaderFooterController {

    override init() {
        super.init()
        self.height = 44.0
    }

    override var type: TableReusableViewType {
        return .class(viewClass: UITableViewHeaderFooterView.self, identifier: "ResizingHeaderView")
    }

    override func configure(view: UITableViewHeaderFooterView) {
        view.textLabel?.text = "Tap to Resize"
        view.contentView.backgroundColor = .red
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ResizingHeaderController.performSelectionAction)))
    }

    var expanded: Bool = false

    @objc func performSelectionAction() {
        self.delegate?.headerFooterControllerNeedsAnimatedChanges {
            self.expanded = !self.expanded
            self.height = self.expanded ? 88.0 : 44.0
        }
    }

}
