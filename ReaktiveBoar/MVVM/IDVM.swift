//
//  IDVM.swift
//  ReaktiveBoar
//
//  Created by Peter Ovchinnikov on 3/12/19.
//  Copyright © 2019 Peter Ovchinnikov. All rights reserved.
//

import Foundation

public protocol Identifiable {
    var id: String { get }
}

func ==<T: Identifiable>(lhs: T, rhs: T) -> Bool {
    return lhs.id == rhs.id
}

extension UUID: Identifiable {
    public var id: String { return uuidString }
}

extension String: Identifiable {
    public var id: String {
        return self
    }
}

open class IDVM: VM, Identifiable {
    open var id = ""
    override open func isEqual(_ object: Any?) -> Bool {
        guard let obj = object as? IDVM else {
            return false
        }
        return obj.id == id
    }
    public init<T: Identifiable>(id: T) {
        self.id = id.id
    }
}
