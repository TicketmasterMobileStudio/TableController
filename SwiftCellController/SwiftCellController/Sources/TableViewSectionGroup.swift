//
//  TableViewSectionGroup.swift
//  LiveNation
//
//  Created by Carmen Cerino on 2/2/16.
//  Copyright © 2016 Live Nation Entertainment. All rights reserved.
//

import Foundation
import UIKit

public class TableViewSectionGroup: NSObject, UITableViewDelegate, UITableViewDataSource {
    
    public var sectionsDisplayControllers: [SectionDisplayControllerType] {
        didSet {
            self.visibleIndexPaths = Set<NSIndexPath>()
        }
    }
    
    public var numberOfSections: Int { return self.sectionsDisplayControllers.count }
    
    private var visibleIndexPaths = Set<NSIndexPath>()
    private let tableView: UITableView
    
    public init(sections: [SectionDisplayControllerType], tableView: UITableView) {
        self.sectionsDisplayControllers = sections
        self.tableView = tableView
        
        super.init()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    public func registerCells() {
        sectionsDisplayControllers.forEach { section in
            section.cellTypes.forEach { cellType in
                switch cellType {
                case .Class(let cellClass, let identifier):
                    self.tableView.registerClass(cellClass, forCellReuseIdentifier: identifier)
                case .Nib(let nibName, let identifier):
                    self.tableView.registerNib(UINib(nibName: nibName, bundle: nil), forCellReuseIdentifier: identifier)
                }
            }
        }
    }
    
    public func reconfigureCellAtIndexPath(indexPath: NSIndexPath, inTableView tableView: UITableView) {
        if let cell = tableView.cellForRowAtIndexPath(indexPath) {
            self.sectionsDisplayControllers[indexPath.section].configureCell(cell, atIndex: indexPath.item)
        }
    }
}


// MARK: - UITableViewDataSource

public extension TableViewSectionGroup {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.sectionsDisplayControllers.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let section = self.sectionsDisplayControllers[section]
        return section.numberOfItems
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let section = self.sectionsDisplayControllers[indexPath.section]
        let cell = tableView.dequeueReusableCellWithIdentifier(section.cellIdentifierForIndexPath(indexPath), forIndexPath: indexPath)
        section.configureCell(cell, atIndex: indexPath.item)
        return cell
    }
}

// MARK: - UITableViewDelegate

public extension TableViewSectionGroup {
    
    func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        let section = self.sectionsDisplayControllers[indexPath.section]
        return section.canSelectCellAtIndex(indexPath.item) ? indexPath : nil
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let section = self.sectionsDisplayControllers[indexPath.section]
        return section.didSelectCellAtIndex(indexPath.item)
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        let section = self.sectionsDisplayControllers[indexPath.section]
        section.willDisplayCell(cell, atIndex: indexPath.item)
        self.visibleIndexPaths.insert(indexPath)
    }
    
    func tableView(tableView: UITableView, didEndDisplayingCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        guard self.visibleIndexPaths.contains(indexPath) else { return }
        let section = self.sectionsDisplayControllers[indexPath.section]
        section.didDisplayCell(cell, atIndex: indexPath.item)
        self.visibleIndexPaths.remove(indexPath)
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let section = self.sectionsDisplayControllers[indexPath.section]
        return section.cellHeightAtIndex(indexPath.item) ?? tableView.rowHeight
    }
    
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let section = self.sectionsDisplayControllers[indexPath.section]
        return section.estimatedCellHeightAtIndex(indexPath.item) ?? tableView.rowHeight
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let section = self.sectionsDisplayControllers[section]
        return section.headerHeight ?? tableView.sectionHeaderHeight
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        let section = self.sectionsDisplayControllers[section]
        return section.footerHeight ?? tableView.sectionFooterHeight
    }
}