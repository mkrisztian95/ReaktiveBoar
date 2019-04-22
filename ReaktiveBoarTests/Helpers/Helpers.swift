//
//  Common.swift
//  ReactiveKit
//
//  Created by Srdan Rasic on 14/04/16.
//  Copyright © 2016 Srdan Rasic. All rights reserved.
//

import XCTest
import ReactiveKit

enum TestError: Swift.Error {
    case error
}

extension SignalProtocol {

    func expectNext(_ expectedElements: [Element],
                    _ message: @autoclosure () -> String = "",
                    expectation: XCTestExpectation? = nil,
                    file: StaticString = #file, line: UInt = #line) {
        expect(expectedElements.map { .next($0) } + [.completed],
               message(),
               expectation: expectation,
               file: file,
               line: line)
    }

    func expect(_ expectedEvents: [Event<Element, Error>],
                _ message: @autoclosure () -> String = "",
                expectation: XCTestExpectation? = nil,
                file: StaticString = #file, line: UInt = #line) {
        var eventsToProcess = expectedEvents
        var receivedEvents: [Event<Element, Error>] = []
        let message = message()
        _ = observe { event in
            receivedEvents.append(event)
            if eventsToProcess.count == 0 {
                XCTFail("Got more events then expected.")
                return
            }
            let expected = eventsToProcess.removeFirst()
            XCTAssert(event.isEqualTo(expected),
                      message + "(Got \(receivedEvents) instead of \(expectedEvents))",
                file: file,
                line: line)
            if event.isTerminal {
                expectation?.fulfill()
            }
        }
    }
}

extension SignalProtocol where Element: Equatable {

    func expectNext(_ expectedElements: [Element],
                    _ message: @autoclosure () -> String = "",
                    expectation: XCTestExpectation? = nil,
                    file: StaticString = #file, line: UInt = #line) {
        expect(expectedElements.map { .next($0) } + [.completed],
               message(),
               expectation: expectation,
               file: file,
               line: line)
    }

    func expect(_ expectedEvents: [Event<Element, Error>],
                _ message: @autoclosure () -> String = "",
                expectation: XCTestExpectation? = nil,
                file: StaticString = #file, line: UInt = #line) {
        var eventsToProcess = expectedEvents
        var receivedEvents: [Event<Element, Error>] = []
        let message = message()
        _ = observe { event in
            receivedEvents.append(event)
            if eventsToProcess.count == 0 {
                XCTFail("Got more events then expected.")
                return
            }
            let expected = eventsToProcess.removeFirst()
            XCTAssert(event.isEqualTo(expected),
                      message + "(Got \(receivedEvents) instead of \(expectedEvents))",
                file: file,
                line: line)
            if event.isTerminal {
                expectation?.fulfill()
            }
        }
    }
}

func == (lhs: [(String, Int)], rhs: [(String, Int)]) -> Bool {
    if lhs.count != rhs.count {
        return false
    }

    return zip(lhs, rhs).reduce(true) { memo, new in
        memo && new.0.0 == new.1.0 && new.0.1 == new.1.1
    }
}
