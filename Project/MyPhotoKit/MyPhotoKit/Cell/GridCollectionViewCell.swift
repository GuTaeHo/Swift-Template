//
//  GridCollectionViewCell.swift
//  MyPhotoKit
//
//  Created by 구태호 on 6/10/24.
//

import UIKit
import SnapKit
import Then
import Photos


class GridCollectionViewCell: UICollectionViewCell {
    let ivThumbnail = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initViews() {
        contentView.addSubview(ivThumbnail)
        ivThumbnail.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func configuration(_ item: PHAsset) {
        PHImageManager.default().requestImage(for: item, targetSize: .init(width: self.bounds.width * UIScreen.main.scale, height: self.bounds.height * UIScreen.main.scale), contentMode: .aspectFill, options: nil) { [weak self] (image, dictionary) in
            self?.ivThumbnail.image = image
        }
    }
}
