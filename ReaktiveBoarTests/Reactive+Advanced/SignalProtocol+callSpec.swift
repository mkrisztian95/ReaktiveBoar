//
//  SignalProtocol+callSpec.swift
//  ReaktiveBoarTests
//
//  Created by Peter Ovchinnikov on 3/18/19.
//  Copyright © 2019 Peter Ovchinnikov. All rights reserved.
//

// swiftlint:disable function_body_length

import Quick
import Nimble
import ReactiveKit
import BrightFutures
@testable import ReaktiveBoar

class SignalProtocolCallSpec: QuickSpec {
    override func spec() {

        describe("SignalProtocol + call") {

            it("should wait until future is resolved") {
                let signal = SafeSignal(sequence: [1, 2])

                let working = Property(false)
                let result = Property("")
                let bag = DisposeBag()
                waitUntil(timeout: 2) { done in
                    signal
                        .call(working: working, result: result) {
                            return Future<String, NSError>(value: "String \($0)", delay: .seconds(1))
                                .onSuccess {_ in done() }
                    }.dispose(in: bag)
                }
                expect(result.value).toEventually(equal("String 1"))
                expect(working.value).toEventually(beFalse())
            }
            it("should wait until future is resolved") {
                let signal = SafeSignal(sequence: [1, 2])

                let bag = DisposeBag()
                waitUntil(timeout: 2) { done in
                    signal
                        .call {
                            return Future<String, NSError>(value: "String \($0)", delay: .seconds(1))
                                .onSuccess {_ in done() }
                        }.dispose(in: bag)
                }
            }
        }

        describe("SignalProtocol<Void> + call") {

            it("should wait until future is resolved") {
                let signal = SafeSignal<Void>(sequence: [(), ()])

                let working = Property(false)
                let result = Property("")
                let bag = DisposeBag()
                waitUntil(timeout: 2) { done in
                    signal
                        .call(working: working, result: result) {
                            return Future<String, NSError>(value: "String", delay: .seconds(1))
                                .onSuccess {_ in done() }
                        }.dispose(in: bag)
                }
                expect(result.value).toEventually(equal("String"))
                expect(working.value).toEventually(beFalse())
            }

            it("should wait until future is resolved") {
                let signal = SafeSignal<Void>(sequence: [(), ()])
                let bag = DisposeBag()
                waitUntil(timeout: 2) { done in
                    signal
                        .call {
                            return Future<String, NSError>(value: "String", delay: .seconds(1))
                                .onSuccess {_ in done() }
                        }.dispose(in: bag)
                }
            }
        }
    }
}
