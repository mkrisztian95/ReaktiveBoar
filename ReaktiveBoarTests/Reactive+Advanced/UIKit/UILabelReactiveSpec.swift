//
//  UILabelReactiveSpec.swift
//  ReaktiveBoarTests
//
//  Created by Peter Ovchinnikov on 3/22/19.
//  Copyright © 2019 Peter Ovchinnikov. All rights reserved.
//

import Quick
import Nimble
import ReaktiveBoar
import ReactiveKit

class UILabelReactiveSpec: QuickSpec {
    override func spec() {
        describe("UILabel+Reactive") {
            var label: UILabel!
            let frame = CGRect(x: 10, y: 10, width: 20, height: 20)
            beforeEach {
                label = UILabel(frame: frame)
            }
            describe("reactive.font") {
                it("should be applied to value") {
                    let font = UIFont.systemFont(ofSize: 30)
                    SafeSignal(just: font)
                        .bind(to: label.reactive.font)
                    expect(label.font).to(be(font))

                }
            }

            describe("reactive.numberOfLines") {
                it("should be applied to value") {
                    let numberOfLines = 5
                    SafeSignal(just: numberOfLines)
                        .bind(to: label.reactive.numberOfLines)
                    expect(label.numberOfLines).to(equal(numberOfLines))

                }
            }
        }
    }
}
