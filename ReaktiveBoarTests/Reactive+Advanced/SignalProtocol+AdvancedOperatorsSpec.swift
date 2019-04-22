//
//  SignalProtocol+AdvancedOperatorsSpec.swift
//  ReaktiveBoarTests
//
//  Created by Peter Ovchinnikov on 3/22/19.
//  Copyright © 2019 Peter Ovchinnikov. All rights reserved.
//

import Quick
import Nimble
import ReactiveKit
import ReaktiveBoar

class SignalProtocolAdvancedOperatorsSpec: QuickSpec {
    override func spec() {
        describe("SignalProtocol") {
            describe("reoverNil") {
                it("should convert to recovering value if nil") {
                    //QuickSpec.current.expectation(description: "Observing")
                    SafeSignal<String?>(just: nil).recoverNil("default")
                        .expectNext(["default"])
                    //QuickSpec.current.waitForExpectations(timeout: 1, handler: nil)
                }
                it("shouldn't convert to recovering value if not nil") {
                    //QuickSpec.current.expectation(description: "Observing")
                    SafeSignal<String?>(just: "value").recoverNil("default")
                        .expectNext(["value"])
                    //QuickSpec.current.waitForExpectations(timeout: 1, handler: nil)
                }
            }
        }
    }
}
