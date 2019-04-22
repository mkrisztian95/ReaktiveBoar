//
//  UIView+ReactiveSpec.swift
//  ReaktiveBoarTests
//
//  Created by Peter Ovchinnikov on 3/22/19.
//  Copyright © 2019 Peter Ovchinnikov. All rights reserved.
//

import Quick
import Nimble
import ReaktiveBoar
import ReactiveKit

class TestView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    var endEditingForce: Bool?

    override func endEditing(_ force: Bool) -> Bool {
        endEditingForce = force
        return true
    }
}

class UIViewReactiveSpec: QuickSpec {
    override func spec() {
        describe("UIView+Reactive") {
            var view: TestView!
            let frame = CGRect(x: 10, y: 10, width: 20, height: 20)
            beforeEach {
                view = TestView(frame: frame)

            }
            describe("reactive.frame") {
                it("should send exactly frame on creation") {
                    view.reactive.frame.expectNext([frame])
                }
            }

            describe("reactive.bounds") {
                it("should send bound based on frame's size") {
                    view.reactive.bounds.expectNext([CGRect(x: 0,
                                                           y: 0,
                                                           width: frame.width,
                                                           height: frame.height )])
                }
            }

            describe("reactive.borderColor") {
                it("should be applied to value") {
                    SafeSignal(just: UIColor.red).bind(to: view.reactive.borderColor)
                    expect(view.layer.borderColor).to(equal(UIColor.red.cgColor))
                }
            }
            describe("reactive.borderWidth") {
                it("should be applied to value") {
                    SafeSignal(just: 5).bind(to: view.reactive.borderWidth)
                    expect(view.layer.borderWidth).to(equal(5))
                }
            }

            describe("reactive.semanticContentAttribute") {
                it("should be applied to value") {
                    SafeSignal(just: UISemanticContentAttribute.forceRightToLeft)
                        .bind(to: view.reactive.semanticContentAttribute)
                    expect(view.semanticContentAttribute)
                        .to(equal(UISemanticContentAttribute.forceRightToLeft))
                }
            }

            describe("reactive.endEditing") {
                it("should force end editing") {
                    SafeSignal<Void>(just: ())
                        .bind(to: view.reactive.endEditing(true))

                    expect(view.endEditingForce)
                        .to(equal(true))
                }
                it("should lightly end editing") {
                    SafeSignal<Void>(just: ())
                        .bind(to: view.reactive.endEditing(false))

                    expect(view.endEditingForce)
                        .to(equal(false))
                }
            }
        }
    }
}
