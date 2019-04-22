//
//  ViewControllerSpec.swift
//  ReaktiveBoarTests
//
//  Created by Peter Ovchinnikov on 3/21/19.
//  Copyright © 2019 Peter Ovchinnikov. All rights reserved.
//

import Quick
import Nimble
import Swinject

@testable import ReaktiveBoar

class ViewControllerSpec: QuickSpec {
    override func spec() {

        describe("ViewController") {
            UIViewController.setup()

            var viewController: TestController!
            var container: Container!
            beforeEach {
                container = Container()
                container.autoregister(TestControllerVM.self,
                                       initializer: TestControllerVM.init)
                container?.registerVC(TestController.self)
                viewController = container.resolve(TestController.self)!

                _ = viewController.view

            }

            it("Should advise the vm to controller during lifecycle") {
                viewController.beginAppearanceTransition(true, animated: false)
                viewController.endAppearanceTransition()

                expect(viewController.advised).to(beTruthy())

                viewController.viewWillDisappear(false)
                viewController.viewDidDisappear(false)
            }
        }

        describe("ViewController with Assembly") {
            UIViewController.setup()
            var viewController: TestControllerAssembly!
            var assembler: Assembler!
            beforeEach {
                assembler = Assembler([TestControllerAssembly.assembly()])
                viewController = assembler.resolver.resolve(TestControllerAssembly.self)
                _ = viewController.view
            }

            it("Should adwise the vm to controller during lifecycle") {
                viewController.beginAppearanceTransition(true, animated: false)
                viewController.endAppearanceTransition()

                expect(viewController.advised).to(beTruthy())
                expect(assembler.resolver.resolve(TestControllerAssembly.VMType.self)).to(beNil())

                viewController.viewWillDisappear(false)
                viewController.viewDidDisappear(false)
            }
        }
    }
}
