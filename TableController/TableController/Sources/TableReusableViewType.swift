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
    case Nib(nibName: String, identifier: String)
    case Class(viewClass: AnyClass, identifier: String)
    
    public var hashValue: Int {
        return self.identifier.hashValue
    }
    
    var identifier: String {
        switch self {
        case .Class(_, let identifier):
            return identifier
        case .Nib(_, let identifier):
            return identifier
        }
    }
    
    func registerAsCell(inTableView tableView: UITableView) {
        switch self {
        case .Class(let cellClass, let identifier):
            tableView.registerClass(cellClass, forCellReuseIdentifier: identifier)
        case .Nib(let nibName, let identifier):
            tableView.registerNib(UINib(nibName: nibName, bundle: nil), forCellReuseIdentifier: identifier)
        }
    }
    
    func registerAsHeaderFooter(inTableView tableView: UITableView) {
        switch self {
        case .Class(let headerFooterClass, let identifier):
            tableView.registerClass(headerFooterClass, forHeaderFooterViewReuseIdentifier: identifier)
        case .Nib(let nibName, let identifier):
            tableView.registerNib(UINib(nibName: nibName, bundle: nil), forHeaderFooterViewReuseIdentifier: identifier)
        }
    }
}

public func ==(lhs: TableReusableViewType, rhs: TableReusableViewType) -> Bool {
    switch (lhs, rhs) {
    case (let .Class(cellClass1, identifier1), let .Class(cellClass2, indentifier2)):
        return cellClass1 == cellClass2 && identifier1 == indentifier2
        
    case (let .Nib(nibName1, identifier1), let .Nib(nibName2, identifier2)):
        return nibName1 == nibName2 && identifier1 == identifier2
    default:
        return false
    }
}