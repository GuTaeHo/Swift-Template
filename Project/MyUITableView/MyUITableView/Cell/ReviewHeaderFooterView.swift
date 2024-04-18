//
//  ReviewHeaderFooterView.swift
//  MyUITableView
//
//  Created by 구태호 on 3/26/24.
//

import UIKit
import SnapKit
import Then


class ReviewHeaderFooterView: BaseTableViewHeaderFooterView {
    var titleLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 20)
    }
    
    override func initSubviews() {
        super.initSubviews()
        
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(12)
        }
    }
    
    func configuration(_ item: String) {
        titleLabel.text = item
    }
}
