//
//  ViewController.swift
//  ExampleProject
//
//  Created by Duncan Lewis on 7/18/16.
//  Copyright © 2016 Duncan Lewis. All rights reserved.
//

import UIKit
import SwiftCellController

class ViewController: UIViewController {

    @IBOutlet weak var sectionedTableView: UITableView!
    @IBOutlet weak var groupedTableView: UITableView!
    
    var sectionGroup: TableController?
    var sectionGroup2: TableController?
    
    @IBAction func controlChanged(sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            self.showSectionedTable()
        case 1:
            self.showGroupedTable()
        default:
            break
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.sectionedTableView.backgroundColor = UIColor.groupTableViewBackgroundColor()
        
        let firstSectionController = BasicSectionController()
        let secondSectionController = self.setupSectionController()
        
        self.sectionGroup = TableController(sections: [firstSectionController, secondSectionController], tableView: self.sectionedTableView)
        self.sectionGroup2 = TableController(sections: [firstSectionController, secondSectionController], tableView: self.groupedTableView)
    }
    
    func showSectionedTable() {
        self.sectionedTableView.hidden = false
        self.groupedTableView.hidden = true
    }
    
    func showGroupedTable() {
        self.sectionedTableView.hidden = true
        self.groupedTableView.hidden = false
    }
    
    func setupSectionController() -> SectionController {
        let basicItem1 = BasicCellController(title: "Item 1")
        let basicItem2 = BasicCellController(title: "Item 2")
        
        let group = SectionController(cellControllers: [basicItem1, basicItem2])
        return group
    }

}

class BasicCellController: CellControllerType {
    
    var title: String = "Default"
    
    var cellType: TableReusableViewType = .Class(viewClass: UITableViewCell.self, identifier: "BasicCell")
    var cellHeight: CGFloat = 60.0
    
    init(title: String) {
        self.title = title
    }
    
    func configure(cell cell: UITableViewCell) {
        cell.textLabel?.text = title
    }
    
}

class BasicSectionController: SectionControllerType {
    
    let footerController: HeaderFooterControllerType? = nil
    let headerController: HeaderFooterControllerType? = TestHeaderController()
    
    let basicCellType: TableReusableViewType = .Class(viewClass: UITableViewCell.self, identifier: "BasicSectionCell")
    
    var cellTypes: Set<TableReusableViewType> {
        return [ self.basicCellType ]
    }
    
    var numberOfItems: Int = 4
    
    func configure(cell cell: UITableViewCell, atIndex index: Int) {
        cell.textLabel?.text = "Section Item: \(index)"
    }
    
    func cellType(forIndexPath indexPath: NSIndexPath) -> TableReusableViewType {
        return self.basicCellType
    }
}

class TestHeaderController: HeaderFooterControllerType {
    
    let height: CGFloat = 30.0
    let type: TableReusableViewType = .Class(viewClass: TestHeaderView.self, identifier: "TestHeader")
    
    func configure(view view: UITableViewHeaderFooterView) {
        guard let header = view as? TestHeaderView else { return }
        
        header.primaryLabel.text = "Hi"
        header.secondaryLabel.text = "Bye"
    }
    
    
}