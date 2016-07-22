//
//  SectionController.swift
//  LiveNation
//
//  Created by Carmen Cerino on 2/2/16.
//  Copyright © 2016 Live Nation Entertainment. All rights reserved.
//

import Foundation
import UIKit

/// A `SectionController` manages displaying a group of
/// `CellControllerTypes` in a given section of a `UITableView`

public class SectionController: SectionControllerType {
    
    var cellControllers: [CellControllerType]

    public let headerController: HeaderFooterControllerType?
    public let footerController: HeaderFooterControllerType?
    
    public var cellTypes: Set<TableReusableViewType> {
        return Set<TableReusableViewType>(cellControllers.map { $0.cellType })
    }

    public var numberOfItems: Int {
        return self.cellControllers.count
    }
    
    public convenience init(cellController: CellControllerType) {
        self.init(cellControllers: [cellController])
    }
    
    public init(cellControllers: [CellControllerType], headerController: HeaderFooterControllerType? = nil, footerController: HeaderFooterControllerType? = nil) {
        self.cellControllers = cellControllers
        self.headerController = headerController
        self.footerController = footerController
    }
    
    public func cellType(forIndexPath indexPath: NSIndexPath) -> TableReusableViewType {
        return self.cellControllers[indexPath.item].cellType
    }
    
    public func configure(cell cell: UITableViewCell, atIndex index: Int) {
        self.cellControllers[index].configureCell(cell)
    }
    
    public func cellHeightAtIndex(index: Int) -> CGFloat {
        return self.cellControllers[index].cellHeight
    }
    
    public func estimatedCellHeightAtIndex(index: Int) -> CGFloat {
        return self.cellControllers[index].estimatedCellHeight
    }
    
    public func canSelectCellAtIndex(index: Int) -> Bool {
        return self.cellControllers[index].selectable
    }
    
    public func didSelectCellAtIndex(index: Int) {
        self.cellControllers[index].didSelectCell()
    }
    
    public func willDisplay(cell cell: UITableViewCell, atIndex index: Int) {
        self.cellControllers[index].willDisplayCell(cell)
    }
    
    public func didDisplay(cell cell: UITableViewCell, atIndex index: Int) {
        self.cellControllers[index].didDisplayCell(cell)
    }
}
