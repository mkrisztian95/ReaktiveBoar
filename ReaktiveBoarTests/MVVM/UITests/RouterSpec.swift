//
//  RouterSpec.swift
//  ReaktiveBoarTests
//
//  Created by Peter Ovchinnikov on 3/21/19.
//  Copyright © 2019 Peter Ovchinnikov. All rights reserved.
//

import Quick
import Nimble
import Swinject

//func route<T: UIViewController, D.Data>(_ controller: T.Type, ) {
//
//}

@testable import ReaktiveBoar
import ReactiveKit
//class TestControllerVM1: VMProtocol {
//
//    let share = PublishSubject1<Void>()
//    let userText = Property<String>("")
//
//    init(router: Router, caption: String, user: String) {
//
//        share.with(.val(userText)).call {
//             router.route(TestController.self, (caption))
//        }
//    }
//}

class RouterSpec: QuickSpec {
    override func spec() {
        describe("Router") {
            var router: Router!

            var root: TestController!
            beforeEach {
                let container = Container()
                container.autoregister(TestControllerVM.self,
                                       initializer: TestControllerVM.init)
                container.registerVC(TestController.self)
                root = container.resolve(TestController.self)

                router = Router()
                UIApplication.shared.keyWindow?.rootViewController = root
            }

            it("Sould do something") {
                _ = router.bag
            }
        }
    }
}
