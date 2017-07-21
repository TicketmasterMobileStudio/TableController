//
//  CountingCellController.swift
//  ExampleProject
//
//  Created by Duncan Lewis on 7/14/17.
//  Copyright © 2017 Duncan Lewis. All rights reserved.
//

import TableController


class CountingCellController: CellControllerType {

    weak var delegate: CellControllerDelegate?

    var count: Int = 0

    var height: CGFloat = 44.0

    var cellType: TableReusableViewType = .nib(nibName: "CountingCell", bundle: Bundle.main, identifier: "CountingCell")

    func configure(_ cell: UITableViewCell) {
        guard let countingCell = cell as? CountingCell else { return }

        countingCell.countLabel.text = "Count: \(self.count)"
    }

    func willDisplay(_ cell: UITableViewCell) {
        guard let countingCell = cell as? CountingCell else { return }

        countingCell.incrementButton.addTarget(self, action: #selector(CountingCellController.incrementButtonWasTapped), for: .touchUpInside)
    }

    func didEndDisplaying(_ cell: UITableViewCell) {
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
