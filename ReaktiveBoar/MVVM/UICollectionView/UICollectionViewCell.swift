//
//  CollectionViewCell.swift
//  ReaktiveBoar
//
//  Created by Peter Ovchinnikov on 3/15/19.
//  Copyright © 2019 Peter Ovchinnikov. All rights reserved.
//

import Swinject
import ReactiveKit

public protocol CellLifeCycle: class {
    func cellWillShow(container: Resolver)
}

public protocol Cell: CellLifeCycle & View & TypeProviderProtocol {
    static var identifier: String { get }
}

public extension Cell {
    static var identifier: String { return className }
}

public extension CellLifeCycle where Self: UICollectionViewCell, Self: View {

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

    func cellWillShow(container: Resolver) {
        vm = container.resolve(VMType.self)!
        unadvise(bag: reactive.reuseBag)
        reactive.reuseBag.dispose()
        advise(vm: vm!, bag: reactive.reuseBag)
    }
}

public protocol ReuseDisposeBagProvider {
    var reuseBag: DisposeBag { get }
}

extension ReactiveExtensions where Base: ReuseDisposeBagProvider {
    public var reuseBag: DisposeBag {
        return base.reuseBag
    }
}

extension UICollectionViewCell: ReuseDisposeBagProvider {
    private static var reuseBagKey = ""
    public var reuseBag: DisposeBag {
        return Associated<UICollectionViewCell,
            DisposeBag>(self, &UICollectionViewCell.reuseBagKey)
            .value(initial: DisposeBag.init)
    }
}

extension UICollectionViewCell: TypeProviderProtocol { }
