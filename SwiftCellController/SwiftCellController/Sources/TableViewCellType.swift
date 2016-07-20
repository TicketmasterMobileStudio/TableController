//
//  TableViewCellType.swift
//  LiveNation
//
//  Created by Carmen Cerino on 2/2/16.
//  Copyright © 2016 Live Nation Entertainment. All rights reserved.
//

import Foundation
import UIKit

/// A enum to encapsulate the different types of `UITableViewCells`
/// that can be registered with a `UITableView`

public enum RegisterableCellType: Hashable {
    case Nib(nibName: String, identifier: String)
    case Class(cellClass: AnyClass, identifier: String)
    
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
    
    func register(inTableView tableView: UITableView) {
        switch self {
        case .Class(let cellClass, let identifier):
            tableView.registerClass(cellClass, forCellReuseIdentifier: identifier)
        case .Nib(let nibName, let identifier):
            tableView.registerNib(UINib(nibName: nibName, bundle: nil), forCellReuseIdentifier: identifier)
        }
    }
}

public func ==(lhs: RegisterableCellType, rhs: RegisterableCellType) -> Bool {
    switch (lhs, rhs) {
    case (let .Class(cellClass1, identifier1), let .Class(cellClass2, indentifier2)):
        return cellClass1 == cellClass2 && identifier1 == indentifier2
        
    case (let .Nib(nibName1, identifier1), let .Nib(nibName2, identifier2)):
        return nibName1 == nibName2 && identifier1 == identifier2
    default:
        return false
    }
}