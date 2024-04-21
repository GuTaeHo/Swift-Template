//
//  CodeBaseHorizontalCollectionViewCell.swift
//  MyUIScrollView
//
//  Created by 구태호 on 10/21/23.
//

import UIKit
import SnapKit
import Then

class CodeBaseHorizontalCollectionViewCell: UICollectionViewCell, UICodeBasable {
    var lbTitle = UILabel().then {
        $0.font = .systemFont(ofSize: 16)
        $0.textColor = .darkGray
    }
    
    var ivDelete = UIImageView(image: .remove).then {
        $0.setContentCompressionResistancePriority(.required, for: .horizontal)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initSubviews()
        initAttributes()
        bindViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initSubviews() {
        addSubviews(lbTitle, ivDelete)
        
        lbTitle.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview().inset(3)
            $0.leading.equalToSuperview().inset(9)
        }
        ivDelete.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(lbTitle.snp.trailing).offset(3)
            $0.trailing.equalToSuperview().inset(9)
        }
    }
    
    func initAttributes() {
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.darkGray.cgColor
        contentView.layer.cornerRadius = self.frame.height / 2
    }
    
    func bindViews() { }

    func configuration(_ item: Category) {
        lbTitle.text = item.title
    }
}
