//
//  Container+value.swift
//  ReaktiveBoar
//
//  Created by Peter Ovchinnikov on 3/18/19.
//  Copyright © 2019 Peter Ovchinnikov. All rights reserved.
//

import Swinject

extension Container {
    public func register<T>(value: T) {
        register(T.self) { _  -> T in
            return value
        }
    }
}
