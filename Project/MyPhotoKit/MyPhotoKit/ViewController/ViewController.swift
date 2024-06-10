//
//  ViewController.swift
//  MyPhotoKit
//
//  Created by 구태호 on 6/10/24.
//

import UIKit
import Then
import SnapKit
import Photos
import PhotosUI


class ViewController: UIViewController {
    lazy var gridCollectionView = UICollectionView(frame: .zero, collectionViewLayout: .init()).then {
        $0.delegate = self
        $0.dataSource = self
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumInteritemSpacing = 10
        flowLayout.minimumLineSpacing = 10
        $0.collectionViewLayout = flowLayout
        $0.contentInset = .init(top: 10, left: 10, bottom: 10, right: 10)
        $0.register(GridCollectionViewCell.self, forCellWithReuseIdentifier: "GridCollectionViewCell")
    }
    
    let btShowPicker = UIButton(configuration: .filled()).then {
        $0.configuration?.title = "피커 표시하기"
    }
    
    let btGetPhotos = UIButton(configuration: .filled()).then {
        $0.configuration?.title = "사진 가져오기"
    }
    
    var pickerViewController: PHPickerViewController!
    
    var gridImages = [PHAsset]()
    lazy var manager = PhotosManager(delegate: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initViews()
        initAttributes()
        binding()
        initData()
    }
    
    func initViews() {
        view.addSubviews(btShowPicker, btGetPhotos, gridCollectionView)
        btGetPhotos.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.trailing.equalToSuperview().inset(10)
        }
        
        btShowPicker.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.trailing.equalTo(btGetPhotos.snp.leading).offset(-10)
        }
        
        gridCollectionView.snp.makeConstraints {
            $0.top.equalTo(btGetPhotos.snp.bottom)
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
    
    func initAttributes() {
    }
    
    func binding() {
        btGetPhotos.addAction(.init(handler: { [weak self] _ in
            Task { await self?.manager.requestAuthorization }
        }), for: .touchUpInside)
        
        btShowPicker.addAction(.init(handler: { [weak self] _ in
            Task { 
                self?.showPhotoSelect()
            }
        }), for: .touchUpInside)
    }
    
    func initData() {
        Task {
            await manager.requestAuthorization
        }
    }
    
    func showSettingAlert() {
        let alertController = UIAlertController(title: "권한 거부됨", message: "앨범 접근이 거부 되었습니다.", preferredStyle: UIAlertController.Style.alert)
        
        let okAction = UIAlertAction(title: "설정으로 이동", style: .default) { (action) in
            guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                return
            }
            if UIApplication.shared.canOpenURL(settingsUrl) {
                UIApplication.shared.open(settingsUrl)
            }
        }
        let cancelAction = UIAlertAction(title: "확인", style: .cancel, handler: nil)
        
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        
        Task {
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    func showImagePickerVC() {
        let alertController = UIAlertController(title: "권한 제한됨", message: "일부 앨범 접근만 가능합니다.", preferredStyle: UIAlertController.Style.alert)
        let showPicker = UIAlertAction(title: "이미지 피커 표시", style: .default) { (action) in
            self.showPhotoSelect()
        }
        let moveSetting = UIAlertAction(title: "설정으로 이동", style: .default) { (action) in
            guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                return
            }
            if UIApplication.shared.canOpenURL(settingsUrl) {
                UIApplication.shared.open(settingsUrl)
            }
        }
        let cancel = UIAlertAction(title: "확인", style: .cancel, handler: nil)
        
        alertController.addAction(showPicker)
        alertController.addAction(moveSetting)
        alertController.addAction(cancel)
        
        Task {
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    func showPhotoSelect() {
        var configuration = PHPickerConfiguration(photoLibrary: PHPhotoLibrary.shared())
        configuration.selectionLimit = 5
        configuration.filter = .images
        
        pickerViewController = PHPickerViewController(configuration: configuration)
        pickerViewController.delegate = self
        self.present(self.pickerViewController, animated: true, completion: nil)
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        gridImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GridCollectionViewCell", for: indexPath) as? GridCollectionViewCell else { return .init() }
        
        let item = gridImages[indexPath.item]
        cell.configuration(item)
        return cell
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let column: Int = 3
        let sidePadding: Int = Int(collectionView.contentInset.left * 2)
        let spacingSum: Int = (column - 1) * 10
        let cellWidth = Int(collectionView.bounds.width) - sidePadding - spacingSum
        return CGSize(width: cellWidth / column, height: cellWidth / column)
    }
}

extension ViewController: PhotosDelegate {
    func statusChange(_ status: PHAuthorizationStatus) {
        switch status {
        case .authorized:
            Task {
                let photos = await manager.photos
                if let photos {
                    self.gridImages = photos
                }
                self.gridCollectionView.reloadData()
            }
        case .limited:
            Task {
                let photos = await manager.photos
                if let photos {
                    self.gridImages = photos
                }
                self.gridCollectionView.reloadData()
            }
        case .denied:
            showSettingAlert()
        default: break
        }
    }
}

extension ViewController: PHPickerViewControllerDelegate  {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true, completion: nil)
        
        let identifiers = results.compactMap(\.assetIdentifier)
        // identifier 를 통해 에셋목록 획득
        let fetchResult = PHAsset.fetchAssets(withLocalIdentifiers: identifiers, options: nil)
        fetchResult.enumerateObjects { [weak self] (asset, index, stop) -> Void in
            self?.gridImages.insert(asset, at: 0)
            self?.gridCollectionView.reloadData()
        }
        //        let itemProviders = results.map(\.itemProvider)
        //        itemProviders.filter {
        //            $0.canLoadObject(ofClass: UIImage.self)
        //        }.forEach {
        //            $0.loadObject(ofClass: UIImage.self) { [weak self] (image, error) in
        //                DispatchQueue.main.async {
        //
        //                    if let image = image as? UIImage {
        //
        //                    }
        //                }
        //            }
        //        }
    }
}

