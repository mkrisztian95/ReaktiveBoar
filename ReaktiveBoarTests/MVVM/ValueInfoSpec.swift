//
//  ValueInfoSpec.swift
//  ReaktiveBoarTests
//
//  Created by Peter Ovchinnikov on 3/18/19.
//  Copyright © 2019 Peter Ovchinnikov. All rights reserved.
//

import Quick
import Nimble

@testable import ReaktiveBoar

class ValueInfoSpec: QuickSpec {
    override func spec() {

        describe("a ValueInfo") {
            it("should evaluate the value exactly as provided if constant") {
                let valueInfo = ValueInfo.const(100)
                expect(valueInfo.value(from: 200))
                    .to(equal(100))
            }
            it("should evaluate the value as value*percent if percent") {
                let valueInfo = ValueInfo.percent(0.75)
                expect(valueInfo.value(from: 200))
                    .to(equal(150))
            }

            it("should evaluate the value as value/denominator if .denom") {
                let valueInfo = ValueInfo.denom(num: 2)
                expect(valueInfo.value(from: 200))
                    .to(equal(100))
            }

            it("should evaluate the value minus offset as value if full") {
                let valueInfo = ValueInfo.full(offset: 10)
                expect(valueInfo.value(from: 200))
                    .to(equal(190))
            }

            it("should raise fatalError if equal") {
                let valueInfo = ValueInfo.equal
                expect { _ = valueInfo.value(from: 200) }
                    .to(throwAssertion())
            }

        }
    }
}
