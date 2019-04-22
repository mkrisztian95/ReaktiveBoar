//
//  NSLayoutconstraint+Reactive.swift
//  ReaktiveBoar
//
//  Created by Peter Ovchinnikov on 4/7/19.
//  Copyright © 2019 Peter Ovchinnikov. All rights reserved.
//

import ReactiveKit
import Bond

public extension ReactiveExtensions where Base: NSLayoutConstraint {
    //    var constant: Bond<CGFloat>{
    //        return self.bond(setter: { (ctrl, value) in
    //            ctrl.constant = value
    //        })
    //    }

    func constant(_ f: (() -> Void )? = nil)->Bond<CGFloat> {
        return self.bond(setter: { (ctrl, value) in
            ctrl.constant = value
            f?()
        })
    }

    func constant<T: AnyObject>(weak ctx: T, _ f: @escaping ((T) -> Void ))->Bond<CGFloat> {
        weak var weak: T? = ctx
        return self.bond(setter: { (ctrl, value) in
            ctrl.constant = value
            if let strong = weak {
                f(strong)
            }
        })
    }
    func constant<T>(strong ctx: T, _ f: @escaping ((T) -> Void ))->Bond<CGFloat> {
        return self.bond(setter: { (ctrl, value) in
            ctrl.constant = value
            f(ctx)
        })
    }
}

extension NSLayoutConstraint: BindableProtocol {

    public func bind(signal: Signal<CGFloat, Never>) -> Disposable {
        return reactive.constant().bind(signal: signal)
    }
}
