//
//  ReviewTableViewCell.swift
//  MyUITableView
//
//  Created by 구태호 on 3/26/24.
//

import UIKit
import SnapKit
import Then


class ReviewTableViewCell: UITableViewCell {
    lazy var contentStackView = UIStackView(arrangedSubviews: [lbUserName, lbMenuName, lbContent]).then {
        $0.axis = .vertical
        $0.spacing = 6
        $0.isLayoutMarginsRelativeArrangement = true
        $0.layoutMargins = .init(top: 12, left: 18, bottom: 12, right: 18)
    }
    lazy var lbUserName = UILabel().then {
        $0.font = .systemFont(ofSize: 16, weight: .regular)
    }
    lazy var lbMenuName = UILabel().then {
        $0.font = .systemFont(ofSize: 16, weight: .medium)
    }
    lazy var lbContent = UILabel().then {
        $0.font = .systemFont(ofSize: 14, weight: .regular)
        $0.numberOfLines = 0
    }
    lazy var lbDate = UILabel().then {
        $0.font = .systemFont(ofSize: 12, weight: .regular)
        $0.textColor = .gray
    }
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubviews(contentStackView, lbDate)
        contentStackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        lbUserName.snp.makeConstraints {
            $0.trailing.equalTo(lbDate.snp.leading)
        }
        lbDate.snp.makeConstraints {
            $0.top.equalTo(contentStackView.layoutMarginsGuide.snp.top)
            $0.trailing.equalTo(contentStackView.layoutMarginsGuide.snp.trailing)
        }
    }
    
    func configuration(_ item: Review) {
        lbUserName.text = item.userName
        lbMenuName.text = item.menuName
        lbContent.text = item.content
        lbDate.text = item.date.formatted(date: .numeric, time: .omitted)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
