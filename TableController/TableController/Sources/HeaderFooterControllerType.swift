//
//  HeaderFooterControllerType.swift
//  SwiftCellController
//
//  Created by Carmen Cerino on 7/21/16.
//  Copyright © 2016 Duncan Lewis. All rights reserved.
//

import Foundation

/// A `HeaderFooterControllerType` describes something that handles the display of
/// of a single `UIView` that represents a `UITableView` header or footer.
public protocol HeaderFooterControllerType {
    
    // MARK: Sizing
    var estimatedHeight: CGFloat { get }
    var height: CGFloat { get }
    
    // MARK: Configuration
    var type: TableReusableViewType { get }
    func configure(view view: UITableViewHeaderFooterView)
    func willDisplay(view view: UITableViewHeaderFooterView)
    func didDisplay(view view: UITableViewHeaderFooterView)
}

public extension HeaderFooterControllerType {
    var height: CGFloat { return UITableViewAutomaticDimension }
    var estimatedHeight: CGFloat { return self.height }
    func willDisplay(view view: UITableViewHeaderFooterView) { }
    func didDisplay(view view: UITableViewHeaderFooterView) { }
}