//
//  SignalProtocol+call.swift
//  ReaktiveBoar
//
//  Created by Peter Ovchinnikov on 3/13/19.
//  Copyright © 2019 Peter Ovchinnikov. All rights reserved.
//

// swiftlint:disable line_length

import ReactiveKit
import BrightFutures

extension SignalProtocol {

    public func call<T>(future: @escaping (Element)->Future<T, NSError> ) -> Disposable {
        return call(working: SafePublishSubject<Bool>(),
                    result: SafePublishSubject<T>(),
                    future: future)
    }

    public func call<T,
        S: ObserverProtocol,
        R: ObserverProtocol>(working: S,
                             result: R,
                             future: @escaping (Element)->Future<T, NSError>) -> Disposable where S.Element == Bool, R.Element == T, R.Error == Never {
        var working1 = false
        working.next(false)
        return self.filter {_ in !working1 }.observeNext { element in
            working.next(true)
            working1 = true
            _ = future(element).onComplete {_ in
                working1 = false
                working.next(false)
                }.onSuccess(callback: result.next)
        }
    }
}

extension SignalProtocol where Element == Void {

    public func call<T>(future: @escaping ()->Future<T, NSError> ) -> Disposable {
        return call(working: SafePublishSubject<Bool>(),
                    result: SafePublishSubject<T>(),
                    future: future)
    }

    public func call<T,
        S: ObserverProtocol,
        R: ObserverProtocol>(working: S,
                             result: R,
                             future: @escaping ()->Future<T, NSError>) -> Disposable where S.Element == Bool, R.Element == T, R.Error == Never {
        var working1 = false
        working.next(false)
        return self.filter {_ in !working1 }
            .observeNext { _ in
                working.next(true)
                working1 = true
                _ = future().onComplete {_ in
                    working.next(false)
                    working1 = false
                    }.onSuccess(callback: result.next)
        }
    }
}
