//
//  SectionControllerType.swift
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

/// A `SectionControllerType` describes something that handles the display of 
/// `UITableView` cells in a give section

public protocol SectionControllerType {
    
    var cellTypes: Set<TableReusableViewType> { get }
    
    var numberOfItems: Int { get }

    var headerController: HeaderFooterControllerType? { get }
    var footerController: HeaderFooterControllerType? { get }
    
    func configure(_ cell: UITableViewCell, atIndex index: Int)
    
    func estimatedCellHeight(atIndex index: Int) -> CGFloat
    func cellHeight(atIndex index: Int) -> CGFloat
    
    func canSelectCell(atIndex index: Int) -> Bool
    func didSelectCell(atIndex index: Int)
    
    func willDisplay(_ cell: UITableViewCell, atIndex index: Int)
    func didEndDisplaying(_ cell: UITableViewCell, atIndex index: Int)
    
    func cellType(forIndexPath indexPath: IndexPath) -> TableReusableViewType
}

public extension SectionControllerType {
    
    var headerController: HeaderFooterControllerType? { return nil }
    var footerController: HeaderFooterControllerType? { return nil }
    
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
    func willDisplay(_ cell: UITableViewCell, atIndex index: Int) { }
    func didEndDisplaying(_ cell: UITableViewCell, atIndex index: Int) { }
    
}
