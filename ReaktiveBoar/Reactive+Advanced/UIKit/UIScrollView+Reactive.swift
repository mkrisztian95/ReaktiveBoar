//
//  UIScrollView+Reactive.swift
//  ReaktiveBoar
//
//  Created by Peter Ovchinnikov on 3/27/19.
//  Copyright © 2019 Peter Ovchinnikov. All rights reserved.
//

import ReactiveKit
import Bond

public extension ReactiveExtensions where Base: UIScrollView {

    var delegate: ProtocolProxy {
        return protocolProxy(for: UIScrollViewDelegate.self, keyPath: \.delegate)
    }

    var contentSize: SafeSignal<CGSize> {
        return keyPath(\.contentSize)
    }

    func contentInset(_ f: (() -> Void )? = nil)-> Bond<UIEdgeInsets> {
        return bond { ctrl, value in
            ctrl.contentInset = value
            f?()
        }
    }

    func contentInset<T: AnyObject>(weak ctx: T, _ f: @escaping ((T) -> Void ))->Bond<UIEdgeInsets> {
        weak var weak: T? = ctx
        return bond { ctrl, value in
            ctrl.contentInset = value
            if let strong = weak {
                f(strong)
            }
        }
    }
    func contentInset<T>(strong ctx: T, _ f: @escaping ((T) -> Void ))->Bond<UIEdgeInsets> {
        return bond { ctrl, value in
            ctrl.contentInset = value
            f(ctx)
        }
    }

    var contentOffset: DynamicSubject<CGPoint> {
        let signal = keyPath(\.contentOffset)
        return self.dynamicSubject(signal: signal.eraseType(),
                                   get: { $0.contentOffset },
                                   set: { $0.setContentOffset($1, animated: true) })
    }
    var isScrollEnabled: DynamicSubject<Bool> {
        let signal = keyPath(\.isScrollEnabled)
        return self.dynamicSubject(signal: signal.eraseType(),
                                   get: { $0.isScrollEnabled },
                                   set: { $0.isScrollEnabled = $1 })
    }

    var scrollViewWillEndDragging: SafeSignal<UnsafeMutablePointer<CGPoint>> {

        //swiftlint:disable:next line_length
        let subjectDispatcher = { (subject: SafePublishSubject< UnsafeMutablePointer<CGPoint>>, _: UIScrollView, _: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) in
            subject.next(targetContentOffset)
        }

        let selector = #selector(UIScrollViewDelegate.scrollViewWillEndDragging(_:withVelocity:targetContentOffset:))

        return delegate
            .signal(for: selector, dispatch: subjectDispatcher )
    }
}
