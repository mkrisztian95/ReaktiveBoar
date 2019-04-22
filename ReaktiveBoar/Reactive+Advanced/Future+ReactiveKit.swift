//
//  Future+ReactiveKit.swift
//  ReaktiveBoarTests
//
//  Created by Peter Ovchinnikov on 3/20/19.
//  Copyright © 2019 Peter Ovchinnikov. All rights reserved.
//

import BrightFutures
import ReactiveKit

public extension Future {

    var val: Property<T?> {
        let prop = Property<T?>(nil)
        self.onSuccess { prop.next($0) }
        return prop
    }

    func sig(init: (() -> T)? = nil) -> Signal<T, E> {
        return Signal { observer in
            if !self.isCompleted {
                if let  `init` = `init` {
                    observer.next(`init`())
                }
            }

            self.onSuccess { observer.completed(with: $0) }
            self.onFailure { observer.failed($0) }
            return observer.disposable
        }
    }
}
