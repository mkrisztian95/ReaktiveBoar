//
//  SelfAssembly.swift
//  ReaktiveBoar
//
//  Created by Peter Ovchinnikov on 3/25/19.
//  Copyright © 2019 Peter Ovchinnikov. All rights reserved.
//

import Swinject

public protocol SelfAssembly {
    static func assemble(container: Container)
}

struct SelfAssemblyImpl<T: SelfAssembly>: Assembly {
    func assemble(container: Container) {
        T.assemble(container: container)
    }
}
public extension SelfAssembly {
    static func assembly() -> Assembly {
        return SelfAssemblyImpl<Self>()
    }
}
