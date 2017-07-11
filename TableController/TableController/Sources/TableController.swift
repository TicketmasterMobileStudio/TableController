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

open class TableController: NSObject, UITableViewDelegate, UITableViewDataSource {
    
    open var numberOfSections: Int { return self.sectionsControllers.count }
    
    fileprivate var sectionsControllers: [SectionControllerType] {
        didSet {
            self.visibleIndexPaths = Set<IndexPath>()
            self.visibleHeaders = NSMutableIndexSet()
            self.visibleFooters = NSMutableIndexSet()
        }
    }
    
    fileprivate var visibleIndexPaths = Set<IndexPath>()
    fileprivate var visibleHeaders = NSMutableIndexSet()
    fileprivate var visibleFooters = NSMutableIndexSet()
    fileprivate let tableView: UITableView
    fileprivate var registeredCellTypes: [TableReusableViewType] = []
    
    public init(sections: [SectionControllerType], tableView: UITableView) {
        self.sectionsControllers = sections
        self.tableView = tableView
        
        super.init()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    open func update(cellAt indexPath: IndexPath, in tableView: UITableView) {
        if let cell = tableView.cellForRow(at: indexPath) {
            self.sectionsControllers[indexPath.section].configure(cell, atIndex: indexPath.row)
        }
        self.update(cellAt: indexPath, in: tableView)
    }
}


// MARK: - Cell Registration

extension TableController {
    
    func register(_ cellType: TableReusableViewType) {
        if !self.registeredCellTypes.contains(cellType) {
            cellType.registerAsCell(inTableView: self.tableView)
            self.registeredCellTypes.append(cellType)
        }
    }
    
}

// MARK: - UITableViewDataSource

public extension TableController {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.sectionsControllers.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let section = self.sectionsControllers[section]
        return section.numberOfItems
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = self.sectionsControllers[indexPath.section]
        let cellType = section.cellType(forIndexPath: indexPath)
        
        self.register(cellType)
        let cell = tableView.dequeueReusableCell(withIdentifier: cellType.identifier, for: indexPath)
        
        section.configure(cell, atIndex: indexPath.row)
        return cell
    }
}

// MARK: - UITableViewDelegate

public extension TableController {
    
    // MARK: Cell Selection
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        let section = self.sectionsControllers[indexPath.section]
        return section.canSelectCell(atIndex: indexPath.item) ? indexPath : nil
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let section = self.sectionsControllers[indexPath.section]
        return section.didSelectCell(atIndex: indexPath.item)
    }
    
    // MARK: Cell Display
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let section = self.sectionsControllers[indexPath.section]
        section.willDisplay(cell, atIndex: indexPath.item)
        self.visibleIndexPaths.insert(indexPath)
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard self.visibleIndexPaths.contains(indexPath) else { return }
        let section = self.sectionsControllers[indexPath.section]
        section.didEndDisplaying(cell, atIndex: indexPath.item)
        self.visibleIndexPaths.remove(indexPath)
    }
    
    // MARK: Cell Height
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        let section = self.sectionsControllers[indexPath.section]
        return section.estimatedCellHeight(atIndex: indexPath.item)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let section = self.sectionsControllers[indexPath.section]
        return section.cellHeight(atIndex: indexPath.item)
    }


    // MARK: Header Height
    
    public func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        let section = self.sectionsControllers[section]
        return section.headerController?.estimatedHeight ?? tableView.estimatedSectionHeaderHeight
        
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let section = self.sectionsControllers[section]
        return section.headerController?.height ?? tableView.sectionHeaderHeight
    }
    
    // MARK: Footer Height
    
    public func tableView(_ tableView: UITableView, estimatedHeightForFooterInSection section: Int) -> CGFloat {
        let section = self.sectionsControllers[section]
        return section.footerController?.estimatedHeight ?? tableView.estimatedSectionFooterHeight
        
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        let section = self.sectionsControllers[section]
        return section.footerController?.height ?? tableView.sectionFooterHeight
    }
    
    // MARK: Header Display
    
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let section = self.sectionsControllers[section]
        guard let controller = section.headerController else { return nil }
        return self.headerFooterView(forController: controller, in: tableView)
    }
    
    public func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let sectionController = self.sectionsControllers[section]
        guard let header = view as? UITableViewHeaderFooterView else { return }
        sectionController.headerController?.willDisplay(view: header)
        self.visibleHeaders.add(section)
    }
    
    public func tableView(_ tableView: UITableView, didEndDisplayingHeaderView view: UIView, forSection section: Int) {
        guard self.visibleHeaders.contains(section) else { return }
        let sectionController = self.sectionsControllers[section]
        guard let header = view as? UITableViewHeaderFooterView else { return }
        sectionController.headerController?.didEndDisplaying(view: header)
        self.visibleHeaders.remove(section)
    }
    
    // MARK: Footer Display
    
    public func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let section = self.sectionsControllers[section]
        guard let controller = section.footerController else { return nil }
        return self.headerFooterView(forController: controller, in: tableView)
    }
    
    public func tableView(_ tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
        let sectionController = self.sectionsControllers[section]
        guard let footer = view as? UITableViewHeaderFooterView else { return }
        sectionController.footerController?.willDisplay(view: footer)
        self.visibleFooters.add(section)
    }
    
    public func tableView(_ tableView: UITableView, didEndDisplayingFooterView view: UIView, forSection section: Int) {
        guard self.visibleFooters.contains(section) else { return }
        let sectionController = self.sectionsControllers[section]
        guard let footer = view as? UITableViewHeaderFooterView else { return }
        sectionController.footerController?.didEndDisplaying(view: footer)
        self.visibleFooters.remove(section)
    }
}

// MARK: - Header/Footer Helpers
private extension TableController {
    
    func dequeue(reusableHeaderFooterViewForController controller: HeaderFooterControllerType, inTableView tableView: UITableView) -> UITableViewHeaderFooterView? {
        if let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: controller.type.identifier) {
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
