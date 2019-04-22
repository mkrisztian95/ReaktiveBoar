//
//  ValueInfo.swift
//  ReaktiveBoar
//
//  Created by Peter Ovchinnikov on 3/18/19.
//  Copyright © 2019 Peter Ovchinnikov. All rights reserved.
//

public enum ValueInfo {
    case const(CGFloat)
    case percent(CGFloat)
    case denom(num: Int)
    case full(offset: CGFloat )
    case equal
}

extension ValueInfo {
    func value(from container: CGFloat) -> CGFloat {
        switch self {
        case .full(let offset): return container - offset
        case .const(let value): return value
        case .percent(let value): return container * value
        case .equal: fatalError()
        case .denom(let num): return container / CGFloat(num)
        }
    }
}
