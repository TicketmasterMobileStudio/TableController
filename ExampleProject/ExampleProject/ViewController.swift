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


    lazy var sections: [SectionController] = {
        return [ self.firstSectionController, self.updatingSection ]
    }()

    let firstSectionController: SectionController = {
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
    var updatingSection: SectionController = {
        let countingItem = CountingCellController()
        let resizingItem = ResizingCellController()
        return SectionController(cellControllers: [countingItem, resizingItem], headerController: ResizingHeaderController(), footerController: nil)
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.sectionedTableView.backgroundColor = UIColor.groupTableViewBackground

        self.showSectionedTable()
    }
    
    func showSectionedTable() {
        self.sectionedTableView.isHidden = false
        self.groupedTableView.isHidden = true

        self.tableController = TableController(sections: self.sections, tableView: self.sectionedTableView)
    }
    
    func showGroupedTable() {
        self.sectionedTableView.isHidden = true
        self.groupedTableView.isHidden = false

        self.tableController = TableController(sections: self.sections, tableView: self.groupedTableView)
    }

}

class BasicCellController: CellController {
    
    var title: String = "Default"

    init(title: String) {
        super.init()

        self.title = title
        self.cellType = .class(viewClass: UITableViewCell.self, identifier: "BasicCell")
        self.cellHeight = 60.0
    }
    
    override func configure(_ cell: UITableViewCell) {
        cell.textLabel?.text = title
    }
    
}

class NibCellController: CellController {
    
    var title: String = "From Nib"

    override init() {
        super.init()
        self.cellType = .nib(nibName: "NibCell", bundle: Bundle.main, identifier: "NibCell")
    }
    
    override func configure(_ cell: UITableViewCell) {
        cell.textLabel?.text = title
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
