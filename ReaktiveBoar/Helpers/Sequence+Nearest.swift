//
//  Sequence+Nearest.swift
//  ReaktiveBoar
//
//  Created by Peter Ovchinnikov on 4/13/19.
//  Copyright © 2019 Peter Ovchinnikov. All rights reserved.
//

public extension Sequence {
    func nearest<T>(_ distanceTo: (Element) -> T) -> (Element)? where T: Comparable {

        let first: (T, (Element))? = nil

        let res = self.reduce( first ) { max, item in
            let dist = distanceTo(item)
            guard let max = max else {
                return (dist, item)
            }
            if dist < max.0 {
                return (dist, item)
            }
            return max
        }
        return res?.1
    }
}

public extension Comparable {
    static func compare(_ left: Self, _ right: Self) -> Int {
        if left == right {
            return 0
        }
        return left < right ? -1 : 1
    }
}
