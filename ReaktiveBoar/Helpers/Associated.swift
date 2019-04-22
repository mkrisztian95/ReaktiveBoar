//
//  Associated.swift
//  ReaktiveBoar
//
//  Created by Peter Ovchinnikov on 3/14/19.
//  Copyright © 2019 Peter Ovchinnikov. All rights reserved.
//

import ReactiveKit
public struct Associated<O, T> {

    private let key: UnsafeRawPointer
    private let object: O
    public init(_ object: O, _ key: UnsafeRawPointer) {
        self.object = object
        self.key = key
    }
}

extension Associated {
    func value(initial:() -> T) -> T {
        let anyRes = objc_getAssociatedObject(object, key) as? T
        return anyRes ?? self.value(new: initial())
    }

    @discardableResult
    public func value(new: T) -> T {
        objc_setAssociatedObject(object, key, new, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        return new
    }
}

extension Associated where T: OptionalProtocol {
    func value() -> T.Wrapped? {
        let anyRes = objc_getAssociatedObject(object, key) as? T.Wrapped
        return anyRes
    }

    @discardableResult
    public func value(new: T) -> T {
        objc_setAssociatedObject(object, key, new, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        return new
    }
}

//public func dynamicROProperty<T: AnyObject>(object: Any, _ key: UnsafeRawPointer, factory: ()->T) -> T {
//    if let result = objc_getAssociatedObject(object, key) {
//        return result as! T
//    } else {
//        let result = factory()
//        objc_setAssociatedObject(object, key, result, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
//        return result
//    }
//}

//func associated<T, O: OptionalProtocol>(_ key: UnsafeRawPointer, _ object: T) -> O {
//    return Associated<O, T>(object, key).value()
//}
//
//func associated<T, O: OptionalProtocol>(_ key: UnsafeRawPointer, _ object: T, new: O) -> O {
//    return Associated<O, T>(object, key)
//        .value(new: new)
//}
