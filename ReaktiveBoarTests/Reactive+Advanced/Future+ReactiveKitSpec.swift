//
//  Future+ReactiveKitSpec.swift
//  ReaktiveBoarTests
//
//  Created by Peter Ovchinnikov on 3/21/19.
//  Copyright © 2019 Peter Ovchinnikov. All rights reserved.
//

import Quick
import Nimble
import BrightFutures
import ReactiveKit
@testable import ReaktiveBoar

class FutureReactiveKitSpec: QuickSpec {
    override func spec() {
        describe("Future + Signal Integration") {
            it("Should be convertible to signal") {

                Future<String, TestError>(value: "result").sig { "start" }
                    .expectNext(["result"],
                                expectation: QuickSpec.current
                                    .expectation(description: "For success"))

                Future<String, TestError>(error: TestError.error).sig { "start" }
                    .expect([.failed(.error) ],
                            expectation: QuickSpec.current
                                .expectation(description: "For error"))

                QuickSpec.current.waitForExpectations(timeout: 2, handler: nil)
            }

            it("Should be convertible to Property.") {

                Future<String, TestError>(value: "result").val
                    .expectNext([nil, "result"],
                                expectation: QuickSpec.current
                                    .expectation(description: "For success"))

                Future<String, TestError>(error: .error).val
                    .expectNext([nil],
                                expectation: QuickSpec.current
                                    .expectation(description: "For error"))

                QuickSpec.current.waitForExpectations(timeout: 2, handler: nil)
            }
        }
    }
}
