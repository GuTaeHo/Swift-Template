//
//  CodeBaseCollectionReusableView.swift
//  MyUIScrollView
//
//  Created by 구태호 on 10/21/23.
//

import UIKit
import SnapKit
import Then

class CodeBaseCollectionReusableView: UICollectionReusableView, UICodeBasable {
    var lbTitle = UILabel().then {
        $0.font = .systemFont(ofSize: 20)
        $0.textColor = .black
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
        let effect = UIBlurEffect(style: .light)
        let blurView = UIVisualEffectView(effect: effect)
        addSubviews(blurView, lbTitle)
        blurView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        lbTitle.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func initAttributes() { }
    
    func bindViews() { }
    
    func configuration(_ item: Category) {
        lbTitle.text = item.title
    }
}
