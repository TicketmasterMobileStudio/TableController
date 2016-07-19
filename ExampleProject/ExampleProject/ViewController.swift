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
    
    var sectionGroup: TableViewSectionGroup?
    var sectionGroup2: TableViewSectionGroup?
    
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
        
        let sectionDisplayController = BasicSectionDisplayController()
        let cellDisplayControllerGroup = self.setupCellDisplayControllerGroup()
        
        self.sectionGroup = TableViewSectionGroup(sections: [sectionDisplayController, cellDisplayControllerGroup], tableView: self.sectionedTableView)
        self.sectionGroup2 = TableViewSectionGroup(sections: [sectionDisplayController, cellDisplayControllerGroup], tableView: self.groupedTableView)
        
        self.sectionGroup?.registerCells()
        self.sectionGroup2?.registerCells()
    }
    
    func showSectionedTable() {
        self.sectionedTableView.hidden = false
        self.groupedTableView.hidden = true
    }
    
    func showGroupedTable() {
        self.sectionedTableView.hidden = true
        self.groupedTableView.hidden = false
    }
    
    func setupCellDisplayControllerGroup() -> CellDisplayControllerGroup {
        let basicItem1 = BasicCellDisplayController(title: "Item 1")
        let basicItem2 = BasicCellDisplayController(title: "Item 2")
        
        let group = CellDisplayControllerGroup(cellControllers: [basicItem1, basicItem2])
        return group
    }

}

class BasicCellDisplayController: CellDisplayControllerType {
    
    var title: String = "Default"
    
    var cellType: RegisterableCellType = .Class(cellClass: UITableViewCell.self, identifier: "BasicCell")
    var cellHeight: CGFloat? = 60.0
    
    init(title: String) {
        self.title = title
    }
    
    func configureCell(cell: UITableViewCell) {
        cell.textLabel?.text = title
    }
    
}

class BasicSectionDisplayController: SectionDisplayControllerType {
    
    var cellTypes: Set<RegisterableCellType> = [ .Class(cellClass: UITableViewCell.self, identifier: "BasicSectionCell") ]
    
    var numberOfItems: Int = 4
    
    func configureCell(cell: UITableViewCell, atIndex index: Int) {
        cell.textLabel?.text = "Section Item: \(index)"
    }
    
    func cellIdentifierForIndexPath(indexPath: NSIndexPath) -> String {
        return "BasicSectionCell"
    }
}