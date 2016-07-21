//
//  HeaderFooterDisplayControllerType.swift
//  SwiftCellController
//
//  Created by Carmen Cerino on 7/21/16.
//  Copyright © 2016 Duncan Lewis. All rights reserved.
//

import Foundation

/// A `HeaderFooterDisplayControllerType` describes something that handles the display of
/// of a single `UIView` that represents a `UITableView` header or footer.
public protocol HeaderFooterDisplayControllerType {
    
    // MARK: Sizing
    var estimatedHeight: CGFloat { get }
    var height: CGFloat { get }
    
    // MARK: Configuration
    var type: TableReusableViewType { get }
    func configureView(view: UITableViewHeaderFooterView)
    func willDisplayView(view: UITableViewHeaderFooterView)
    func didDisplayView(view: UITableViewHeaderFooterView)
}

public extension HeaderFooterDisplayControllerType {
    var height: CGFloat { return UITableViewAutomaticDimension }
    var estimatedHeight: CGFloat { return self.height }
    func willDisplayView(view: UITableViewHeaderFooterView) { }
    func didDisplayView(view: UITableViewHeaderFooterView) { }
}