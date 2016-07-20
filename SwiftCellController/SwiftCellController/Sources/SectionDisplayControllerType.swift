//
//  SectionDisplayControllerType.swift
//  LiveNation
//
//  Created by Carmen Cerino on 2/2/16.
//  Copyright © 2016 Live Nation Entertainment. All rights reserved.
//

import Foundation
import UIKit

/// A `SectionDisplayControllerType` describes something that handles the display of 
/// `UITableView` cells in a give section

public protocol SectionDisplayControllerType {
    
    var cellTypes: Set<RegisterableCellType> { get }
    
    var numberOfItems: Int { get }
    
    var headerHeight: CGFloat? { get }
    var footerHeight: CGFloat? { get }
    
    func configureCell(cell: UITableViewCell, atIndex index: Int)
    
    func estimatedCellHeightAtIndex(index: Int) -> CGFloat?
    func cellHeightAtIndex(index: Int) -> CGFloat?
    
    func canSelectCellAtIndex(index: Int) -> Bool
    func didSelectCellAtIndex(index: Int)
    
    func willDisplayCell(cell: UITableViewCell, atIndex index: Int)
    func didDisplayCell(cell: UITableViewCell, atIndex index: Int)
    
    func cellType(forIndexPath indexPath: NSIndexPath) -> RegisterableCellType
}

public extension SectionDisplayControllerType {
    
    var headerHeight: CGFloat? { return nil }
    var footerHeight: CGFloat? { return nil }

    func estimatedCellHeightAtIndex(index: Int) -> CGFloat? {
        return self.cellHeightAtIndex(index)
    }
    
    func cellHeightAtIndex(index: Int) -> CGFloat? {
        return nil
    }
    
    func canSelectCellAtIndex(index: Int) -> Bool {
        return false
    }
    
    func didSelectCellAtIndex(index: Int) { }
    func willDisplayCell(cell: UITableViewCell, atIndex index: Int) { }
    func didDisplayCell(cell: UITableViewCell, atIndex index: Int) { }
    
}
