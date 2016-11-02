//
//  CellControllerType.swift
//  LiveNation
//
//  Created by Carmen Cerino on 2/2/16.
//  Copyright © 2016 Live Nation Entertainment. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
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
    func configure(cell: UITableViewCell)
    func willDisplay(cell: UITableViewCell)
    func didDisplay(cell: UITableViewCell)
}

public extension CellControllerType {
    var cellHeight: CGFloat { return UITableViewAutomaticDimension }
    var estimatedCellHeight: CGFloat { return UITableViewAutomaticDimension }
    var selectable: Bool { return true }
    func performSelectionAction() { }
    func willDisplay(cell cell: UITableViewCell) { }
    func didDisplay(cell cell: UITableViewCell) { }
}
