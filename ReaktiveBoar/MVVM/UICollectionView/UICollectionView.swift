//
//  UICollectionView.swift
//  ReaktiveBoar
//
//  Created by Peter Ovchinnikov on 3/24/19.
//  Copyright © 2019 Peter Ovchinnikov. All rights reserved.
//

import UIKit
import Swinject
import Bond
import ReactiveKit

public class CellRegistrator<Item> {

    let collectionView: UICollectionView

    init(collectionView: UICollectionView) {
        self.collectionView = collectionView
    }

    internal var convertors = [String: RegInfo<Item>]()

    public func register<T, C>(for dataType: T.Type, register cellType: C.Type, with sizeInfo: SizeInfo)
        where C: UICollectionViewCell, C: Cell {

            let regInfo = RegInfo<Item>(cellIdentifier: C.identifier,
                                  sizeInfo: sizeInfo,
                                  data: { data, container in
                                    // swiftlint:disable:next force_cast
                                    container.register(value: data as! T)
                })

            let nib = UINib(nibName: C.identifier,
                            bundle: Bundle.init(for: cellType))
            collectionView.register(nib, forCellWithReuseIdentifier: C.identifier)

            convertors[className(type: dataType)] = regInfo
    }

    public func register<C>(register cellType: C.Type, with sizeInfo: SizeInfo)
        where C: UICollectionViewCell, C: Cell {

            register(for: cellType.VMType.self,
                     register: cellType,
                     with: sizeInfo)
    }
}

extension SignalProtocol where Element: SectionedDataSourceChangesetConvertible,
Element.Changeset.Collection: QueryableSectionedDataSourceProtocol,
Error == Never {

    public typealias Item = Element.Changeset.Collection.Item
    public func bind(to collectionView: UICollectionView, with resolver: Resolver,
                     register: (CellRegistrator<Item>) -> Void) -> Disposable {

        let registrator = CellRegistrator<Item>(collectionView: collectionView)
        register(registrator)

        return bind(to: collectionView,
                    using: CollectionDataSource<Element>(convertors: registrator.convertors, resolver: resolver))
    }
}
