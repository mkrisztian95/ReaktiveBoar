//
//  TestController.swift
//  ReaktiveBoarTests
//
//  Created by Peter Ovchinnikov on 3/17/19.
//  Copyright © 2019 Peter Ovchinnikov. All rights reserved.
//

import ReaktiveBoar
import ReactiveKit
import Swinject
import SwinjectAutoregistration

class TestControllerVM: VMProtocol {

}
class TestController: UIViewController, VCView {

    typealias VMType = TestControllerVM
    var advised = false
    func advise(vm: TestControllerVM, bag: DisposeBag) {
        advised = true
    }
}

class TestControllerAssemblyVM: VMProtocol { }

class TestControllerAssembly: UIViewController {
    var advised = false
}

extension TestControllerAssembly: VCView {
    typealias VMType = TestControllerAssemblyVM

    func advise(vm: TestControllerAssemblyVM, bag: DisposeBag) {
        advised = true
    }
}

extension TestControllerAssembly: SelfAssembly, Assembly {
    func assemble(container: Container) {
        container.autoregister(TestControllerAssemblyVM.self, initializer: TestControllerAssemblyVM.init)
    }
    static func assemble(container: Container) {
        container.registerVC(TestControllerAssembly.self)
    }
}
