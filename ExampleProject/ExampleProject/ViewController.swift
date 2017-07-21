//
//  ViewController.swift
//  ExampleProject
//
//  Created by Duncan Lewis on 7/18/16.
//  Copyright © 2016 Duncan Lewis. All rights reserved.
//

import UIKit
import TableController

class ViewController: UIViewController {

    @IBOutlet weak var sectionedTableView: UITableView!
    @IBOutlet weak var groupedTableView: UITableView!
    
    var tableController: TableController?
    var groupedController: TableController?
    
    @IBAction func controlChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            self.showSectionedTable()
        case 1:
            self.showGroupedTable()
        default:
            break
        }
    }

    let firstSectionController = BasicSectionController()
    let secondSectionController: SectionController = {
        let basicItem1 = BasicCellController(title: "Item 1")
        let basicItem2 = BasicCellController(title: "Item 2")
        let basicItem3 = BasicCellController(title: "Item 3")
        let basicItem4 = BasicCellController(title: "Item 4")
        let basicItem5 = BasicCellController(title: "Item 5")
        let basicItem6 = BasicCellController(title: "Item 6")

        let nibItem1 = NibCellController()

        let group = SectionController(cellControllers: [basicItem1, basicItem2, basicItem3, basicItem4, basicItem5, basicItem6, nibItem1])
        return group
    }()
    var updatingSection: SectionController?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.sectionedTableView.backgroundColor = UIColor.groupTableViewBackground

        var sections: [SectionControllerType] = [ self.firstSectionController, self.secondSectionController ]

        self.updatingSection = self.setupUpdatingSectionController()
        if let updatingSection = self.updatingSection {
            sections.append(updatingSection)
        }

        self.tableController = TableController(sections: sections, tableView: self.sectionedTableView)
        self.groupedController = TableController(sections: sections, tableView: self.groupedTableView)
    }
    
    func showSectionedTable() {
        self.sectionedTableView.isHidden = false
        self.groupedTableView.isHidden = true
    }
    
    func showGroupedTable() {
        self.sectionedTableView.isHidden = true
        self.groupedTableView.isHidden = false
    }

    func setupUpdatingSectionController() -> SectionController {
        let countingItem = CountingCellController()
        let resizingItem = ResizingCellController()
        return SectionController(cellControllers: [countingItem, resizingItem], headerController: ResizingHeaderController(), footerController: nil)
    }

}

class BasicCellController: CellControllerType {
    
    var title: String = "Default"
    weak var delegate: CellControllerDelegate?

    var cellType: TableReusableViewType = .class(viewClass: UITableViewCell.self, identifier: "BasicCell")
    var cellHeight: CGFloat = 60.0
    
    init(title: String) {
        self.title = title
    }
    
    func configure(_ cell: UITableViewCell) {
        cell.textLabel?.text = title
    }
    
}

class NibCellController: CellControllerType {
    
    var title: String = "From Nib"
    weak var delegate: CellControllerDelegate?
    
    var cellType: TableReusableViewType = .nib(nibName: "NibCell", bundle: Bundle.main, identifier: "NibCell")
    
    func configure(_ cell: UITableViewCell) {
        cell.textLabel?.text = title
    }
    
}

class BasicSectionController: SectionControllerType {
    
    let headerController: HeaderFooterControllerType? = TestHeaderController()
    weak var delegate: SectionControllerDelegate?
    
    let basicCellType: TableReusableViewType = .class(viewClass: UITableViewCell.self, identifier: "BasicSectionCell")
    
    var cellTypes: Set<TableReusableViewType> {
        return [ self.basicCellType ]
    }
    
    var numberOfItems: Int = 4
    
    func configure(_ cell: UITableViewCell, atIndex index: Int) {
        cell.textLabel?.text = "Basic Section Item: \(index)"
    }
    
    func cellType(forIndexPath indexPath: IndexPath) -> TableReusableViewType {
        return self.basicCellType
    }
}

class TestHeaderController: HeaderFooterControllerType {

    weak var delegate: HeaderFooterControllerDelegate?

    let height: CGFloat = 30.0
    let type: TableReusableViewType = .class(viewClass: TestHeaderView.self, identifier: "TestHeader")
    
    func configure(view: UITableViewHeaderFooterView) {
        guard let header = view as? TestHeaderView else { return }
        
        header.primaryLabel.text = "Hi"
        header.secondaryLabel.text = "Bye"
    }
}
