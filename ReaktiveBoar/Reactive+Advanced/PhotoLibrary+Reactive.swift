//
//  PhotoLibrary+Reactive.swift
//  ReaktiveBoarTests
//
//  Created by Peter Ovchinnikov on 3/20/19.
//  Copyright © 2019 Peter Ovchinnikov. All rights reserved.
//

import ReactiveKit
import Bond
import Photos
import BrightFutures

//class PhotoLibraryChangeObserver: NSObject, PHPhotoLibraryChangeObserver {
//
//    let allPhotos: Property<PHFetchResult<PHAsset>>
//    func photoLibraryDidChange(_ changeInstance: PHChange) {
//
//        guard let chageDetails = changeInstance.changeDetails(for: allPhotos.value) else {
//            return
//        }
//        allPhotos.next(chageDetails.fetchResultAfterChanges)
//    }
//    init(base: PHPhotoLibrary) {
//        allPhotos = Property(PHAsset.fetchAssets(with: .image, options: PHFetchOptions()))
//        super.init()
//        base.register(self)
//    }
//}

extension PHFetchResult where ObjectType == PHAsset {
    var array: [PHAsset] {
        var result: [PHAsset] = []
        self.enumerateObjects { object, _, _ in
            result.append(object)
        }
        return result
    }
}

public struct PHPhotoLibraryReactive {

    public func requestAuthorization() -> Future<PHAuthorizationStatus, Never> {
        let promise = Promise<PHAuthorizationStatus, Never>()
        PHPhotoLibrary.requestAuthorization { status in
            promise.success(status)
        }
        return promise.future
    }
}

public extension PHPhotoLibrary {
    static let reactive: PHPhotoLibraryReactive = PHPhotoLibraryReactive()
}

public extension ReactiveExtensions where Base: PHPhotoLibrary {
    func assets() -> SafeSignal<[PHAsset]> {
        let fetchOptions = PHFetchOptions()
        let sortOrder = [NSSortDescriptor(key: "creationDate", ascending: false)]
        fetchOptions.sortDescriptors = sortOrder
        let result = PHAsset.fetchAssets(with: .image, options: fetchOptions)
        return SafeSignal(just: result.array)

    }
}

//public extension ReactiveExtensions where Base: UIImageView {
//    var asset: Bond<PHAsset?> {
//        var requestID: PHImageRequestID?
//        return bond {ctrl, asset in
//
//            if let requestID = requestID {
//                PHImageManager.default().cancelImageRequest(requestID)
//            }
//            if let asset = asset {
//                requestID = PHImageManager.default()
//                    .requestImage(for: asset,
//                                  targetSize: ctrl.bounds.size,
//                                  contentMode: PHImageContentMode.aspectFill,
//                                  options: nil) { image, _ in
//                                    guard let image = image else {
//                                        return
//                                    }
//                                    UIView.transition(with: ctrl,
//                                                      duration: 0.1,
//                                                      options: .transitionCrossDissolve,
//                                                      animations: { ctrl.image = image },
//                                                      completion: nil)
//                }
//
//            } else {
//                UIView.transition(with: ctrl,
//                                  duration: 0.1,
//                                  options: .transitionCrossDissolve,
//                                  animations: { ctrl.image = nil },
//                                  completion: nil)
//            }
//        }
//    }
//}

public enum ImageSize {
    case def
    case spec(_ size: CGSize)
}

extension ImageSize {
    func size(def: CGSize) -> CGSize {
        switch self {
        case .def: return def
        case .spec(let size): return size
        }
    }
}

public protocol ImageProvider {
    func image(`for` size: ImageSize) -> SafeSignal<UIImage?>
}

extension UIImage: ImageProvider {
    public func image(for size: ImageSize) -> SafeSignal<UIImage?> {
        return SafeSignal(just: self)
    }
}

extension PHAsset: ImageProvider {
    public func image(for size: ImageSize) -> SafeSignal<UIImage?> {
        return SafeSignal { bbbb in

            var requestID: PHImageRequestID?
            requestID = PHImageManager.default()
                .requestImage(for: self,
                              targetSize: size.size(def: CGSize(width: self.pixelWidth, height: self.pixelHeight)),
                              contentMode: PHImageContentMode.aspectFill,
                              options: nil) { image, _ in
                                bbbb.next(image)

            }
            return BlockDisposable {
                if let requestID = requestID {
                    PHImageManager.default().cancelImageRequest(requestID)
                }
            }
        }
    }
}
