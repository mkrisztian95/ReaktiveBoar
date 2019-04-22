//
//  ValueTests.swift
//  ReaktiveBoarTests
//
//  Created by Peter Ovchinnikov on 3/12/19.
//  Copyright © 2019 Peter Ovchinnikov. All rights reserved.
//

import Foundation

import XCTest
import ReactiveKit
@testable import ReaktiveBoar

class SimpleClass {

}

class ValueTests: XCTestCase {

    func testValue() {
        XCTAssertNil(Value<String>().value, "It should always be nil")
    }

    func testWeakValue() {

        var weak: Value<SimpleClass>?
        let f = {
            let value = SimpleClass()
            weak = Value.weak(value)
            XCTAssertNotNil(weak!.value, "It should keep value inside the scope")
        }
        f()
        XCTAssertNil(weak!.value, "It should release value outside the scope")
    }

    func testStrongValue() {

        var strong: Value<SimpleClass>?
        let f = {
            let value = SimpleClass()
            strong = Value.strong(value)
            XCTAssertNotNil(strong!.value, "It should keep value inside the scope")
        }
        f()
        XCTAssertNotNil(strong!.value, "It should keep value even outside the scope")
    }

    func testPropertyValue() {

        var property: Value<String>?
        let f = {
            let value = Property("Old Value")
            property = Value<String>.val(value)
            XCTAssertEqual("Old Value", property!.value, "Ok. Getting current value")
            value.next("New Value")
        }
        f()
        XCTAssertEqual("New Value", property!.value, "New value is avaliable event out of scope")
    }

    func testLatestValue() {

        var latest: Value<String>?
        let f = {
            let signal = SafePublishSubject<String>()
            latest = Value<String>.latest(signal)
            XCTAssertNil(latest!.value, "There's no value yet")
            signal.next("Old Value")
            XCTAssertEqual("Old Value", latest!.value, "Ok. Getting current value")
            signal.next("New Value")
        }
        f()
        XCTAssertEqual("New Value", latest!.value, "New value is avaliable event out of scope")
}
}
