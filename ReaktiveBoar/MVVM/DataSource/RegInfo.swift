//
//  RegInfo.swift
//  ReaktiveBoar
//
//  Created by Peter Ovchinnikov on 3/25/19.
//  Copyright © 2019 Peter Ovchinnikov. All rights reserved.
//

import Swinject

internal struct RegInfo<Item> {
    let cellIdentifier: String
    let sizeInfo: SizeInfo
    let data: (Item, Container) -> Void
}
