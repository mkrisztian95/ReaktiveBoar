//
//  UICollectionViewCell+Reactive.swift
//  ReaktiveBoar
//
//  Created by Peter Ovchinnikov on 3/27/19.
//  Copyright © 2019 Peter Ovchinnikov. All rights reserved.
//

import Bond
import ReactiveKit

public extension ReactiveExtensions where Base: UICollectionViewCell {
    var didSelect: SafeSignal<Void> {
        return isSelected
            .filter { $0 }.eraseType()
    }
}

public extension ReactiveExtensions where Base: UICollectionView {
    func visibleCell(at: UICollectionView.ScrollPosition) -> Bond<IndexPath> {
        return self.bond { view, index in
            view.scrollToItem(at: index, at: at, animated: true)
        }
    }
}

public extension ReactiveExtensions where Base: UICollectionView {
    var scrollToBottom: Bond<Void> {

        return self.bond { view, _ in

            if view.window != nil && view.numberOfSections > 0 {
                if view.numberOfItems(inSection: view.numberOfSections - 1) > 0 {
                    let index = IndexPath(row: view.numberOfItems(inSection: view.numberOfSections - 1) - 1,
                                          section: view.numberOfSections - 1)
                    view.scrollToItem(at: index, at: .bottom, animated: false)
                }
            }
        }
    }
}

extension UICollectionView {
    public func getCurrentIndexPath() -> IndexPath? {
        let offset = contentOffset
        if let cell = visibleCells.filter({ $0.frame.contains(offset) }).first {
            return indexPath(for: cell)
        }
        return nil
    }
}

public extension ReactiveExtensions where Base: UICollectionViewCell {
    var isSelected: SafeSignal<Bool> {
        return keyPath(\.isSelected)
    }
}
