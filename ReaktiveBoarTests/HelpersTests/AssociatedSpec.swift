//
//  AssociatedSpec.swift
//  ReaktiveBoarTests
//
//  Created by Peter Ovchinnikov on 3/21/19.
//  Copyright © 2019 Peter Ovchinnikov. All rights reserved.
//

import Quick
import Nimble
@testable import ReaktiveBoar

class AssociatedValue {
    init() { }
}

class AssociatedClass {

}

extension AssociatedClass {
    static var valueKey = ""
    var value: AssociatedValue {
        get {
            return Associated<AssociatedClass, AssociatedValue>(self, &AssociatedClass.valueKey)
                .value { AssociatedValue() }
        }
        set {
            Associated<AssociatedClass, AssociatedValue>(self, &AssociatedClass.valueKey)
                .value(new: newValue)
        }
    }

    static var optionalValueKey = ""
    var optionalValue: AssociatedValue? {
        get {
            return Associated<AssociatedClass, AssociatedValue?>(self, &AssociatedClass.optionalValueKey)
                .value()
        }
        set {
            Associated<AssociatedClass, AssociatedValue?>(self, &AssociatedClass.optionalValueKey)
                .value(new: newValue)
        }
    }
}

class AssociatedSpec: QuickSpec {
    override func spec() {

        describe("Associated") {
            var object: AssociatedClass!
            beforeEach {
                object = AssociatedClass()
            }
            describe("Value") {
                it("should return initial value by default") {
                    expect(object.value).notTo(beNil())
                }
                it("should return assigned object") {
                    let newValue = AssociatedValue()
                    object.value = newValue
                    expect(object.value).to(be(newValue))
                }
            }

            describe("Optional Value") {
                it("should return initial value by default") {
                    expect(object.optionalValue).to(beNil())
                }
                it("should return assigned object") {
                    let newValue = AssociatedValue()
                    object.optionalValue = newValue
                    expect(object.optionalValue).to(be(newValue))
                    object.optionalValue = nil
                    expect(object.optionalValue).to(beNil())
                }
            }

        }
    }
}
