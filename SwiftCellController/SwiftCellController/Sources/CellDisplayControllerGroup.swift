//
//  CellDisplayControllerGroup.swift
//  LiveNation
//
//  Created by Carmen Cerino on 2/2/16.
//  Copyright © 2016 Live Nation Entertainment. All rights reserved.
//

import Foundation
import UIKit

/// A `CellDisplayControllerGroup` manages displaying a group of
/// `CellDisplayControllers` in a give section of a `UITableView`

public class CellDisplayControllerGroup: SectionDisplayControllerType {
    
    var cellControllers: [CellDisplayControllerType]

    public let headerController: HeaderFooterDisplayControllerType?
    public let footerController: HeaderFooterDisplayControllerType?
    
    public var cellTypes: Set<TableReusableViewType> {
        return Set<TableReusableViewType>(cellControllers.map { $0.cellType })
    }

    public var numberOfItems: Int {
        return self.cellControllers.count
    }
    
    public convenience init(cellController: CellDisplayControllerType) {
        self.init(cellControllers: [cellController])
    }
    
    public init(cellControllers: [CellDisplayControllerType], headerController: HeaderFooterDisplayControllerType? = nil, footerController: HeaderFooterDisplayControllerType? = nil) {
        self.cellControllers = cellControllers
        self.headerController = headerController
        self.footerController = footerController
    }
    
    public func cellType(forIndexPath indexPath: NSIndexPath) -> TableReusableViewType {
        return self.cellControllers[indexPath.item].cellType
    }
    
    public func configureCell(cell: UITableViewCell, atIndex index: Int) {
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
    
    public func willDisplayCell(cell: UITableViewCell, atIndex index: Int) {
        self.cellControllers[index].willDisplayCell(cell)
    }
    
    public func didDisplayCell(cell: UITableViewCell, atIndex index: Int) {
        self.cellControllers[index].didDisplayCell(cell)
    }
}
