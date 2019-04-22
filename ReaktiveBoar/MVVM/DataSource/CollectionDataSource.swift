//
//  DataSource.swift
//  ReaktiveBoar
//
//  Created by Peter Ovchinnikov on 3/15/19.
//  Copyright © 2019 Peter Ovchinnikov. All rights reserved.
//

import Bond
import ReactiveKit
import Swinject
import SwinjectAutoregistration

internal class CollectionDataSource<Element>:
    CollectionViewBinderDataSource<Element.Changeset>,
    UICollectionViewDelegateFlowLayout where Element: SectionedDataSourceChangesetConvertible,
    Element.Changeset.Collection: QueryableSectionedDataSourceProtocol {

    internal typealias Item = Element.Changeset.Collection.Item
    private let convertors: [String: RegInfo<Item>]

    private let resolver: Resolver

    public init(convertors: [String: RegInfo<Item>], resolver: Resolver) {
        self.resolver = resolver
        self.convertors = convertors
        super.init()
    }

    open func collectionView(_ collectionView: UICollectionView,
                             layout collectionViewLayout: UICollectionViewLayout,
                             sizeForItemAt indexPath: IndexPath) -> CGSize {

        guard let changeset = changeset else { fatalError() }
        let data = changeset.collection.item(at: indexPath)
        let type = className(data: data)
        guard let info = convertors[type] else {
            fatalError("[DS:sizeForRow]! No registetered class for item type: \(type)")
        }

        return info.sizeInfo.size(from: collectionView.bounds.size)
    }

    open override func collectionView(_ collectionView: UICollectionView,
                                      cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        guard let changeset = changeset else { fatalError() }
        let data = changeset.collection.item(at: indexPath)
        let type = className(data: data)

        guard let info = convertors[type] else {
            fatalError("[DS:cellForRow]! No registetered class for item type: \(type)")
        }

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: info.cellIdentifier, for: indexPath)

        if let cellLifeCycle = cell as? CellLifeCycle {
            let container = resolver.push()
            info.data(data, container)
            cellLifeCycle.cellWillShow(container: container)
        }
        return cell

    }

    open func collectionView(_ collectionView: UICollectionView,
                             layout collectionViewLayout: UICollectionViewLayout,
                             insetForSectionAt section: Int) -> UIEdgeInsets {
        return (collectionViewLayout as? UICollectionViewFlowLayout)?
            .sectionInset ?? UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }

    open func collectionView(_ collectionView: UICollectionView,
                             layout collectionViewLayout: UICollectionViewLayout,
                             minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return (collectionViewLayout as? UICollectionViewFlowLayout)?
            .minimumLineSpacing ?? 0
    }

    open func collectionView(_ collectionView: UICollectionView,
                             layout collectionViewLayout: UICollectionViewLayout,
                             minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return (collectionViewLayout as? UICollectionViewFlowLayout)?
            .minimumInteritemSpacing ?? 0
    }

    open func collectionView(_ collectionView: UICollectionView,
                             layout collectionViewLayout: UICollectionViewLayout,
                             referenceSizeForHeaderInSection section: Int) -> CGSize {
        return (collectionViewLayout as? UICollectionViewFlowLayout)?
            .headerReferenceSize ?? CGSize(width: 0, height: 0)
    }

    open func collectionView(_ collectionView: UICollectionView,
                             layout collectionViewLayout: UICollectionViewLayout,
                             referenceSizeForFooterInSection section: Int) -> CGSize {
        return (collectionViewLayout as? UICollectionViewFlowLayout)?
            .footerReferenceSize ?? CGSize(width: 0, height: 0)
    }

    open func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }

    open func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
    }

    override weak open var collectionView: UICollectionView? {
        didSet {
            guard let collectionView = collectionView else { return }
            associateWithCollectionView(collectionView)
        }
    }

    private func associateWithCollectionView(_ collectionView: UICollectionView) {
        objc_setAssociatedObject(collectionView,
                                 &dataSourceKey,
                                 self,
                                 .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        if collectionView.reactive.hasProtocolProxy(for: UICollectionViewDataSource.self) {
            collectionView.reactive.dataSource.forwardTo = self
        } else {
            collectionView.dataSource = self
        }

        if collectionView.reactive.hasProtocolProxy(for: UICollectionViewDelegateFlowLayout.self) {
            collectionView.reactive.delegate.forwardTo = self
        } else {
            collectionView.delegate = self
        }
    }
}

private var dataSourceKey = "CollectionViewBinderDataSource"
