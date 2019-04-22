//
//  IsEqual.swift.tpl.swift
//  ReaktiveBoarTests
//
//  Created by Peter Ovchinnikov on 3/12/19.
//  Copyright © 2019 Peter Ovchinnikov. All rights reserved.
//

// swiftlint:disable cyclomatic_complexity function_body_length

import ReactiveKit

extension Event where Element: Equatable {

    func isEqualTo(_ event: Event<Element, Error>) -> Bool {

        switch (self, event) {
        case (.completed, .completed):
            return true
        case (.failed, .failed):
            return true
        case (.next(let left), .next(let right)):
            return left == right
        default:
            return false
        }
    }
}

extension Event {

    func isEqualTo(_ event: Event<Element, Error>) -> Bool {

        switch (self, event) {
        case (.completed, .completed):
            return true
        case (.failed, .failed):
            return true
        case (.next(let left), .next(let right)):
            if let left = left as? Int, let right = right as? Int {
                return left == right
            } else if let left = left as? [Int], let right = right as? [Int] {
                return left == right
            } else if let left = left as? (Int?, Int), let right = right as? (Int?, Int) {
                return left.0 == right.0 && left.1 == right.1
            } else if let left = left as? (Int, Int, Int),
                let right = right as? (Int, Int, Int) {
                return left.0==right.0 &&
                    left.1==right.1 &&
                    left.2==right.2

            } else if let left = left as? (Int, Int, Int, Int),
                let right = right as? (Int, Int, Int, Int) {
                return left.0==right.0 &&
                    left.1==right.1 &&
                    left.2==right.2 &&
                    left.3==right.3

            } else if let left = left as? (Int, Int, Int, Int, Int),
                let right = right as? (Int, Int, Int, Int, Int) {
                return left.0==right.0 &&
                    left.1==right.1 &&
                    left.2==right.2 &&
                    left.3==right.3 &&
                    left.4==right.4

            } else if let left = left as? (Int, Int, Int, Int, Int, Int),
                let right = right as? (Int, Int, Int, Int, Int, Int) {
                return left.0==right.0 &&
                    left.1==right.1 &&
                    left.2==right.2 &&
                    left.3==right.3 &&
                    left.4==right.4 &&
                    left.5==right.5

            } else if let left = left as? (Int, Int, Int, Int, Int, Int, Int),
                let right = right as? (Int, Int, Int, Int, Int, Int, Int) {
                return left.0==right.0 &&
                    left.1==right.1 &&
                    left.2==right.2 &&
                    left.3==right.3 &&
                    left.4==right.4 &&
                    left.5==right.5 &&
                    left.6==right.6

            } else if let left = left as? (Int, Int, Int, Int, Int, Int, Int, Int),
                let right = right as? (Int, Int, Int, Int, Int, Int, Int, Int) {
                return left.0==right.0 &&
                    left.1==right.1 &&
                    left.2==right.2 &&
                    left.3==right.3 &&
                    left.4==right.4 &&
                    left.5==right.5 &&
                    left.6==right.6 &&
                    left.7==right.7

            } else if let left = left as? (Int, Int, Int, Int, Int, Int, Int, Int, Int),
                let right = right as? (Int, Int, Int, Int, Int, Int, Int, Int, Int) {
                return left.0==right.0 &&
                    left.1==right.1 &&
                    left.2==right.2 &&
                    left.3==right.3 &&
                    left.4==right.4 &&
                    left.5==right.5 &&
                    left.6==right.6 &&
                    left.7==right.7 &&
                    left.8==right.8

            } else if let left = left as? (Int, Int, Int, Int, Int, Int, Int, Int, Int, Int),
                let right = right as? (Int, Int, Int, Int, Int, Int, Int, Int, Int, Int) {
                return left.0==right.0 &&
                    left.1==right.1 &&
                    left.2==right.2 &&
                    left.3==right.3 &&
                    left.4==right.4 &&
                    left.5==right.5 &&
                    left.6==right.6 &&
                    left.7==right.7 &&
                    left.8==right.8 &&
                    left.9==right.9
            } else if let left = left as? String, let right = right as? String {
                return left == right
            } else if let left = left as? [String], let right = right as? [String] {
                return left == right
            } else {
                fatalError("Cannot compare that element type. \(left)")
            }
        default:
            return false
        }
    }
}
