//
//  IDVMTests.swift
//  ReaktiveBoarTests
//
//  Created by Peter Ovchinnikov on 3/12/19.
//  Copyright © 2019 Peter Ovchinnikov. All rights reserved.
//

import XCTest
@testable import ReaktiveBoar

class IDVMTests: XCTestCase {

    func testEquality() {
        let one1 = IDVM(id: "one")
        let one2 = IDVM(id: "one")
        let two = IDVM(id: "two")

        XCTAssertTrue(one1 == one2)
        XCTAssertFalse(one1 == two)

        XCTAssertEqual(one1, one2)
        XCTAssertNotEqual(one1, two)
    }

    func testIsEqual() {
        let one1 = IDVM(id: "one")
        let one2 = IDVM(id: "one")
        let two = IDVM(id: "two")

        XCTAssertTrue(one1.isEqual(one2))

        XCTAssertFalse(one1.isEqual("one"))

        XCTAssertFalse(one1.isEqual(two))
        XCTAssertFalse(one1.isEqual(nil))
        XCTAssertFalse(one1.isEqual(10))
    }

    func testStringIdentifieble() {
        XCTAssertEqual("one".id, "one")
    }

    func testUUIDIdentifieble() {
        let uuid = UUID()
        XCTAssertEqual(uuid.id, uuid.uuidString)
    }
    struct TestIdentifiable: Identifiable, Equatable {
        let id: String
    }

    func testIdentifiable() {
        let one = TestIdentifiable(id: "one")
        let two = TestIdentifiable(id: "two")
        let one1 = TestIdentifiable(id: "one")
        XCTAssertFalse(two == one)
        XCTAssertTrue(one1 == one)

        XCTAssertNotEqual(two, one)
        XCTAssertEqual(one1, one)
    }

}
