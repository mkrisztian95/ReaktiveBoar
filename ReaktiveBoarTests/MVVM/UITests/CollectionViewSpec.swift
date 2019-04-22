//
//  CollectionViewTests.swift
//  ReaktiveBoarTests
//
//  Created by Peter Ovchinnikov on 3/17/19.
//  Copyright © 2019 Peter Ovchinnikov. All rights reserved.
//

import XCTest
import UIKit
import ReactiveKit
import Swinject
import SwinjectAutoregistration
@testable import ReaktiveBoar
import Quick
import Nimble

class TestCollectionView: UICollectionView {
    override func cellForItem(at indexPath: IndexPath) -> UICollectionViewCell? {
        return dataSource?.collectionView(self, cellForItemAt: indexPath)
    }
}

class CollectionViewSpec: QuickSpec {

    override func spec() {
        describe("collection view datasource binding") {

            var collectionView: UICollectionView!
            var bag: DisposeBag!
            beforeEach {
                bag = DisposeBag()
                collectionView = TestCollectionView(frame: CGRect(x: 0, y: 0, width: 100, height: 100),
                                                    collectionViewLayout: UICollectionViewFlowLayout())

            }

            it("initializes cells correctly") {
                let container = Container()
                container.autoregister(TestStringCellVM.self, initializer: TestStringCellVM.init)

                let data = Property<[Identifiable]>(["item1", "item2", TestVMCellVM()])

                data.bind(to: collectionView, with: container) { registrator in
                    registrator.register(for: String.self,
                                         register: TestStringCell.self,
                                         with: SizeInfo())

                    registrator.register(register: TestVMCell.self,
                                        with: SizeInfo())

                }.dispose(in: bag)

                expect(collectionView.numberOfSections).to(be(1))
                expect(collectionView.numberOfItems(inSection: 0)).to(be(data.value.count))

                let stringCell = collectionView.cellForItem(at: IndexPath(row: 0, section: 0))
                expect(stringCell).notTo(beNil())
                expect(stringCell).to(beAnInstanceOf(TestStringCell.self))

                let idCell = collectionView.cellForItem(at: IndexPath(row: 2, section: 0))
                expect(idCell).notTo(beNil())
                expect(idCell).to(beAnInstanceOf(TestVMCell.self))

            }
        }
    }
}
