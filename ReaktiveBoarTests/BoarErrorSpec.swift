//
//  BoarErrorSpec.swift
//  ReaktiveBoarTests
//
//  Created by Peter Ovchinnikov on 3/21/19.
//  Copyright © 2019 Peter Ovchinnikov. All rights reserved.
//

import Quick
import Nimble
@testable import ReaktiveBoar

class BoarErrorSpec: QuickSpec {
    override func spec() {
        describe("BoarError") {
            it("Should create an error") {
                let error = BoarError.err(100)
                expect(error.code).to(equal(100))
            }
        }

    }
}
