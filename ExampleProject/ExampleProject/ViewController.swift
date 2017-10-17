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

    lazy var sectionsForStandardTable: [SectionController] = {
        return [ self.makeUpdatingSection(),
                 self.makeFirstSectionController() ]
    }()

    lazy var sectionsForGroupedTable: [SectionController] = {
        return [ self.makeUpdatingSection(),
                 self.makeFirstSectionController() ]
    }()

    func makeFirstSectionController() -> SectionController {
        let basicItem1 = SimpleCellController(title: "Item 1")
        let basicItem2 = SimpleCellController(title: "Item 2")
        let basicItem3 = SimpleCellController(title: "Item 3")

        let nibItem1 = NibCellController()

        let group = SectionController(cellControllers: [basicItem1, basicItem2, basicItem3, nibItem1], headerController: ExampleHeaderController())
        return group
    }

    func makeUpdatingSection() -> SectionController {
        let countingItem = SelfUpdatingCellController()
        let resizingItem = ResizingCellController()
        return SectionController(cellControllers: [countingItem, resizingItem], headerController: ResizingHeaderController(), footerController: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.sectionedTableView.backgroundColor = UIColor.groupTableViewBackground

        self.tableController = TableController(sections: self.sectionsForStandardTable, tableView: self.sectionedTableView)
        self.groupedController = TableController(sections: self.sectionsForGroupedTable, tableView: self.groupedTableView)
    }
    
    func showSectionedTable() {
        self.sectionedTableView.isHidden = false
        self.groupedTableView.isHidden = true
    }
    
    func showGroupedTable() {
        self.sectionedTableView.isHidden = true
        self.groupedTableView.isHidden = false
    }

}
