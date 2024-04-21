//  CodeBaseHorizontalCollectionReuseableView.swift
//  MyUIScrollView
//
//  Created by 구태호 on 10/21/23.
//

import UIKit
import SnapKit
import Then

class CodeBaseHorizontalCollectionReuseableView: UICollectionReusableView, UICodeBasable {
    var lbTitle = UILabel().then {
        $0.font = .systemFont(ofSize: 24)
        $0.textColor = .black
    }
    
    var btEdit = UIButton(configuration: .plain()).then {
        $0.configuration?.title = "모두 삭제"
        $0.configuration?.baseForegroundColor = .systemIndigo
        $0.setContentHuggingPriority(.defaultHigh, for: .horizontal)
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
        let effect = UIBlurEffect(style: .light)
        let blurView = UIVisualEffectView(effect: effect)
        addSubviews(blurView, lbTitle, btEdit)
        blurView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        lbTitle.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.verticalEdges.equalToSuperview().inset(6)
        }
        btEdit.snp.makeConstraints {
            $0.leading.equalTo(lbTitle.snp.trailing)
            $0.bottom.equalTo(lbTitle.snp.bottom)
            $0.trailing.equalToSuperview()
        }
    }
    
    func initAttributes() { }
    
    func bindViews() { }
    
    func configuration(_ item: String) {
        lbTitle.text = item
    }
}
