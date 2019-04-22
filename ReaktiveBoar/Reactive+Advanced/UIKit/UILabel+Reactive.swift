//
//  UILabel+Reactive.swift
//  ReaktiveBoar
//
//  Created by Peter Ovchinnikov on 3/22/19.
//  Copyright © 2019 Peter Ovchinnikov. All rights reserved.
//

import Bond
import ReactiveKit

public extension ReactiveExtensions where Base: UILabel {
    var font: Bond<UIFont> {
        return bond { $0.font = $1 }
    }
    var numberOfLines: Bond<Int> {
        return self.bond { $0.numberOfLines = $1 }
    }
}
