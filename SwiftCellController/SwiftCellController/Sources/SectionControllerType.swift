//
//  SectionControllerType.swift
//  LiveNation
//
//  Created by Carmen Cerino on 2/2/16.
//  Copyright © 2016 Live Nation Entertainment. All rights reserved.
//

import UIKit

/// A `SectionControllerType` describes something that handles the display of 
/// `UITableView` cells in a give section

public protocol SectionControllerType {
    
    var cellTypes: Set<TableReusableViewType> { get }
    
    var numberOfItems: Int { get }

    var headerController: HeaderFooterControllerType? { get }
    var footerController: HeaderFooterControllerType? { get }
    
    func configure(cell cell: UITableViewCell, atIndex index: Int)
    
    func estimatedCellHeight(atIndex index: Int) -> CGFloat
    func cellHeight(atIndex index: Int) -> CGFloat
    
    func canSelectCell(atIndex index: Int) -> Bool
    func didSelectCell(atIndex index: Int)
    
    func willDisplay(cell cell: UITableViewCell, atIndex index: Int)
    func didDisplay(cell cell: UITableViewCell, atIndex index: Int)
    
    func cellType(forIndexPath indexPath: NSIndexPath) -> TableReusableViewType
}

public extension SectionControllerType {
    
    func estimatedCellHeight(atIndex index: Int) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func cellHeight(atIndex index: Int) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func canSelectCell(atIndex index: Int) -> Bool {
        return true
    }
    
    func didSelectCell(atIndex index: Int) { }
    func willDisplay(cell cell: UITableViewCell, atIndex index: Int) { }
    func didDisplay(cell cell: UITableViewCell, atIndex index: Int) { }
    
}
