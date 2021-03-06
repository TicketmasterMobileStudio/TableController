//
//  TableReusableViewType.swift
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


import Foundation
import UIKit

/// A enum to encapsulate the different types of `UITableViewCells`
/// that can be registered with a `UITableView`

public enum TableReusableViewType: Hashable {
    case nib(nibName: String, bundle: Bundle, identifier: String)
    case `class`(viewClass: AnyClass, identifier: String)
    
    public var hashValue: Int {
        return self.identifier.hashValue
    }
    
    var identifier: String {
        switch self {
        case .class(_, let identifier):
            return identifier
        case .nib(_, _, let identifier):
            return identifier
        }
    }
    
    func registerAsCell(inTableView tableView: UITableView) {
        switch self {
        case .class(let cellClass, let identifier):
            tableView.register(cellClass, forCellReuseIdentifier: identifier)
        case .nib(let nibName, let bundle, let identifier):
            tableView.register(UINib(nibName: nibName, bundle: bundle), forCellReuseIdentifier: identifier)
        }
    }
    
    func registerAsHeaderFooter(inTableView tableView: UITableView) {
        switch self {
        case .class(let headerFooterClass, let identifier):
            tableView.register(headerFooterClass, forHeaderFooterViewReuseIdentifier: identifier)
        case .nib(let nibName, let bundle, let identifier):
            tableView.register(UINib(nibName: nibName, bundle: bundle), forHeaderFooterViewReuseIdentifier: identifier)
        }
    }
}

public func ==(lhs: TableReusableViewType, rhs: TableReusableViewType) -> Bool {
    switch (lhs, rhs) {
    case (let .class(cellClass1, identifier1), let .class(cellClass2, indentifier2)):
        return cellClass1 == cellClass2 && identifier1 == indentifier2
        
    case (let .nib(nibName1, bundle1, identifier1), let .nib(nibName2, bundle2, identifier2)):
        return nibName1 == nibName2 && identifier1 == identifier2 && bundle1 == bundle2
    default:
        return false
    }
}
