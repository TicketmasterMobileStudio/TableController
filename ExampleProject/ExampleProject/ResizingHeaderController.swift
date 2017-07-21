//
//  ResizingHeaderController.swift
//  ExampleProject
//
//  Created by Duncan Lewis on 7/14/17.
//  Copyright © 2017 Duncan Lewis. All rights reserved.
//

import TableController

class ResizingHeaderController: HeaderFooterControllerType {

    weak var delegate: HeaderFooterControllerDelegate?
    var type: TableReusableViewType = .class(viewClass: UITableViewHeaderFooterView.self, identifier: "ResizingHeaderView")
    var height: CGFloat = 44.0

    func configure(view: UITableViewHeaderFooterView) {
        view.textLabel?.text = "Tap to Resize"
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ResizingHeaderController.performSelectionAction)))
    }

    var expanded: Bool = false

    @objc func performSelectionAction() {
        self.expanded = !self.expanded
        self.height = self.expanded ? 88.0 : 44.0
        self.delegate?.headerFooterControllerNeedsAnimatedHeightChange()
    }

}
