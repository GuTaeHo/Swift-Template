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
    
    let btGetPhotos = UIButton(configuration: .filled()).then {
        $0.configuration?.title = "사진 가져오기!"
    }
    
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
        view.addSubviews(btGetPhotos, gridCollectionView)
        btGetPhotos.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.trailing.equalToSuperview().inset(10)
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
            Task { await self?.manager.checkPermissions }
        }), for: .touchUpInside)
    }
    
    func initData() {
        Task {
            await manager.checkPermissions
        }
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
    func statusChange(_ status: PhotosManager.AuthorizationStatus) {
        switch status {
        case .authorized:
            Task {
                let photos = await manager.photos
                if let photos {
                    self.gridImages = photos
                }
                self.gridCollectionView.reloadData()
            }
        default: break
        }
    }
}

