//
//  Sleep.swift
//  ReaktiveBoarTests
//
//  Created by Peter Ovchinnikov on 3/28/19.
//  Copyright © 2019 Peter Ovchinnikov. All rights reserved.
//

import Quick
import Nimble
import BrightFutures
import ReactiveKit

func justSleep(_ timeout: DispatchTimeInterval, file: FileString = #file, line: UInt = #line) {
    waitUntil(timeout: timeout.toDouble() + 1, file: file, line: line) { done in
        Future<Void, Never>(value: (), delay: timeout).onSuccess(callback: done)
    }
}

extension DispatchTimeInterval {
    func toDouble() -> Double {
        var result: Double

        switch self {
        case .seconds(let value):
            result = Double(value)
        case .milliseconds(let value):
            result = Double(value)*0.001
        case .microseconds(let value):
            result = Double(value)*0.000001
        case .nanoseconds(let value):
            result = Double(value)*0.000000001

        case .never:
            result = 0
        default:
            fatalError()
        }

        return result
    }
}
