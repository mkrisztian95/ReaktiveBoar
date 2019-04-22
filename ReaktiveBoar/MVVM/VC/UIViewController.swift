//
//  VC.swift
//  ReaktiveBoarTests
//
//  Created by Peter Ovchinnikov on 3/12/19.
//  Copyright © 2019 Peter Ovchinnikov. All rights reserved.
//

import UIKit
import ReactiveKit
import Swinject

public protocol VCLifeCycle: class {
    func viewDidLoadImpl()
    func viewWillAppearImpl()
}

var vmKey = ""
public extension VCLifeCycle where Self: UIViewController, Self: View, Self: Assembly {

    private var vm: VMType? {
        get {
            return Associated<Self,
                VMType?>(self, &vmKey)
                .value()
        }
        set {
            Associated<Self,
                VMType?>(self, &vmKey)
                .value(new: newValue)
        }
    }

    func viewDidLoadImpl() {
        assemble(container: container)
        loaded(resolver: resolver)
        let vm1 = resolver.resolve(VMType.self)!
        advise(vm: vm1, bag: reactive.bag)
        vm = vm1
    }

    func viewWillAppearImpl() {
        //globalAdvise(vm: vm, bag: bag)
    }
}

public extension VCLifeCycle where Self: UIViewController, Self: View {

    private var vm: VMType {
        return Associated<Self,
            VMType>(self, &vmKey)
            .value(initial: { resolver.resolve(VMType.self)! })
    }

    func viewDidLoadImpl() {
        advise(vm: vm, bag: reactive.bag)
    }

    func viewWillAppearImpl() {
        //globalAdvise(vm: vm, bag: bag)
    }
}

public protocol View {
    associatedtype VMType: VMProtocol
    func advise(vm: VMType, bag: DisposeBag)
    func unadvise(bag: DisposeBag)
}

public extension View {
    func unadvise(bag: DisposeBag) { }
}

public protocol VCView: View, VCLifeCycle { }

extension UIViewController {

    private static let swizzle: Void = {
        func registerSwizzle(_ originalSelector: Selector, swizzledSelector: Selector, clazz: AnyClass) {
            let originalMethod = class_getInstanceMethod(clazz, originalSelector)
            let swizzledMethod = class_getInstanceMethod(clazz, swizzledSelector)

            let didAddMethod = class_addMethod(clazz,
                                               originalSelector,
                                               method_getImplementation(swizzledMethod!),
                                               method_getTypeEncoding(swizzledMethod!))

            if didAddMethod {
                class_replaceMethod(clazz,
                                    swizzledSelector,
                                    method_getImplementation(originalMethod!),
                                    method_getTypeEncoding(originalMethod!))
            } else {
                method_exchangeImplementations(originalMethod!, swizzledMethod!)
            }
        }
        registerSwizzle(#selector(UIViewController.viewDidAppear(_:)),
                        swizzledSelector: #selector(UIViewController.nsh_viewDidAppear(_:)),
                        clazz: UIViewController.self)
        registerSwizzle(#selector(UIViewController.viewWillAppear(_:)),
                        swizzledSelector: #selector(UIViewController.nsh_viewWillAppear(_:)),
                        clazz: UIViewController.self)
        registerSwizzle(#selector(UIViewController.viewDidDisappear(_:)),
                        swizzledSelector: #selector(UIViewController.nsh_viewDidDisappear(_:)),
                        clazz: UIViewController.self)
        registerSwizzle(#selector(UIViewController.viewWillDisappear(_:)),
                        swizzledSelector: #selector(UIViewController.nsh_viewWillDisappear(_:)),
                        clazz: UIViewController.self)
        registerSwizzle(#selector(UIViewController.viewDidLoad),
                        swizzledSelector: #selector(UIViewController.nsh_viewDidLoad),
                        clazz: UIViewController.self)
    }()

    public static func setup() {
        // make sure this isn't a subclass
        if self !== UIViewController.self {
            return
        }
        UIViewController.swizzle
    }

    @objc func nsh_viewDidLoad() {
        self.nsh_viewDidLoad()
        if let liveCycle = self as? VCLifeCycle {
            liveCycle.viewDidLoadImpl()
        }
    }
    @objc func nsh_viewDidAppear(_ animated: Bool) {
        self.nsh_viewDidAppear(animated)

    }
    @objc  func nsh_viewWillAppear(_ animated: Bool) {
        self.nsh_viewWillAppear(animated)
        if let liveCycle = self as? VCLifeCycle {
            liveCycle.viewWillAppearImpl()
        }
    }
    @objc func nsh_viewWillDisappear(_ animated: Bool) {
        self.nsh_viewWillDisappear(animated)
    }
    @objc func nsh_viewDidDisappear(_ animated: Bool) {
        self.nsh_viewDidDisappear(animated)
    }
}

extension UIViewController {

    static var containerKey = ""

    var container: Container {
        get {
            return Associated<UIViewController,
                Container>(self, &UIViewController.containerKey)
                .value(initial: { Container() })
        }
        set {
            Associated<UIViewController,
                Container>(self, &UIViewController.containerKey)
                .value(new: newValue)
        }
    }
    public var resolver: Resolver { return container }
}

extension UIViewController: TypeProviderProtocol { }

public extension Container {

    @discardableResult
    func registerVC<VC: UIViewController>(_ type: VC.Type) -> ServiceEntry<VC> where VC: VCView {

        return self.register(type) { resolver in
            let bundle = Bundle(for: type)
            let vc = UIStoryboard(name: VC.className, bundle: bundle)
                // swiftlint:disable:next force_cast
                .instantiateInitialViewController() as! VC

            vc.container = resolver.push()

            return vc
        }
    }
}

extension Resolver {
    func push() -> Container {
        return Container(parent: self as? Container)
    }
}

protocol ContainerStackItem {
    var resolver: Resolver { get }
}
