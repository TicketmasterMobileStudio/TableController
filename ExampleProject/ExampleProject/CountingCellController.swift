//
//  CountingCellController.swift
//  ExampleProject
//
//  Created by Duncan Lewis on 7/14/17.
//  Copyright © 2017 Duncan Lewis. All rights reserved.
//

import TableController


class CountingCellController: CellController {

    var count: Int = 0

    override init() {
        super.init()
        self.cellHeight = 44.0
    }

    override var cellType: TableReusableViewType {
        return .nib(nibName: "CountingCell", bundle: Bundle.main, identifier: "CountingCell")
    }

    override func configure(_ cell: UITableViewCell) {
        guard let countingCell = cell as? CountingCell else { return }

        countingCell.countLabel.text = "Count: \(self.count)"
    }

    override func willDisplay(_ cell: UITableViewCell) {
        guard let countingCell = cell as? CountingCell else { return }

        countingCell.incrementButton.addTarget(self, action: #selector(CountingCellController.incrementButtonWasTapped), for: .touchUpInside)
    }

    override func didEndDisplaying(_ cell: UITableViewCell) {
        guard let countingCell = cell as? CountingCell else { return }

        countingCell.incrementButton.addTarget(self, action: #selector(CountingCellController.incrementButtonWasTapped), for: .touchUpInside)
    }

    @objc func incrementButtonWasTapped() {
        self.count += 1
        self.delegate?.cellControllerNeedsReload(self)
    }

}

class CountingCell: UITableViewCell {

    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var incrementButton: UIButton!

}
