//
//  SectionController.swift
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


import Foundation
import UIKit

/// A `SectionController` manages displaying a group of
/// `CellControllerTypes` in a given section of a `UITableView`

open class SectionController: SectionControllerType {

    open var delegate: SectionControllerDelegate?
    open var cellControllers: [CellControllerType] {
        didSet {
            for cellController in cellControllers {
                cellController.delegate = self
            }
        }
    }

    open let headerController: HeaderFooterControllerType?
    open let footerController: HeaderFooterControllerType?
    
    open var cellTypes: Set<TableReusableViewType> {
        return Set<TableReusableViewType>(cellControllers.map { $0.cellType })
    }

    open var numberOfItems: Int {
        return self.cellControllers.count
    }
    
    public convenience init(cellController: CellControllerType) {
        self.init(cellControllers: [cellController])
    }
    
    public init(cellControllers: [CellControllerType], headerController: HeaderFooterControllerType? = nil, footerController: HeaderFooterControllerType? = nil) {
        self.cellControllers = cellControllers
        self.headerController = headerController
        self.footerController = footerController

        for cellController in self.cellControllers {
            cellController.delegate = self
        }
        self.headerController?.delegate = self
        self.footerController?.delegate = self
    }

    open func cellType(forIndexPath indexPath: IndexPath) -> TableReusableViewType {
        return self.cellControllers[indexPath.item].cellType
    }
    
    open func configure(_ cell: UITableViewCell, atIndex index: Int) {
        self.cellControllers[index].configure(cell)
    }
    
    open func cellHeight(atIndex index: Int) -> CGFloat {
        return self.cellControllers[index].cellHeight
    }
    
    open func estimatedCellHeight(atIndex index: Int) -> CGFloat {
        return self.cellControllers[index].estimatedCellHeight
    }
    
    open func canSelectCell(atIndex index: Int) -> Bool {
        return self.cellControllers[index].selectable
    }
    
    open func didSelectCell(atIndex index: Int) {
        self.cellControllers[index].performSelectionAction()
    }
    
    open func willDisplay(_ cell: UITableViewCell, atIndex index: Int) {
        self.cellControllers[index].willDisplay(cell)
    }
    
    open func didEndDisplaying(_ cell: UITableViewCell, atIndex index: Int) {
        self.cellControllers[index].didEndDisplaying(cell)
    }
}


extension SectionController: CellControllerDelegate {

    public func cellControllerNeedsReload(_ cellController: CellControllerType) {
        if let index = self.cellControllers.index(where: { $0 === cellController }) {
            self.delegate?.sectionControllerNeedsReload(self, atIndex: index)
        }
    }

    public func cellControllerNeedsAnimatedHeightChange(_ cellController: CellControllerType) {
        self.delegate?.sectionControllerNeedsAnimatedHeightChange()
    }

}

extension SectionController: HeaderFooterControllerDelegate {

    public func headerFooterControllerNeedsReload(_ headerFooterController: HeaderFooterControllerType) {
        if self.headerController === headerFooterController {
            self.delegate?.sectionControllerHeaderNeedsReload(self)
        } else if self.footerController === headerFooterController {
            self.delegate?.sectionControllerFooterNeedsReload(self)
        }
    }

    public func headerFooterControllerNeedsAnimatedHeightChange() {
        self.delegate?.sectionControllerNeedsAnimatedHeightChange()
    }

}
