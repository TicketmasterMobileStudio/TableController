//
//  ExampleHeaderController.swift
//  ExampleProject
//
//  Created by Duncan Lewis on 8/14/17.
//  Copyright © 2017 Duncan Lewis. All rights reserved.
//

import TableController


class ExampleHeaderController: HeaderFooterController {

    override init() {
        super.init()
        self.height = 30.0
    }

    override var type: TableReusableViewType {
        return .class(viewClass: ExampleHeaderView.self, identifier: "ExampleHeader")
    }

    override func configure(view: UITableViewHeaderFooterView) {
        guard let header = view as? ExampleHeaderView else { return }

        header.primaryLabel.text = "Example"
        header.secondaryLabel.text = "Header"
    }
}
