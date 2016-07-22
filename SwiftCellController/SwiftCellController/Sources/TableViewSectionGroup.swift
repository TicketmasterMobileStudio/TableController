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
    private var cellRegistrationTracker = CellRegistrationTracker()
    
    public init(sections: [SectionDisplayControllerType], tableView: UITableView) {
        self.sectionsDisplayControllers = sections
        self.tableView = tableView
        
        super.init()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    public func reconfigureCellAtIndexPath(indexPath: NSIndexPath, inTableView tableView: UITableView) {
        if let cell = tableView.cellForRowAtIndexPath(indexPath) {
            self.sectionsDisplayControllers[indexPath.section].configureCell(cell, atIndex: indexPath.item)
        }
    }
}


// MARK: - Cell Registration

extension TableViewSectionGroup {
    
    struct CellRegistrationTracker {
        private var registeredCellTypes: [TableReusableViewType] = []
        
        func isRegistered(_ cellType: TableReusableViewType) -> Bool {
            return registeredCellTypes.contains(cellType)
        }
        
        mutating func markAsRegistered(_ cellType: TableReusableViewType) {
            registeredCellTypes.append(cellType)
        }
    }
    
    func register(cellType: TableReusableViewType) {
        if !self.cellRegistrationTracker.isRegistered(cellType) {
            cellType.register(asCellInTableView: self.tableView)
            self.cellRegistrationTracker.markAsRegistered(cellType)
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
        let cellType = section.cellType(forIndexPath: indexPath)
        
        self.register(cellType)
        let cell = tableView.dequeueReusableCellWithIdentifier(cellType.identifer, forIndexPath: indexPath)
        
        section.configureCell(cell, atIndex: indexPath.item)
        return cell
    }
}

// MARK: - UITableViewDelegate

public extension TableViewSectionGroup {
    
    // MARK: Cell Selection
    
    func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        let section = self.sectionsDisplayControllers[indexPath.section]
        return section.canSelectCellAtIndex(indexPath.item) ? indexPath : nil
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let section = self.sectionsDisplayControllers[indexPath.section]
        return section.didSelectCellAtIndex(indexPath.item)
    }
    
    // MARK: Cell Display
    
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
    
    // MARK: Cell Height
    
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let section = self.sectionsDisplayControllers[indexPath.section]
        return section.estimatedCellHeightAtIndex(indexPath.item) ?? tableView.estimatedRowHeight
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let section = self.sectionsDisplayControllers[indexPath.section]
        return section.cellHeightAtIndex(indexPath.item) ?? tableView.rowHeight
    }


    // MARK: Header Height
    
    public func tableView(tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        let section = self.sectionsDisplayControllers[section]
        return section.headerController?.estimatedHeight ?? tableView.estimatedSectionHeaderHeight
        
    }

    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let section = self.sectionsDisplayControllers[section]
        return section.headerController?.height ?? tableView.sectionHeaderHeight
    }
    
    // MARK: Footer Height
    
    public func tableView(tableView: UITableView, estimatedHeightForFooterInSection section: Int) -> CGFloat {
        let section = self.sectionsDisplayControllers[section]
        return section.footerController?.estimatedHeight ?? tableView.estimatedSectionFooterHeight
        
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        let section = self.sectionsDisplayControllers[section]
        return section.footerController?.height ?? tableView.sectionFooterHeight
    }
    
    // MARK: Header Display
    
    public func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let section = self.sectionsDisplayControllers[section]
        guard let controller = section.headerController else { return nil }
        return self.viewForController(controller, inTableView: tableView)
    }
    
    public func tableView(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let section = self.sectionsDisplayControllers[section]
        guard let header = view as? UITableViewHeaderFooterView else { return }
        section.headerController?.willDisplayView(header)
    }
    
    public func tableView(tableView: UITableView, didEndDisplayingHeaderView view: UIView, forSection section: Int) {
        let section = self.sectionsDisplayControllers[section]
        guard let header = view as? UITableViewHeaderFooterView else { return }
        section.headerController?.didDisplayView(header)
    }
    
    // MARK: Footer Display
    
    public func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let section = self.sectionsDisplayControllers[section]
        guard let controller = section.footerController else { return nil }
        return self.viewForController(controller, inTableView: tableView)
    }
    
    public func tableView(tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
        let section = self.sectionsDisplayControllers[section]
        guard let footer = view as? UITableViewHeaderFooterView else { return }
        section.footerController?.willDisplayView(footer)

    }
    
    public func tableView(tableView: UITableView, didEndDisplayingFooterView view: UIView, forSection section: Int) {
        let section = self.sectionsDisplayControllers[section]
        guard let footer = view as? UITableViewHeaderFooterView else { return }
        section.footerController?.didDisplayView(footer)
    }
}

// MARK: - Header/Footer Helpers
private extension TableViewSectionGroup {
    
    func dequeue(reusableHeaderFooterViewForController controller: HeaderFooterDisplayControllerType, inTableView tableView: UITableView) -> UIView? {
        if let view = tableView.dequeueReusableHeaderFooterViewWithIdentifier(controller.type.identifer) {
            guard let view = view as? UITableViewHeaderFooterView else { return nil }
            controller.configureView(view)
            return view
        }
        
        return nil
    }
    
    func viewForController(controller: HeaderFooterDisplayControllerType, inTableView tableView: UITableView) -> UIView? {
        if let view = self.dequeue(reusableHeaderFooterViewForController: controller, inTableView: tableView) {
            return view
        }
        
        controller.type.register(asHeaderFooterInTableView: tableView)
        return self.dequeue(reusableHeaderFooterViewForController: controller, inTableView: tableView)
    }
}