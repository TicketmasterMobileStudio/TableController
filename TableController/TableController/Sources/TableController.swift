//
//  TableController.swift
//  LiveNation
//
//  Created by Carmen Cerino on 2/2/16.
//  Copyright © 2016 Live Nation Entertainment. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//


import UIKit

public class TableController: NSObject, UITableViewDelegate, UITableViewDataSource {
    
    public var numberOfSections: Int { return self.sectionsControllers.count }
    
    private var sectionsControllers: [SectionControllerType] {
        didSet {
            self.visibleIndexPaths = Set<NSIndexPath>()
        }
    }
    
    private var visibleIndexPaths = Set<NSIndexPath>()
    private let tableView: UITableView
    private var registeredCellTypes: [TableReusableViewType] = []
    
    public init(sections: [SectionControllerType], tableView: UITableView) {
        self.sectionsControllers = sections
        self.tableView = tableView
        
        super.init()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    public func update(cellAt indexPath: NSIndexPath, in tableView: UITableView) {
        if let cell = tableView.cellForRowAtIndexPath(indexPath) {
            self.sectionsControllers[indexPath.section].configure(cell: cell, atIndex: indexPath.row)
        }
        self.update(cellAt: indexPath, in: tableView)
    }
}


// MARK: - Cell Registration

extension TableController {
    
    func register(cellType: TableReusableViewType) {
        if !self.registeredCellTypes.contains(cellType) {
            cellType.registerAsCell(inTableView: self.tableView)
            self.registeredCellTypes.append(cellType)
        }
    }
    
}

// MARK: - UITableViewDataSource

public extension TableController {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.sectionsControllers.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let section = self.sectionsControllers[section]
        return section.numberOfItems
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let section = self.sectionsControllers[indexPath.section]
        let cellType = section.cellType(forIndexPath: indexPath)
        
        self.register(cellType)
        let cell = tableView.dequeueReusableCellWithIdentifier(cellType.identifier, forIndexPath: indexPath)
        
        section.configure(cell: cell, atIndex: indexPath.row)
        return cell
    }
}

// MARK: - UITableViewDelegate

public extension TableController {
    
    // MARK: Cell Selection
    
    func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        let section = self.sectionsControllers[indexPath.section]
        return section.canSelectCell(atIndex: indexPath.item) ? indexPath : nil
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let section = self.sectionsControllers[indexPath.section]
        return section.didSelectCell(atIndex: indexPath.item)
    }
    
    // MARK: Cell Display
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        let section = self.sectionsControllers[indexPath.section]
        section.willDisplay(cell: cell, atIndex: indexPath.item)
        self.visibleIndexPaths.insert(indexPath)
    }
    
    func tableView(tableView: UITableView, didEndDisplayingCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        guard self.visibleIndexPaths.contains(indexPath) else { return }
        let section = self.sectionsControllers[indexPath.section]
        section.didDisplay(cell: cell, atIndex: indexPath.item)
        self.visibleIndexPaths.remove(indexPath)
    }
    
    // MARK: Cell Height
    
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let section = self.sectionsControllers[indexPath.section]
        return section.estimatedCellHeight(atIndex: indexPath.item) ?? tableView.estimatedRowHeight
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let section = self.sectionsControllers[indexPath.section]
        return section.cellHeight(atIndex: indexPath.item) ?? tableView.rowHeight
    }


    // MARK: Header Height
    
    public func tableView(tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        let section = self.sectionsControllers[section]
        return section.headerController?.estimatedHeight ?? tableView.estimatedSectionHeaderHeight
        
    }

    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let section = self.sectionsControllers[section]
        return section.headerController?.height ?? tableView.sectionHeaderHeight
    }
    
    // MARK: Footer Height
    
    public func tableView(tableView: UITableView, estimatedHeightForFooterInSection section: Int) -> CGFloat {
        let section = self.sectionsControllers[section]
        return section.footerController?.estimatedHeight ?? tableView.estimatedSectionFooterHeight
        
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        let section = self.sectionsControllers[section]
        return section.footerController?.height ?? tableView.sectionFooterHeight
    }
    
    // MARK: Header Display
    
    public func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let section = self.sectionsControllers[section]
        guard let controller = section.headerController else { return nil }
        return self.headerFooterView(forController: controller, in: tableView)
    }
    
    public func tableView(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let section = self.sectionsControllers[section]
        guard let header = view as? UITableViewHeaderFooterView else { return }
        section.headerController?.willDisplay(view: header)
    }
    
    public func tableView(tableView: UITableView, didEndDisplayingHeaderView view: UIView, forSection section: Int) {
        let section = self.sectionsControllers[section]
        guard let header = view as? UITableViewHeaderFooterView else { return }
        section.headerController?.didDisplay(view: header)
    }
    
    // MARK: Footer Display
    
    public func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let section = self.sectionsControllers[section]
        guard let controller = section.footerController else { return nil }
        return self.headerFooterView(forController: controller, in: tableView)
    }
    
    public func tableView(tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
        let section = self.sectionsControllers[section]
        guard let footer = view as? UITableViewHeaderFooterView else { return }
        section.footerController?.willDisplay(view: footer)

    }
    
    public func tableView(tableView: UITableView, didEndDisplayingFooterView view: UIView, forSection section: Int) {
        let section = self.sectionsControllers[section]
        guard let footer = view as? UITableViewHeaderFooterView else { return }
        section.footerController?.didDisplay(view: footer)
    }
}

// MARK: - Header/Footer Helpers
private extension TableController {
    
    func dequeue(reusableHeaderFooterViewForController controller: HeaderFooterControllerType, inTableView tableView: UITableView) -> UITableViewHeaderFooterView? {
        if let view = tableView.dequeueReusableHeaderFooterViewWithIdentifier(controller.type.identifier) {
            controller.configure(view: view)
            return view
        }
        
        return nil
    }
    
    func headerFooterView(forController controller: HeaderFooterControllerType, in tableView: UITableView) -> UITableViewHeaderFooterView? {
        if let view = self.dequeue(reusableHeaderFooterViewForController: controller, inTableView: tableView) {
            return view
        }
        
        controller.type.registerAsHeaderFooter(inTableView: tableView)
        return self.dequeue(reusableHeaderFooterViewForController: controller, inTableView: tableView)
    }
}