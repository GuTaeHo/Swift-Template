//
//  MenuTableViewCell.swift
//  MyCodeBaseViews
//
//  Created by 구태호 on 11/21/23.
//

import UIKit
import SnapKit
import Then


class MenuTableViewCell: UITableViewCell {
    let stackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 12
    }
    
    let lbTitle = UILabel().then {
        $0.text = "타이틀"
        $0.textAlignment = .left
    }
    
    let lbPrice = UILabel().then {
        $0.text = "+500원"
        $0.textAlignment = .right
        $0.setContentHuggingPriority(.defaultHigh, for: .horizontal)
    }
    
    // 코드 베이스로 구현 시, 이니셜라이저에서 reuseIdentifier 를 초기화 시킨다.
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(stackView)
        stackView.addArrangedSubviews(lbTitle, lbPrice)
        
        stackView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(12)
            $0.leading.trailing.equalToSuperview().inset(18)
        }
    }
    
    // 코드 베이스, 별도 구현 X
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configuration(item: MenuOption?) {
        lbTitle.text = item?.name
        
        if let price = item?.price {
            lbPrice.isHidden = false
            lbPrice.text = "+\(price)원"
        } else {
            lbPrice.isHidden = true
        }
    }
}
