//
//  SectionControllerType.swift
//  LiveNation
//
//  Created by Carmen Cerino on 2/2/16.
//  Copyright © 2016 Live Nation Entertainment. All rights reserved.
//

import Foundation
import UIKit

/// A `SectionControllerType` describes something that handles the display of 
/// `UITableView` cells in a give section

public protocol SectionControllerType {
    
    var cellTypes: Set<TableReusableViewType> { get }
    
    var numberOfItems: Int { get }

    var headerController: HeaderFooterControllerType? { get }
    var footerController: HeaderFooterControllerType? { get }
    
    func configureCell(cell: UITableViewCell, atIndex index: Int)
    
    func estimatedCellHeightAtIndex(index: Int) -> CGFloat
    func cellHeightAtIndex(index: Int) -> CGFloat
    
    func canSelectCellAtIndex(index: Int) -> Bool
    func didSelectCellAtIndex(index: Int)
    
    func willDisplayCell(cell: UITableViewCell, atIndex index: Int)
    func didDisplayCell(cell: UITableViewCell, atIndex index: Int)
    
    func cellType(forIndexPath indexPath: NSIndexPath) -> TableReusableViewType
}

public extension SectionControllerType {
    
    func estimatedCellHeightAtIndex(index: Int) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func cellHeightAtIndex(index: Int) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func canSelectCellAtIndex(index: Int) -> Bool {
        return true
    }
    
    func didSelectCellAtIndex(index: Int) { }
    func willDisplayCell(cell: UITableViewCell, atIndex index: Int) { }
    func didDisplayCell(cell: UITableViewCell, atIndex index: Int) { }
    
}
