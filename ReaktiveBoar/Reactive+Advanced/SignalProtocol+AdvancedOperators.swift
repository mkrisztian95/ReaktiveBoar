//
//  SignalProtocol+AdvancedOperators.swift
//  ReaktiveBoar
//
//  Created by Peter Ovchinnikov on 3/22/19.
//  Copyright © 2019 Peter Ovchinnikov. All rights reserved.
//

import ReactiveKit
public extension SignalProtocol where Element: OptionalProtocol {

    func recoverNil(_ def: @autoclosure @escaping ()->Element.Wrapped)-> Signal<Element.Wrapped, Error> {
        return self.map { $0._unbox ?? def() }
    }
}
