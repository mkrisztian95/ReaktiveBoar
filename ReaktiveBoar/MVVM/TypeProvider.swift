//
//  TypeProvider.swift
//  ReaktiveBoar
//
//  Created by Peter Ovchinnikov on 3/18/19.
//  Copyright © 2019 Peter Ovchinnikov. All rights reserved.
//

public protocol TypeProviderProtocol {
    var className: String { get }
    //static var className: String { get }
}
extension TypeProviderProtocol {
    public var className: String {
        return "\(Swift.type(of: self))"
    }

    public static var className: String {
        return "\(Self.self)"
    }
}

public func className<T>(data: T) -> String {
    if let typeProvider = data as? TypeProviderProtocol {
        return typeProvider.className
    }
    return "\(type(of: data))"
}
public func className<T>(type: T.Type) -> String {
    return "\(type)"
}

extension String: TypeProviderProtocol { }
