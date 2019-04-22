//
//  SizeInfo.swift
//  ReaktiveBoar
//
//  Created by Peter Ovchinnikov on 3/18/19.
//  Copyright © 2019 Peter Ovchinnikov. All rights reserved.
//

public enum SizeInfo {
    case value(width: ValueInfo, height: ValueInfo)
    case custom( (CGSize)->CGSize)
}

public extension SizeInfo {

    init (width: ValueInfo = .full(offset: 0), height: ValueInfo = ValueInfo.const(75)) {
        self = .value(width: width, height: height)
    }
    init (size: @escaping (CGSize) -> CGSize) {
        self = .custom(size)
    }
}

extension SizeInfo {
    func size(from container: CGSize) -> CGSize {
        switch self {
        case .value(let widthInfo, let heightInfo):
            var height: CGFloat = 0, width: CGFloat = 0
            if case .equal = heightInfo {
                width = widthInfo.value(from: container.width)
                height = width

            } else if case .equal = widthInfo {
                height = heightInfo.value(from: container.height)
                width = height
            } else {
                width = widthInfo.value(from: container.width)
                height = heightInfo.value(from: container.height)
            }
            return CGSize(width: width, height: height)
        case .custom(let f):
            return f(container)
        }
    }
}
