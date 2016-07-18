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
    
    var cellType: RegisterableCellType { get }

    var estimatedCellHeight: CGFloat? { get }
    var cellHeight: CGFloat? { get }
    var selectable: Bool { get }
    
    func configureCell(cell: UITableViewCell)
    func didSelectCell()
    
    func willDisplayCell(cell: UITableViewCell)
    func didDisplayCell(cell: UITableViewCell)
}

public extension CellDisplayControllerType {
    var cellHeight: CGFloat? { return nil }
    var estimatedCellHeight: CGFloat? { return self.cellHeight }
    var selectable: Bool { return false }
    func didSelectCell() { }
    func willDisplayCell(cell: UITableViewCell) { }
    func didDisplayCell(cell: UITableViewCell) { }
}