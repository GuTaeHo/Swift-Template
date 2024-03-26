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
    lazy var contentStackView = UIStackView(arrangedSubviews: [noticeStackView, starStackView]).then {
        $0.axis = .vertical
    }
    /* 알림 */
    lazy var noticeStackView = UIStackView(arrangedSubviews: [noticeImagesStackView, lbNoticeContent]).then {
        $0.axis = .vertical
        $0.spacing = 6
        $0.isLayoutMarginsRelativeArrangement = true
        $0.layoutMargins = .init(top: 12, left: 18, bottom: 12, right: 18)
        $0.isHidden = true
        noticeImagesStackView.snp.makeConstraints {
            $0.height.equalTo(120)
        }
    }
    lazy var noticeImagesStackView = UIStackView(arrangedSubviews: [ivImageFirst, ivImageSecond]).then {
        $0.axis = .horizontal
        $0.distribution = .fillEqually
        $0.spacing = 6
        $0.isHidden = true
    }
    lazy var ivImageFirst = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        $0.isHidden = true
        $0.layer.cornerRadius = 6
        $0.layer.borderColor = UIColor.lightGray.cgColor
        $0.layer.borderWidth = 1
    }
    lazy var ivImageSecond = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        $0.isHidden = true
        $0.layer.cornerRadius = 6
        $0.layer.borderColor = UIColor.lightGray.cgColor
        $0.layer.borderWidth = 1
    }
    lazy var lbNoticeContent = UILabel().then {
        $0.font = .systemFont(ofSize: 16, weight: .regular)
        $0.numberOfLines = 0
        $0.isHidden = true
    }
    /* 별점 */
    lazy var starStackView = UIStackView(arrangedSubviews: [scoreView, btRegistReview]).then {
        $0.axis = .vertical
        $0.spacing = 6
        $0.isLayoutMarginsRelativeArrangement = true
        $0.layoutMargins = .init(top: 12, left: 18, bottom: 12, right: 18)
    }
    lazy var scoreView = UIView().then {
        let starImageView = UIImageView(image: .init(systemName: "star.fill")).then {
            $0.image = $0.image?.withRenderingMode(.alwaysTemplate)
            $0.tintColor = .systemYellow
        }
        $0.addSubviews(starImageView, lbStarScore)
        starImageView.snp.makeConstraints {
            $0.width.equalTo(20)
            $0.height.equalTo(20)
            $0.leading.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
        lbStarScore.snp.makeConstraints {
            $0.top.bottom.trailing.equalToSuperview()
            $0.leading.equalTo(starImageView.snp.trailing).offset(4)
        }
    }
    lazy var lbStarScore = UILabel().then {
        $0.text = "0.0"
        $0.font = .systemFont(ofSize: 24, weight: .bold)
    }
    lazy var btRegistReview = UIButton(configuration: .plain()).then {
        $0.configuration?.baseForegroundColor = .systemIndigo
        $0.configuration?.title = "리뷰 등록하기"
        $0.layer.cornerRadius = 6
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.systemIndigo.cgColor
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        
        contentView.addSubview(contentStackView)
        contentStackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        btRegistReview.snp.makeConstraints {
            $0.height.equalTo(56)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configuration(_ item: Shop) {
        initVisibility()
        // 이미지 셋
        if item.imageNames.isEmpty == false {
            noticeStackView.isHidden = false
            noticeImagesStackView.isHidden = false
            
            item.imageNames.enumerated().forEach { index, item in
                if index == 0 {
                    ivImageFirst.isHidden = false
                    ivImageFirst.image = .init(systemName: item)
                } else {
                    ivImageSecond.isHidden = false
                    ivImageSecond.image = .init(systemName: item)
                }
            }
        }
        
        // 콘텐츠 셋
        if item.content.isEmpty == false {
            noticeStackView.isHidden = false
            lbNoticeContent.isHidden = false
            lbNoticeContent.text = item.content
        }
        
        lbStarScore.text = "\(item.starScore)"
        
        if item.canReview {
            btRegistReview.isHidden = false
        } else {
            btRegistReview.isHidden = true
        }
    }
    
    private func initVisibility() {
        noticeStackView.isHidden = true
        noticeImagesStackView.isHidden = true
        ivImageFirst.isHidden = true
        ivImageSecond.isHidden = true
        lbNoticeContent.isHidden = false
    }
}
