//
//  ContainerValueTests.swift
//  ReaktiveBoarTests
//
//  Created by Peter Ovchinnikov on 3/18/19.
//  Copyright © 2019 Peter Ovchinnikov. All rights reserved.
//

import Quick
import Nimble
import Swinject
@testable import ReaktiveBoar

class ContainerValue {
}

class ContainerValueSpec: QuickSpec {
    override func spec() {

        describe("Container + value") {
            it("should return provided value") {
                let value = ContainerValue()
                let container = Container()
                container.register(value: value)

                expect(container.resolve(ContainerValue.self))
                    .to(be(value))
            }
        }
    }
}
