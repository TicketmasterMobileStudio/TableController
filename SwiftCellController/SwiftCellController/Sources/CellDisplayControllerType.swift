//
//  CellDisplayControllerType.swift
//  LiveNation
//
//  Created by Carmen Cerino on 2/2/16.
//  Copyright © 2016 Live Nation Entertainment. All rights reserved.
//

import Foundation
import UIKit

/// A `CellDisplayControllerType` describes something that handles the display of
/// of a single `UITableViewCell`
public protocol CellDisplayControllerType {
    
    // MARK: Cell Sizing
    var estimatedCellHeight: CGFloat { get }
    var cellHeight: CGFloat { get }
    
    // MARK: Selection
    var selectable: Bool { get }
    func didSelectCell()
    
    // MARK: Cell Configuration
    var cellType: RegisterableCellType { get }
    func configureCell(cell: UITableViewCell)
    func willDisplayCell(cell: UITableViewCell)
    func didDisplayCell(cell: UITableViewCell)
}

public extension CellDisplayControllerType {
    var cellHeight: CGFloat { return UITableViewAutomaticDimension }
    var estimatedCellHeight: CGFloat { return UITableViewAutomaticDimension }
    var selectable: Bool { return false }
    func didSelectCell() { }
    func willDisplayCell(cell: UITableViewCell) { }
    func didDisplayCell(cell: UITableViewCell) { }
}