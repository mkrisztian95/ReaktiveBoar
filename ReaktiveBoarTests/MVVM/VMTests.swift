//
//  VMTests.swift
//  ReaktiveBoarTests
//
//  Created by Peter Ovchinnikov on 3/12/19.
//  Copyright © 2019 Peter Ovchinnikov. All rights reserved.
//

import XCTest
@testable import ReaktiveBoar

class VMTests: XCTestCase {

    func testVM() {
        let vm = VM()
        XCTAssertEqual("VM", vm.className)
        XCTAssertEqual("VM", VM.className)
    }
}
