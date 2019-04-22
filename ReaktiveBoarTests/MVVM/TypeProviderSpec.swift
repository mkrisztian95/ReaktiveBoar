//
//  TypeProviderSpec.swift
//  ReaktiveBoarTests
//
//  Created by Peter Ovchinnikov on 3/18/19.
//  Copyright © 2019 Peter Ovchinnikov. All rights reserved.
//

import Quick
import Nimble

@testable import ReaktiveBoar

class TypeProvider: TypeProviderProtocol {

}

struct NonTypeProvider {

}

class TypeProviderSpec: QuickSpec {
    override func spec() {

        describe("TypeProvider protocol") {
            it("should provide className and T.className and they're equal") {
                let typeProvider = TypeProvider()
                expect(typeProvider.className).to(equal(TypeProvider.className))
            }
        }

        describe("className(data:)") {
            it("should use className if it's a TypeProviderProtocol") {
                let typeProvider = TypeProvider()
                expect(className(data: typeProvider)).to(equal(typeProvider.className))
            }
            it("should use type(of:) if it's not TypeProviderProtocol") {
                let typeProvider = NonTypeProvider()
                expect(className(data: typeProvider)).to(equal("NonTypeProvider"))
            }
        }

        describe("className(type:)") {
            it("should use className if it's a TypeProviderProtocol") {
                expect(className(type: TypeProvider.self)).to(equal(TypeProvider.className))
            }
            it("should use type(of:) if it's not TypeProviderProtocol") {
                expect(className(type: NonTypeProvider.self)).to(equal("NonTypeProvider"))
            }
        }
    }
}
