//
//  PageVCInTableViewController.swift
//  MyCodeBaseViews
//
//  Created by 구태호 on 11/23/23.
//

import UIKit


class PageVCInTableViewController: BaseViewController {
    let sectionTitles = ["메뉴", "정보", "리뷰"]
    
    let tableView = UITableView().then {
        // 코드 베이스로 구현 시, register(_ cellClass:forCellReuseIdentifier:) 구현
        // MARK: cellClass 는 반드시 UITableViewCell 을 서브클래싱하는 클래스여야한다.
        $0.register(MenuTableViewCell.self, forCellReuseIdentifier: MenuTableViewCell.className)
    }
    
    
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
