//
//  CellControllerType.swift
//  LiveNation
//
//  Created by Carmen Cerino on 2/2/16.
//  Copyright © 2016 Live Nation Entertainment. All rights reserved.
//

import UIKit

/// A `CellControllerType` describes something that handles the display of
/// of a single `UITableViewCell`
public protocol CellControllerType {
    
    // MARK: Cell Sizing
    var estimatedCellHeight: CGFloat { get }
    var cellHeight: CGFloat { get }
    
    // MARK: Selection
    var selectable: Bool { get }
    func performSelectionAction()
    
    // MARK: Cell Configuration
    var cellType: TableReusableViewType { get }
    func configure(cell cell: UITableViewCell)
    func willDisplay(cell cell: UITableViewCell)
    func didDisplay(cell cell: UITableViewCell)
}

public extension CellControllerType {
    var cellHeight: CGFloat { return UITableViewAutomaticDimension }
    var estimatedCellHeight: CGFloat { return UITableViewAutomaticDimension }
    var selectable: Bool { return true }
    func performSelectionAction() { }
    func willDisplay(cell cell: UITableViewCell) { }
    func didDisplay(cell cell: UITableViewCell) { }
}