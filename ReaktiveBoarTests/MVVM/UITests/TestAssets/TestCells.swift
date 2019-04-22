//
//  TestCells.swift
//  ReaktiveBoarTests
//
//  Created by Peter Ovchinnikov on 3/19/19.
//  Copyright © 2019 Peter Ovchinnikov. All rights reserved.
//

import ReaktiveBoar
import ReactiveKit

class TestStringCellVM: VMProtocol {
    init(str: String) {

    }
}

class TestStringCell: UICollectionViewCell, Cell {

    func advise(vm: TestStringCellVM, bag: DisposeBag) {

    }

    typealias VMType = TestStringCellVM
}

class TestVMCellVM: VMProtocol, Identifiable {
    var id: String { return UUID().uuidString }

    init() {

    }
}

class TestVMCell: UICollectionViewCell, Cell {
    func advise(vm: TestVMCellVM, bag: DisposeBag) {

    }

    typealias VMType = TestVMCellVM
}
