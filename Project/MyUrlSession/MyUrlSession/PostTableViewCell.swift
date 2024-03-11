//
//  PostTableViewCell.swift
//  MyUrlSession
//
//  Created by 구태호 on 3/11/24.
//

import UIKit


class PostTableViewCell: UITableViewCell {
    lazy var name: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 24)
        label.numberOfLines = 0
        label.textColor = .black
        return label
    }()
    
    lazy var email: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 24)
        label.numberOfLines = 0
        label.textColor = .black
        return label
    }()
    
    lazy var body: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 20)
        label.numberOfLines = 0
        label.textColor = .darkGray
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
        contentView.addSubview(name)
        contentView.addSubview(email)
        contentView.addSubview(body)
        NSLayoutConstraint.activate([
            name.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            name.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            name.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
        NSLayoutConstraint.activate([
            email.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 12),
            email.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            email.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
        NSLayoutConstraint.activate([
            body.topAnchor.constraint(equalTo: email.bottomAnchor, constant: 12),
            body.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            body.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            body.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    func configuration(_ item: Post?) {
        name.text = item?.name
        email.text = item?.email
        body.text = item?.body
    }
}
