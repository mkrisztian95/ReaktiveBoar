//
//  PhotoLibrary+ReactiveSpec.swift
//  ReaktiveBoarTests
//
//  Created by Peter Ovchinnikov on 3/20/19.
//  Copyright © 2019 Peter Ovchinnikov. All rights reserved.
//

import Quick
import Nimble
import ReactiveKit
import Photos
@testable import ReaktiveBoar
import BrightFutures

class PhotoLibraryReactiveSpec: QuickSpec {
    override func spec() {
        describe("PHPhotoLibrary + requestAuthorization") {
            it("should request authorization and return status") {
                guard PHPhotoLibrary.authorizationStatus() == .authorized  else {
                    return
                }

                waitUntil(timeout: 2) { done in
                    PHPhotoLibrary.reactive.requestAuthorization().onSuccess { value in
                        expect(value).to(equal(PHAuthorizationStatus.authorized))
                        done()
                    }
                }
            }
        }

        describe("PHPhotoLibrary + reactive + assets") {
            it("should return non empty array of assets") {
                guard PHPhotoLibrary.authorizationStatus() == .authorized  else {
                    return
                }

                waitUntil(timeout: 2) { done in
                    _ = PHPhotoLibrary.shared().reactive.assets()
                        .observeNext { assets in
                            expect(assets).notTo(beEmpty())
                            done()
                    }
                }
            }
        }
        describe("UIImageView + reactive + asset") {
            var bag: DisposeBag!
            beforeEach {
                bag?.dispose()
                bag = DisposeBag()
            }

//            it("should assign relevant image to imageView") {
//
//                guard PHPhotoLibrary.authorizationStatus() == .authorized  else {
//                    return
//                }
//
//                let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
//
//                let asset = PHAsset.fetchAssets(with: .image, options: nil).array.first!
//                let property = Property<ImageProvider?>(asset)
//                    property.bind(to: imageView.reactive.asset)
//                    .dispose(in: bag)
//
//                expect(imageView.image).toEventuallyNot(beNil())
//                justSleep(.seconds(1))
//                property.value = nil
//                justSleep(.seconds(1))
//                expect(imageView.image).toEventually(beNil())
//            }
        }

    }
}
