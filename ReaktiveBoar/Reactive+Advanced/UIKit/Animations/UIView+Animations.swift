//
//  UIView+Animations.swift
//  ReaktiveBoar
//
//  Created by Peter Ovchinnikov on 4/9/19.
//  Copyright © 2019 Peter Ovchinnikov. All rights reserved.
//

import ReactiveKit
import Bond

public extension ReactiveExtensions where Base: UIView {
    func alphaAnim(duration: TimeInterval = 0.3,
                   options: UIView.AnimationOptions,
                   completion: ((Bool) -> Void)? = nil)->Bond<CGFloat> {
        return bondAnim(duration: duration,
                        options: options,
                        completion: completion) { ctrl, value in
                            ctrl.alpha = value
        }
    }
}
