//
//  CodeBaseGridCollectionViewCell.swift
//  MyUIScrollView
//
//  Created by 구태호 on 10/21/23.
//

import UIKit
import SnapKit
import Then

class CodeBaseGridCollectionViewCell: UICollectionViewCell {
    var lbTitle = UILabel().then {
        $0.font = .systemFont(ofSize: 20)
        $0.textColor = .black
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = UIColor(red: CGFloat.random(in: 0...1), green: CGFloat.random(in: 0...1), blue: CGFloat.random(in: 0...1), alpha: 1.0)
        contentView.layer.cornerRadius = 10
        
        addSubviews(lbTitle)
        
        lbTitle.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configuration(_ item: Category) {
        lbTitle.text = item.title
    }
}
