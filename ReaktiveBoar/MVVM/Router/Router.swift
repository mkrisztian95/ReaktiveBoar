//
//  Router.swift
//  ReaktiveBoar
//
//  Created by Peter Ovchinnikov on 3/13/19.
//  Copyright © 2019 Peter Ovchinnikov. All rights reserved.
//

import Foundation

import Bond
import ReactiveKit
import BrightFutures

public protocol JustPresent { }
public protocol MotionPresent {
    var isMotionEnabled: Bool { get set }
}
public protocol IgnorePrevous { }
extension UIAlertController: JustPresent { }

public protocol RouterType {
//    var show: SafePublishSubject<UIViewController> { get }
//    var close: SafePublishSubject<Void> { get }
//    var closeAll: SafePublishSubject<Void> { get }
//
//    func showF<T: UIViewController>(vc: T, animated flag: Bool)-> Future<T, NSError>
//    func closeF(animated flag: Bool)-> Future<Void, NSError>
//    func closeAllF(animated flag: Bool)-> Future<Void, NSError>
}

public class Router: RouterType, DisposeBagProvider {

    public let bag = DisposeBag()
//    public let show = SafePublishSubject<UIViewController>()
//    public let close = SafePublishSubject<Void>()
//    public let closeAll = SafePublishSubject<Void>()
//
    public init() {
//        show.with(Value.weak(self)).call { $1.showF(vc: $0, animated: true) }.dispose(in: bag)
//        close.with(Value.weak(self)).call { $0.closeF(animated: true) }.dispose(in: bag)
//        closeAll.with(Value.weak(self)).call { $0.closeAllF(animated: true) }.dispose(in: bag)
    }
//
//    @discardableResult
//    public func showF<T: UIViewController>(vc: T, animated flag: Bool)-> Future<T, NSError> {
//
//        guard let topController = Router.topViewController() else {
//            return Future(error: BoarError.noTopController)
//        }
//        if vc is JustPresent {
//            return topController.reactive.present(vc, animated: true)
//        }
//
//        if let nav =  topController.navigationController {
//            if !(vc is IgnorePrevous) &&
//                nav.viewControllers.count > 1 &&
//                type(of: nav.viewControllers[nav.viewControllers.count - 2]) ==  type(of: vc) {
//
//                return nav.reactive.pop(animated: flag).map { _ in vc}
//            }
//            return nav.reactive.push(vc: vc, animated: flag)
//        } else {
//            let nav = UINavigationController(rootViewController: vc)
//            if var motion = vc as? MotionPresent {
//                motion.isMotionEnabled = true
//            }
//            return topController.reactive.present(nav, animated: flag).map { _ in vc}
//        }
//    }
//
//    @discardableResult
//    public func closeF(animated flag: Bool)-> Future<Void, NSError> {
//        if let topController = Router.topViewController() {
//            if let navigationController = topController.navigationController {
//                if navigationController.viewControllers.first == topController {
//                    return navigationController.reactive.dismiss(animated: flag)
//                }
//                return navigationController.reactive.pop(animated: flag)
//            }
//            return topController.reactive.dismiss(animated: flag)
//        }
//        return Future(error: BoarError.noTopController)
//    }
//
//    @discardableResult
//    public func closeAllF(animated flag: Bool)-> Future<Void, NSError> {
//        if let topController = Router.topViewController() {
//            if let navigationController = topController.findNavigationController() {
//                return navigationController.reactive.dismiss(animated: flag)
//            }
//            if topController.isBeingPresented {
//                return topController.reactive.dismiss(animated: flag)
//            }
//            return Future(value: ())
//        }
//        return Future(error: BoarError.noTopController)
//    }
}
//
//extension Router {
//    public static func topViewController(_ base: UIViewController?
//        = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
//        if let nav = base as? UINavigationController {
//            return topViewController(nav.visibleViewController)
//        }
//        if let tab = base as? UITabBarController {
//            if let selected = tab.selectedViewController {
//                return topViewController(selected)
//            }
//        }
//        if let presented = base?.presentedViewController {
//            return topViewController(presented)
//        }
//        return base
//    }
//
//    fileprivate static func getVisibleViewController(from vc: UIViewController?
//        = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
//        if let navigationController = vc as? UINavigationController {
//            return getVisibleViewController(from: navigationController.visibleViewController)
//        } else if let tabController = vc as? UITabBarController {
//            return getVisibleViewController(from: tabController.selectedViewController)
//        } else {
//            if let pvc = vc?.presentedViewController {
//                return getVisibleViewController(from: pvc)
//            } else {
//                return vc
//            }
//        }
//    }
//
//    public static func tabBarViewController(_ base: UIViewController?
//        = UIApplication.shared.keyWindow?.rootViewController) -> UITabBarController? {
//
//        if let tab = base as? UITabBarController {
//            return tab
//        } else {
//            return base?.tabBarController
//        }
//    }
//
//    internal static func topView() -> UIView? {
//        var view = topViewController()?.view
//
//        while view != nil && view?.superview != nil {
//            view = view!.superview
//        }
//        return view
//
//    }
//}
//
//extension UIViewController {
//    func findNavigationController() -> UINavigationController? {
//        if let navigationController = navigationController {
//            return navigationController
//        }
//
//        for controller in children {
//            if let navigationController = controller.navigationController {
//                return navigationController
//            }
//        }
//        for controller in children {
//            if let navigationController = controller.findNavigationController() {
//                return navigationController
//            }
//
//        }
//        return nil
//    }
//}
//
//extension ReactiveExtensions where Base: UIViewController {
//
//    func present<T: UIViewController>(_ vc: T, animated: Bool)->Future<T, NSError> {
//        let promise = Promise<T, NSError>()
//        base.present(vc, animated: animated) {
//            promise.success(vc)
//        }
//        return promise.future
//    }
//
//    func dismiss(animated: Bool)->Future<Void, NSError> {
//        let promise = Promise<Void, NSError>()
//        base.dismiss(animated: animated) {
//            promise.success(())
//        }
//        return promise.future
//    }
//}
//
//extension ReactiveExtensions where Base: UINavigationController {
//
//    func push<T: UIViewController>(vc: T, animated: Bool)->Future<T, NSError> {
//
//        let promise = Promise<T, NSError>()
//
//        CATransaction.begin(); defer { CATransaction.commit(); }
//        CATransaction.setCompletionBlock {
//            promise.success(vc)
//        }
//        base.pushViewController(vc, animated: animated)
//        return promise.future
//    }
//
//    func pop(animated: Bool)->Future<Void, NSError> {
//
//        let promise = Promise<Void, NSError>()
//
//        CATransaction.begin(); defer { CATransaction.commit(); }
//        CATransaction.setCompletionBlock {
//            promise.success(())
//        }
//        base.popViewController(animated: animated)
//        return promise.future
//    }
//
//    func popToRoot(animated: Bool)->Future<Void, NSError> {
//        let promise = Promise<Void, NSError>()
//
//        CATransaction.begin(); defer { CATransaction.commit(); }
//        CATransaction.setCompletionBlock {
//            promise.success(())
//        }
//        base.popToRootViewController(animated: animated)
//        return promise.future
//    }
//}
