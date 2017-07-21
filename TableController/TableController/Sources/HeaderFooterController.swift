//
//  HeaderFooterController.swift
//  TableController
//
//  Created by Carmen Cerino on 7/21/16.
//  Copyright © 2016 Duncan Lewis. All rights reserved.
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


import Foundation

/// A `HeaderFooterController` describes something that handles the display of
/// of a single `UIView` that represents a `UITableView` header or footer.
open class HeaderFooterController {

    public weak var delegate: HeaderFooterControllerDelegate?

    // MARK: Sizing
    open var estimatedHeight: CGFloat {
        return self.height
    }
    open var height: CGFloat = UITableViewAutomaticDimension
    
    // MARK: Configuration
    open var type: TableReusableViewType = .class(viewClass: UITableViewHeaderFooterView.self, identifier: "HeaderFooterController")
    open func configure(view: UITableViewHeaderFooterView) { }
    open func willDisplay(view: UITableViewHeaderFooterView) { }
    open func didEndDisplaying(view: UITableViewHeaderFooterView) { }

    public init() { }
}

public protocol HeaderFooterControllerDelegate: class {
    func headerFooterControllerNeedsReload(_ headerFooterController: HeaderFooterController)
    func headerFooterControllerNeedsAnimatedHeightChange()
}
