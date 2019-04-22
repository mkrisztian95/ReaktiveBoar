//
//  SizeInfoSpec.swift
//  ReaktiveBoarTests
//
//  Created by Peter Ovchinnikov on 3/18/19.
//  Copyright © 2019 Peter Ovchinnikov. All rights reserved.
//

import Quick
import Nimble

@testable import ReaktiveBoar

class SizeInfoSpec: QuickSpec {
    override func spec() {

        describe("a SizeInfo") {
            it("should evaluate width and height if both are strictly provided") {
                let sizeInfo = SizeInfo(width: .const(100), height: .const(200))
                expect(sizeInfo.size(from: CGSize(width: 500, height: 400)))
                    .to(equal(CGSize(width: 100, height: 200)))

            }

            it("should evaluate width=height if height is provided and width is equal") {
                let sizeInfo = SizeInfo(width: .equal, height: .const(200))
                expect(sizeInfo.size(from: CGSize(width: 500, height: 400)))
                    .to(equal(CGSize(width: 200, height: 200)))

            }

            it("should evaluate height=width if widht is provided and height is equal") {
                let sizeInfo = SizeInfo(width: .const(100), height: .equal)
                expect(sizeInfo.size(from: CGSize(width: 500, height: 400)))
                    .to(equal(CGSize(width: 100, height: 100)))

            }

            it("should raise fatalError if both are equal") {
                let sizeInfo = SizeInfo(width: .equal, height: .equal)
                expect { _ = sizeInfo.size(from: CGSize(width: 500, height: 400)) }
                    .to(throwAssertion())
            }

            it("should call custom evaluator if .custom") {
                let sizeInfo = SizeInfo { _ in return CGSize(width: 120, height: 210) }
                expect(sizeInfo.size(from: CGSize(width: 500, height: 400)))
                    .to(equal(CGSize(width: 120, height: 210)))
            }
        }
    }
}
