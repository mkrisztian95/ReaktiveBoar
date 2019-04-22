//
//  Value.swift
//  ReaktiveBoar
//
//  Created by Peter Ovchinnikov on 3/12/19.
//  Copyright © 2019 Peter Ovchinnikov. All rights reserved.
//

import ReactiveKit
public class Value<T> {
    var value: T? {
        return nil
    }
}
class WeakValue<T: AnyObject>: Value<T> {
    weak var val: T?
    init(_ value: T) {
        self.val = value
    }
    override var value: T? {
        return val
    }
}

class StrongValue<T>: Value<T> {
    let val: T
    init(_ value: T) {
        self.val = value
    }
    override var value: T? {
        return val
    }
}

class PropValue<U: PropertyProtocol>: Value<U.ProperyElement> {
    let val: U
    init(_ value: U) {
        self.val = value
    }
    override var value: U.ProperyElement? {
        return val.value
    }
}

class LatestValue<T>: Value<T> {
    var val: T?
    let bag = DisposeBag()
    init<U: SignalProtocol>(_ signal: U) where U.Element == T {
        super.init()
        signal.observeNext { [weak self] value in
            self?.val = value
            }.dispose(in: bag)
    }
    override var value: T? {
        return val
    }
}

public extension Value where T: AnyObject {
    static func weak(_ value: T)->Value<T> {
        return WeakValue<T>(value)
    }
}

public extension Value {
    static func strong(_ value: T)->Value<T> {
        return StrongValue<T>(value)
    }
    static func latest<U: SignalProtocol>(_ signal: U)->Value<T> where U.Element == T {
        return LatestValue<T>(signal)
    }
    static func prop<U: PropertyProtocol>(_ prop: U)->Value<U.ProperyElement> {
        return PropValue(prop)
    }

    static func val<U: PropertyProtocol>(_ prop: U)->Value<U.ProperyElement> {
        return Value.prop(prop)
    }
}
