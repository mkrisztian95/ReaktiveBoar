//
//  UIScrollView+Animations.swift
//  ReaktiveBoar
//
//  Created by Peter Ovchinnikov on 4/1/19.
//  Copyright © 2019 Peter Ovchinnikov. All rights reserved.
//

import ReactiveKit
import Bond

public extension ReactiveExtensions where Self.Base: UIView {

    /// Creates a bond on the receiver.
    func bondAnim<Element>(duration: TimeInterval = 0.3,
                           options: UIView.AnimationOptions,
                           completion: ((Bool) -> Void)? = nil,
                           setter: @escaping (Self.Base, Element) -> Void) -> Bond<Element> {
        return bond { ctrl, value in
            ctrl.layer.removeAllAnimations()
            UIView.animate(withDuration:
                duration, delay: 0,
                          options: options,
                          animations: { setter( ctrl, value ) }, completion: completion)
        }
    }
}

public extension ReactiveExtensions where Base: UIScrollView {
    func contentOffsetAnim(duration: TimeInterval = 0.3,
                           options: UIView.AnimationOptions,
                           completion: ((Bool) -> Void)? = nil)->Bond<CGPoint> {
        return bondAnim(duration: duration,
                        options: options,
                        completion: completion) { ctrl, value in
                            ctrl.contentOffset = value
        }
    }
}
