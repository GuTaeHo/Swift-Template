//
//  ReviewInfomationTableViewCell.swift
//  MyUITableView
//
//  Created by 구태호 on 3/26/24.
//

import UIKit
import SnapKit
import Then


class ReviewInfomationTableViewCell: UITableViewCell {
    lazy var contentStackView = UIStackView(arrangedSubviews: [noticeView, starView]).then {
        $0.axis = .vertical
        $0.isLayoutMarginsRelativeArrangement = true
        $0.layoutMargins = .init(top: 12, left: 18, bottom: 12, right: 18)
    }
    lazy var noticeView = UIView().then {
        $0.addSubviews(<#T##view: UIView##UIView#>)
    }
    lazy var starView = UIView().then {
        
    }
    lazy var lbUserName = UILabel().then {
        $0.font = .systemFont(ofSize: 16, weight: .regular)
    }
    lazy var lbMenuName = UILabel().then {
        $0.font = .systemFont(ofSize: 16, weight: .regular)
    }
    lazy var lbContent = UILabel().then {
        $0.font = .systemFont(ofSize: 14, weight: .regular)
        $0.numberOfLines = 0
    }
    lazy var lbDate = UILabel().then {
        $0.font = .systemFont(ofSize: 14, weight: .regular)
        $0.textColor = .gray
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configuration() {
        
    }
}
