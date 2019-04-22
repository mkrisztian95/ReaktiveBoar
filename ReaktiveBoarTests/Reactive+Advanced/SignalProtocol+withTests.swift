//
//  SignalProtocol+withTests.swift
//  ReaktiveBoarTests
//
//  Created by Peter Ovchinnikov on 3/12/19.
//  Copyright © 2019 Peter Ovchinnikov. All rights reserved.
//

// swiftlint:disable file_length type_body_length

import XCTest
import ReactiveKit
@testable import ReaktiveBoar

class SignalProtocolWithTests: XCTestCase {
    func testWith1Argument() {

        Signal<Int, TestError>.failed(.error)
            .with(.strong(2)
            )
            .expect([.failed(.error)])

        Signal<Int, TestError>(just: 1)
            .with(.weak(SimpleClass())
            )
            .expectNext([])

        Signal<Int, TestError>(just: 1)
            .with(.strong(2)
            )
            .expectNext([ (1, 2) ])
    }
    func testWith2Argument() {

        Signal<Int, TestError>.failed(.error)
            .with(.strong(2),
                  .strong(3)
            )
            .expect([.failed(.error)])

        Signal<Int, TestError>(just: 1)
            .with(.weak(SimpleClass()),
                  .weak(SimpleClass())
            )
            .expectNext([])

        Signal<Int, TestError>(just: 1)
            .with(.strong(2),
                  .strong(3)
            )
            .expectNext([ (1, 2, 3) ])
    }
    func testWith3Argument() {

        Signal<Int, TestError>.failed(.error)
            .with(.strong(2),
                  .strong(3),
                  .strong(4)
            )
            .expect([.failed(.error)])

        Signal<Int, TestError>(just: 1)
            .with(.weak(SimpleClass()),
                  .weak(SimpleClass()),
                  .weak(SimpleClass())
            )
            .expectNext([])

        Signal<Int, TestError>(just: 1)
            .with(.strong(2),
                  .strong(3),
                  .strong(4)
            )
            .expectNext([ (1, 2, 3, 4) ])
    }
    func testWith4Argument() {

        Signal<Int, TestError>.failed(.error)
            .with(.strong(2),
                  .strong(3),
                  .strong(4),
                  .strong(5)
            )
            .expect([.failed(.error)])

        Signal<Int, TestError>(just: 1)
            .with(.weak(SimpleClass()),
                  .weak(SimpleClass()),
                  .weak(SimpleClass()),
                  .weak(SimpleClass())
            )
            .expectNext([])

        Signal<Int, TestError>(just: 1)
            .with(.strong(2),
                  .strong(3),
                  .strong(4),
                  .strong(5)
            )
            .expectNext([ (1, 2, 3, 4, 5) ])
    }
    func testWith5Argument() {

        Signal<Int, TestError>.failed(.error)
            .with(.strong(2),
                  .strong(3),
                  .strong(4),
                  .strong(5),
                  .strong(6)
            )
            .expect([.failed(.error)])

        Signal<Int, TestError>(just: 1)
            .with(.weak(SimpleClass()),
                  .weak(SimpleClass()),
                  .weak(SimpleClass()),
                  .weak(SimpleClass()),
                  .weak(SimpleClass())
            )
            .expectNext([])

        Signal<Int, TestError>(just: 1)
            .with(.strong(2),
                  .strong(3),
                  .strong(4),
                  .strong(5),
                  .strong(6)
            )
            .expectNext([ (1, 2, 3, 4, 5, 6) ])
    }
    func testWith6Argument() {

        Signal<Int, TestError>.failed(.error)
            .with(.strong(2),
                  .strong(3),
                  .strong(4),
                  .strong(5),
                  .strong(6),
                  .strong(7)
            )
            .expect([.failed(.error)])

        Signal<Int, TestError>(just: 1)
            .with(.weak(SimpleClass()),
                  .weak(SimpleClass()),
                  .weak(SimpleClass()),
                  .weak(SimpleClass()),
                  .weak(SimpleClass()),
                  .weak(SimpleClass())
            )
            .expectNext([])

        Signal<Int, TestError>(just: 1)
            .with(.strong(2),
                  .strong(3),
                  .strong(4),
                  .strong(5),
                  .strong(6),
                  .strong(7)
            )
            .expectNext([ (1, 2, 3, 4, 5, 6, 7) ])
    }
    func testWith7Argument() {

        Signal<Int, TestError>.failed(.error)
            .with(.strong(2),
                  .strong(3),
                  .strong(4),
                  .strong(5),
                  .strong(6),
                  .strong(7),
                  .strong(8)
            )
            .expect([.failed(.error)])

        Signal<Int, TestError>(just: 1)
            .with(.weak(SimpleClass()),
                  .weak(SimpleClass()),
                  .weak(SimpleClass()),
                  .weak(SimpleClass()),
                  .weak(SimpleClass()),
                  .weak(SimpleClass()),
                  .weak(SimpleClass())
            )
            .expectNext([])

        Signal<Int, TestError>(just: 1)
            .with(.strong(2),
                  .strong(3),
                  .strong(4),
                  .strong(5),
                  .strong(6),
                  .strong(7),
                  .strong(8)
            )
            .expectNext([ (1, 2, 3, 4, 5, 6, 7, 8) ])
    }
    func testWith8Argument() {

        Signal<Int, TestError>.failed(.error)
            .with(.strong(2),
                  .strong(3),
                  .strong(4),
                  .strong(5),
                  .strong(6),
                  .strong(7),
                  .strong(8),
                  .strong(9)
            )
            .expect([.failed(.error)])

        Signal<Int, TestError>(just: 1)
            .with(.weak(SimpleClass()),
                  .weak(SimpleClass()),
                  .weak(SimpleClass()),
                  .weak(SimpleClass()),
                  .weak(SimpleClass()),
                  .weak(SimpleClass()),
                  .weak(SimpleClass()),
                  .weak(SimpleClass())
            )
            .expectNext([])

        Signal<Int, TestError>(just: 1)
            .with(.strong(2),
                  .strong(3),
                  .strong(4),
                  .strong(5),
                  .strong(6),
                  .strong(7),
                  .strong(8),
                  .strong(9)
            )
            .expectNext([ (1, 2, 3, 4, 5, 6, 7, 8, 9) ])
    }
    func testWith9Argument() {

        Signal<Int, TestError>.failed(.error)
            .with(.strong(2),
                  .strong(3),
                  .strong(4),
                  .strong(5),
                  .strong(6),
                  .strong(7),
                  .strong(8),
                  .strong(9),
                  .strong(10)
            )
            .expect([.failed(.error)])

        Signal<Int, TestError>(just: 1)
            .with(.weak(SimpleClass()),
                  .weak(SimpleClass()),
                  .weak(SimpleClass()),
                  .weak(SimpleClass()),
                  .weak(SimpleClass()),
                  .weak(SimpleClass()),
                  .weak(SimpleClass()),
                  .weak(SimpleClass()),
                  .weak(SimpleClass())
            )
            .expectNext([])

        Signal<Int, TestError>(just: 1)
            .with(.strong(2),
                  .strong(3),
                  .strong(4),
                  .strong(5),
                  .strong(6),
                  .strong(7),
                  .strong(8),
                  .strong(9),
                  .strong(10)
            )
            .expectNext([ (1, 2, 3, 4, 5, 6, 7, 8, 9, 10) ])
    }
    func testVoidWith1Argument() {

        Signal<Void, TestError>.failed(.error)
            .with(.strong(2)
            )
            .expect([.failed(.error)])

        Signal<Void, TestError>(just: () )
            .with(.weak(SimpleClass())
            )
            .expectNext([])

        Signal<Void, TestError>(just: () )
            .with(.strong(2)
            )
            .expectNext([ (2) ])
    }
    func testVoidWith2Argument() {

        Signal<Void, TestError>.failed(.error)
            .with(.strong(2),
                  .strong(3)
            )
            .expect([.failed(.error)])

        Signal<Void, TestError>(just: () )
            .with(.weak(SimpleClass()),
                  .weak(SimpleClass())
            )
            .expectNext([])

        Signal<Void, TestError>(just: () )
            .with(.strong(2),
                  .strong(3)
            )
            .expectNext([ (2, 3) ])
    }
    func testVoidWith3Argument() {

        Signal<Void, TestError>.failed(.error)
            .with(.strong(2),
                  .strong(3),
                  .strong(4)
            )
            .expect([.failed(.error)])

        Signal<Void, TestError>(just: () )
            .with(.weak(SimpleClass()),
                  .weak(SimpleClass()),
                  .weak(SimpleClass())
            )
            .expectNext([])

        Signal<Void, TestError>(just: () )
            .with(.strong(2),
                  .strong(3),
                  .strong(4)
            )
            .expectNext([ (2, 3, 4) ])
    }
    func testVoidWith4Argument() {

        Signal<Void, TestError>.failed(.error)
            .with(.strong(2),
                  .strong(3),
                  .strong(4),
                  .strong(5)
            )
            .expect([.failed(.error)])

        Signal<Void, TestError>(just: () )
            .with(.weak(SimpleClass()),
                  .weak(SimpleClass()),
                  .weak(SimpleClass()),
                  .weak(SimpleClass())
            )
            .expectNext([])

        Signal<Void, TestError>(just: () )
            .with(.strong(2),
                  .strong(3),
                  .strong(4),
                  .strong(5)
            )
            .expectNext([ (2, 3, 4, 5) ])
    }
    func testVoidWith5Argument() {

        Signal<Void, TestError>.failed(.error)
            .with(.strong(2),
                  .strong(3),
                  .strong(4),
                  .strong(5),
                  .strong(6)
            )
            .expect([.failed(.error)])

        Signal<Void, TestError>(just: () )
            .with(.weak(SimpleClass()),
                  .weak(SimpleClass()),
                  .weak(SimpleClass()),
                  .weak(SimpleClass()),
                  .weak(SimpleClass())
            )
            .expectNext([])

        Signal<Void, TestError>(just: () )
            .with(.strong(2),
                  .strong(3),
                  .strong(4),
                  .strong(5),
                  .strong(6)
            )
            .expectNext([ (2, 3, 4, 5, 6) ])
    }
    func testVoidWith6Argument() {

        Signal<Void, TestError>.failed(.error)
            .with(.strong(2),
                  .strong(3),
                  .strong(4),
                  .strong(5),
                  .strong(6),
                  .strong(7)
            )
            .expect([.failed(.error)])

        Signal<Void, TestError>(just: () )
            .with(.weak(SimpleClass()),
                  .weak(SimpleClass()),
                  .weak(SimpleClass()),
                  .weak(SimpleClass()),
                  .weak(SimpleClass()),
                  .weak(SimpleClass())
            )
            .expectNext([])

        Signal<Void, TestError>(just: () )
            .with(.strong(2),
                  .strong(3),
                  .strong(4),
                  .strong(5),
                  .strong(6),
                  .strong(7)
            )
            .expectNext([ (2, 3, 4, 5, 6, 7) ])
    }
    func testVoidWith7Argument() {

        Signal<Void, TestError>.failed(.error)
            .with(.strong(2),
                  .strong(3),
                  .strong(4),
                  .strong(5),
                  .strong(6),
                  .strong(7),
                  .strong(8)
            )
            .expect([.failed(.error)])

        Signal<Void, TestError>(just: () )
            .with(.weak(SimpleClass()),
                  .weak(SimpleClass()),
                  .weak(SimpleClass()),
                  .weak(SimpleClass()),
                  .weak(SimpleClass()),
                  .weak(SimpleClass()),
                  .weak(SimpleClass())
            )
            .expectNext([])

        Signal<Void, TestError>(just: () )
            .with(.strong(2),
                  .strong(3),
                  .strong(4),
                  .strong(5),
                  .strong(6),
                  .strong(7),
                  .strong(8)
            )
            .expectNext([ (2, 3, 4, 5, 6, 7, 8) ])
    }
    func testVoidWith8Argument() {

        Signal<Void, TestError>.failed(.error)
            .with(.strong(2),
                  .strong(3),
                  .strong(4),
                  .strong(5),
                  .strong(6),
                  .strong(7),
                  .strong(8),
                  .strong(9)
            )
            .expect([.failed(.error)])

        Signal<Void, TestError>(just: () )
            .with(.weak(SimpleClass()),
                  .weak(SimpleClass()),
                  .weak(SimpleClass()),
                  .weak(SimpleClass()),
                  .weak(SimpleClass()),
                  .weak(SimpleClass()),
                  .weak(SimpleClass()),
                  .weak(SimpleClass())
            )
            .expectNext([])

        Signal<Void, TestError>(just: () )
            .with(.strong(2),
                  .strong(3),
                  .strong(4),
                  .strong(5),
                  .strong(6),
                  .strong(7),
                  .strong(8),
                  .strong(9)
            )
            .expectNext([ (2, 3, 4, 5, 6, 7, 8, 9) ])
    }
    func testVoidWith9Argument() {

        Signal<Void, TestError>.failed(.error)
            .with(.strong(2),
                  .strong(3),
                  .strong(4),
                  .strong(5),
                  .strong(6),
                  .strong(7),
                  .strong(8),
                  .strong(9),
                  .strong(10)
            )
            .expect([.failed(.error)])

        Signal<Void, TestError>(just: () )
            .with(.weak(SimpleClass()),
                  .weak(SimpleClass()),
                  .weak(SimpleClass()),
                  .weak(SimpleClass()),
                  .weak(SimpleClass()),
                  .weak(SimpleClass()),
                  .weak(SimpleClass()),
                  .weak(SimpleClass()),
                  .weak(SimpleClass())
            )
            .expectNext([])

        Signal<Void, TestError>(just: () )
            .with(.strong(2),
                  .strong(3),
                  .strong(4),
                  .strong(5),
                  .strong(6),
                  .strong(7),
                  .strong(8),
                  .strong(9),
                  .strong(10)
            )
            .expectNext([ (2, 3, 4, 5, 6, 7, 8, 9, 10) ])
    }

}
