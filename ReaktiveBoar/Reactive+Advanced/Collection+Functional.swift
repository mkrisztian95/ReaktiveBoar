//
//  Collection+Functional.swift
//  ReaktiveBoar
//
//  Created by Peter Ovchinnikov on 4/6/19.
//  Copyright © 2019 Peter Ovchinnikov. All rights reserved.
//

import ReactiveKit

public extension Array {
    func prefixed(upTo end: Int) -> [Element] {
        return Array(self.prefix(upTo: end))
    }
    func prefixed(_ maxLength: Int) -> [Element] {
        return Array(self.prefix(maxLength))
    }

    func suffixed(from: Int) -> [Element] {
        return Array(self.suffix(from: from))
    }
}

public extension Array {
    func trimmed(_ f: (Element)->Bool)->[Element] {
        guard let start = self.firstIndex(where: { !f($0) }),
            let end = self.reversed().firstIndex(where: { !f($0) }) else {
                return []
        }
        return Array(self[start..<end.base])
    }
}

public extension Array where Element == String {
    func trimmed() -> [String] {
        return trimmed({$0.isEmpty})
    }
}

public extension Sequence {
    func cast<T>() -> [T] {
        return map { $0 as! T} // swiftlint:disable:this force_cast
    }
    func safeCast<T>() -> [T] {
        return compactMap { $0 as? T}
    }

    func safeCast<T>(_ type: T.Type) -> [T] {
        return compactMap { $0 as? T}
    }
}
public extension Array {
    func appended(_ newElement: Element) -> [Element] {
        var new = self
        new.append(newElement)
        return new
    }

    func appended<T: Sequence>(_ sequence: T) -> [Element] where Element == T.Element {
        var new = self
        new.append(contentsOf: sequence)
        return new
    }

    func removed(at index: Int) -> [Iterator.Element] {
        var new = self
        new.remove(at: index)
        return new
    }
}

public extension Set {
    func removed(_ member: Element) -> Set {
        var res = self
        res.remove(member)
        return res
    }
    func inserted(_ member: Element) -> Set {
        var res = self
        res.insert(member)
        return res
    }
}

public extension Collection {

    func minMax<T: Comparable>(_ f: (Element) -> T) -> (T, T)? {

        guard !self.isEmpty else {
            return nil
        }

        var minActual = f(self.first!)
        var maxActual = f(self.first!)
        for valor in self {
            let val = f(valor)
            if val < minActual {
                minActual = val
            } else if val > maxActual {
                maxActual = val
            }
        }
        return (minActual, maxActual)
    }
}

public extension Collection where Iterator.Element: Comparable {

    func minMax() -> (Iterator.Element, Iterator.Element)? {
        return minMax { $0 }
    }
}

public extension Sequence {

    /// Categorises elements of self into a dictionary, with the keys given by keyFunc

    func categorise<U: Hashable, E>(_ keyFunc: (Iterator.Element) -> (U, E) ) -> [U: [E]] {
        var dict: [U: [E]] = [:]
        for el in self {
            let (key, value) = keyFunc(el)
            if case nil = dict[key]?.append(value) { dict[key] = [value] }
        }
        return dict
    }

    func categoriseCount<U: Hashable>(_ keyFunc: (Iterator.Element) -> U) -> [U: Int] {
        var dict: [U: Int] = [:]
        for el in self {
            let key = keyFunc(el)
            dict[key] = (dict[key] ?? 0) + 1
        }
        return dict
    }
}

public extension Sequence where Element: Hashable {

    /// Categorises elements of self into a dictionary, with the keys given by keyFunc

    func categorise<E>(_ f: (Iterator.Element) -> E) -> [Element: [E]] {
        return categorise({ ($0, f($0)) })
    }

    func categoriseCount() -> [Element: Int] {
        return categoriseCount({ $0 })
    }
}

extension Sequence where Element: Numeric {
    /// Returns the sum of all elements in the collection
    public func sum() -> Element { return reduce(0, +) }
}

extension Optional {

    public var monad: [Wrapped] {
        if let val = _unbox {
            return [val]
        }
        return []
    }
}
