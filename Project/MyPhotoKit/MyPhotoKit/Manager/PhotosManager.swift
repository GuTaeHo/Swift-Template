//
//  PhotosManager.swift
//  MyPhotoKit
//
//  Created by 구태호 on 6/10/24.
//

import UIKit
import Photos
import Combine


protocol PhotosDelegate: AnyObject {
    /// 사진 접근 권한 변경 시 호출
    func statusChange(_ status: PHAuthorizationStatus)
    /// 사진 추가 시 호출
}

class PhotosManager {
    private weak var delegate: PhotosDelegate?
    
    enum AuthorizationStatus {
        case notDetermined
        case authorized
        case rejected
    }
    
    init(delegate: PhotosDelegate) {
        self.delegate = delegate
    }
    
    /// 현재 접근 권한 반환
    public var requestAuthorization: PHAuthorizationStatus {
        get async {
            let result = await withCheckedContinuation { continuation in
                PHPhotoLibrary.requestAuthorization(for: .readWrite) { continuation.resume(returning: $0) }
            }
            
            delegate?.statusChange(result)
            return result
        }
    }
    
    /// 에셋 목록 반환
    public var photos: [PHAsset]? {
        get async {
            var assets = [PHAsset]()
            PHAsset.fetchAssets(with: nil).enumerateObjects { asset, index, stop in
                assets.append(asset)
            }
            return assets
        }
    }
    
    /// 앨범 목록 반환
    public var albums: [PHAssetCollection]? {
        get async {
            var assetsCollections = [PHAssetCollection]()
            PHAssetCollection.fetchAssetCollections(with: .album, subtype: .albumRegular, options: nil).enumerateObjects { assetsCollection, index, stop in
                assetsCollections.append(assetsCollection)
            }
            return assetsCollections
        }
    }
}
