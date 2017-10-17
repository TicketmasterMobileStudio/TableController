//
//  Array+Helpers.swift
//  TableController
//
//  Created by Duncan Lewis on 8/14/17.
//  Copyright © 2017 Duncan Lewis. All rights reserved.
//

import Foundation


extension Array where Element == IndexPath {

    var rowsGroupedBySection: [Int:[Int]] {
        return self.reduce([Int:[Int]]()) { (previous, indexPath) -> [Int:[Int]] in
            var indexPaths = previous[indexPath.section] ?? [Int]()
            indexPaths.append(indexPath.row)

            var mutable = previous
            mutable[indexPath.section] = indexPaths
            return mutable
        }
    }

}
