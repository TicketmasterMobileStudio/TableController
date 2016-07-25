//
//  TableReusableViewType.swift
//  LiveNation
//
//  Created by Carmen Cerino on 2/2/16.
//  Copyright © 2016 Live Nation Entertainment. All rights reserved.
//

import Foundation
import UIKit

/// A enum to encapsulate the different types of `UITableViewCells`
/// that can be registered with a `UITableView`

public enum TableReusableViewType: Hashable {
    case Nib(nibName: String, identifier: String)
    case Class(viewClass: AnyClass, identifier: String)
    
    public var hashValue: Int {
        return self.identifer.hashValue
    }
    
    var identifer: String {
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
            tableView.registerClass(headerFooterClass, forHeaderFooterViewReuseIdentifier: identifer)
        case .Nib(let nibName, let identifier):
            tableView.registerNib(UINib(nibName: nibName, bundle: nil), forHeaderFooterViewReuseIdentifier: identifer)
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