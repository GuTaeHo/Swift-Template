//
//  PostTableViewCell.swift
//  MyUrlSession
//
//  Created by 구태호 on 3/11/24.
//

import UIKit


class PostTableViewCell: UITableViewCell {
    lazy var title: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14)
        label.textColor = .black
        return label
    }()
    
    static let identifier = "PostTableViewCell"
    
    // MARK: 테이블 뷰 셀에서 초기화 로직은 아래 형태로 작성해야함
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        initLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initLayout() {
        contentView.addSubview(title)
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: contentView.topAnchor),
            title.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            title.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            title.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    func configuration(_ item: Post?) {
        title.text = item?.name
    }
}
