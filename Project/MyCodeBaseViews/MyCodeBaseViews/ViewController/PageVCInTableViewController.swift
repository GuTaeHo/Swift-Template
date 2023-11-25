//
//  PageVCInTableViewController.swift
//  MyCodeBaseViews
//
//  Created by 구태호 on 11/23/23.
//

import UIKit

/**
 섹션 헤더가 탭 바 형태인 뷰 컨트롤러 구현
 아이디어
  1 안
 1. 테이블 뷰 섹션과 셀은 각각 1개씩 존재
 2. 섹션은 3개의 탭으로 구성되며, 셀은 PageViewController 를 가짐
 3. 셀의 높이는 기기 높이 - 상단 바 높이 + 섹션 헤더 높이
 4. 가장 큰 문제는 외부 테이블 뷰와 내부 테이블 뷰의 스크롤이 중첩될 듯 하다. 특정 Offset 에 도달하는순간 스크롤을 스위칭해주어야 할 듯하다.
 
  2 안
 1. 테이블 뷰 섹션과 셀은 각각 1개씩 존재
 2. 섹션은 3개의 탭으로 구성되며, 셀은 PageViewController 를 가짐
 3. 셀의 높이는 기기 높이 - 상단 바 높이 + 섹션 헤더 높이
 4. 셀의 각 뷰 컨트롤러가 표시될 때 `페이저 뷰 컨트롤러 내부의 테이블 뷰 높이를 갱신` 해야함
 */

class PageVCInTableViewController: BaseViewController {
    let sectionTitles = ["메뉴", "정보", "리뷰"]
    
    let tableView = UITableView().then {
        // 코드 베이스로 구현 시, register(_ cellClass:forCellReuseIdentifier:) 구현
        // MARK: cellClass 는 반드시 UITableViewCell 을 서브클래싱하는 클래스여야한다.
        $0.register(MenuTableViewCell.self, forCellReuseIdentifier: MenuTableViewCell.className)
    }
    
//    let pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal) {
//        $0.setViewCon
//    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initTableView()
        initTableHeader()
        initTableBody()
    }
    
    private func initTableView() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.sectionHeaderTopPadding = .zero
    }
    
    private func initTableHeader() {
        let tableHeaderView = UIView().then {
            $0.backgroundColor = .darkGray
        }
        
        let tableHeaderStackView = UIStackView().then {
            $0.axis = .vertical
            $0.spacing = 10
        }
        
        let lbTableHeaderTitle = UILabel().then {
            $0.text = "테이블 뷰 헤더"
            $0.textAlignment = .center
        }
        
        let lbTableHeaderScore = UILabel().then {
            $0.text = "4.9"
            $0.textAlignment = .center
        }
        
        tableHeaderStackView.addArrangedSubviews(lbTableHeaderTitle, lbTableHeaderScore)
        tableHeaderView.addSubview(tableHeaderStackView)
        tableHeaderStackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        tableView.tableHeaderView = tableHeaderView
    }
    
    private func initTableBody() {
        
    }
}

extension PageVCInTableViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionHeaderView = UIView()
        let stackView = UIStackView().then {
            $0.axis = .horizontal
            $0.distribution = .fillEqually
        }
        
        let menuLabel = UILabel().then {
            $0.text = sectionTitles[0]
        }
        
        let infoLabel = UILabel().then {
            $0.text = sectionTitles[1]
        }
        
        let reviewLabel = UILabel().then {
            $0.text = sectionTitles[2]
        }
        
        stackView.addArrangedSubviews(menuLabel, infoLabel, reviewLabel)
        return stackView
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menu.menuGroup?[section].options?.count ?? 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return menu.menuGroup?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(MenuTableViewCell.self, for: indexPath)
        
        let menuOption = menu.menuGroup?[indexPath.section].options?[indexPath.row]
        cell.configuration(item: menuOption)
        return cell
    }
}
