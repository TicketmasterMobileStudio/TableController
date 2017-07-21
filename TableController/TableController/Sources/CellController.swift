//
//  CellController.swift
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
open class CellController: NSObject {

    public override init() { }

    // MARK: Cell Sizing
    open var estimatedCellHeight: CGFloat {
        return self.cellHeight
    }
    open var cellHeight: CGFloat = UITableViewAutomaticDimension
    
    // MARK: Selection
    open var selectable: Bool = true

    open func performSelectionAction() {
        // no-op
    }
    
    // MARK: Cell Configuration
    open var cellType: TableReusableViewType {
        return .class(viewClass: UITableViewCell.self, identifier: "CellController")
    }

    open func configure(_ cell: UITableViewCell) { }
    open func willDisplay(_ cell: UITableViewCell) { }
    open func didEndDisplaying(_ cell: UITableViewCell) { }

    // MARK: Update/Animation Helpers
    public weak var delegate: CellControllerDelegate?
}

public protocol CellControllerDelegate: class {
    func cellControllerNeedsReload(_ cellController: CellController)
    func cellControllerNeedsAnimatedHeightChange(_ cellController: CellController)
}
