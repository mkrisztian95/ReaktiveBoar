//
//  SimpleSignalabe.swift
//  ReaktiveBoar
//
//  Created by Peter Ovchinnikov on 4/6/19.
//  Copyright © 2019 Peter Ovchinnikov. All rights reserved.
//

import ReactiveKit
import Bond

public protocol SimpleSignalable {
    associatedtype Type1: SimpleSignalable
    func s()->SafeSignal<Type1>
    func os()->SafeSignal<Type1?>
}

extension SimpleSignalable {
    public func s()->SafeSignal<Self> {
        return SafeSignal<Self>(just: self)
    }
    public func os()->SafeSignal<Self?> {
        return SafeSignal<Self?>(just: self)
    }
}

extension Bool: SimpleSignalable { }
extension String: SimpleSignalable { }
extension Int: SimpleSignalable { }
extension Date: SimpleSignalable { }
extension TimeZone: SimpleSignalable { }
extension UIColor: SimpleSignalable { }
extension UIImage: SimpleSignalable { }
extension Array: SimpleSignalable { }
