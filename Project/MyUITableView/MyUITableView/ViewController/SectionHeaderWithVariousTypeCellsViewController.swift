//
//  SectionHeaderWithVariousTypeCellsViewController.swift
//  MyTableViewSectionHeaderAndFooterView
//
//  Created by 구태호 on 3/26/24.
//

import UIKit
import SnapKit
import Then


class SectionHeaderWithVariousTypeCellsViewController: UIViewController {
    lazy var tableView = UITableView().then {
        $0.sectionHeaderTopPadding = .leastNormalMagnitude
        $0.delegate = self
        $0.dataSource = self
        $0.registerCell(fromClass: ReviewInfomationTableViewCell.self)
        $0.registerCell(fromClass: ReviewTableViewCell.self)
        $0.registerHeaderFooterView(fromClass: ReviewHeaderFooterView.self)
    }
    
    enum Section {
        case info
        case review
    }
    
    var shop: Shop = Shop(imageNames: ["wand.and.stars"], content: "여긴 운영 안합니다.", starScore: 4.5, canReview: true)
    var reviews = [
        Review(userName: "구*호", menuName: "아메리카노", starScore: 3.5, content: "아메리카노 한잔 조와요", imageNames: [], date: .now),
        Review(userName: "김*환", menuName: "바닐라라떼", starScore: 4.0, content: "얼크난 바닐라라떼 한잔 주위소", imageNames: [], date: .now),
        Review(userName: "김*재", menuName: "자몽에이드", starScore: 3.0, content: "자 몽 자 자 몽 자 자 몽 자 자 몽 자 자 몽 자 자 몽 자 자 몽 자 자 몽 자 자 몽 자 자 몽 자 자 몽 자 몽", imageNames: [], date: .now),
        Review(userName: "갤*시", menuName: "아인슈페너", starScore: 0.0, content: "", imageNames: [], date: .now),
        Review(userName: "서*진", menuName: "바닐라딜라이트", starScore: 5.0, content: "딜 맛집", imageNames: [], date: .now),
        Review(userName: "10CM 10CM 10CM 10CM 10CM 10CM 10CM 70CM", menuName: "1,2,3,4,5,6,7,8,9,10", starScore: 3.5, content: "딱 십 센치만", imageNames: [], date: .now)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        tableView.reloadData()
    }
}

extension SectionHeaderWithVariousTypeCellsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return reviews.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let infoCell = tableView.dequeueCell(ReviewInfomationTableViewCell.self, for: indexPath)
            infoCell.configuration(shop)
            return infoCell
        default:
            let reviewCell = tableView.dequeueCell(ReviewTableViewCell.self, for: indexPath)
            let item = reviews[indexPath.row]
            reviewCell.configuration(item)
            return reviewCell
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = tableView.dequeueHeaderFooterView(ReviewHeaderFooterView.self)
        switch section {
        case 0:
            view.configuration("가게 정보")
        default:
            view.configuration("사용자 리뷰")
        }
        
        return view
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
}
