//
//  TableViewController.swift
//  MyCodeBaseViews
//
//  Created by 구태호 on 11/20/23.
//

import UIKit
import SnapKit
import Then


class TableViewController: BaseViewController {
    let menu =
    Menu(name: "감자스프", thumbNailUrl: "https://recipe1.ezmember.co.kr/cache/recipe/2021/01/02/4093c51f12b962c7426ae4c3ec65412d1.jpg", menuGroup: [
        MenuGroup(name: "맵기 단계", summary: "취향에 맞게 맵기를 선택해주세요! !.!", options: [
            MenuOption(name: "안 매워요 (진라면 순한맛...)"),
            MenuOption(name: "적당해요 (진라면 맵기)"),
            MenuOption(name: "약간 매워요 (신라면 맵기)"),
            MenuOption(name: "매워요 (열라면 맵기)"),
            MenuOption(name: "많이 매워요 (불닭 볶음면 맵기)")
        ]),
        MenuGroup(name: "야채 선택", summary: "원하시는 야채를 선택해주세요! ^.^", options: [
            MenuOption(name: "당근", price: 500),
            MenuOption(name: "양파", price: 400),
            MenuOption(name: "케일", price: 200),
            MenuOption(name: "순무", price: 500),
            MenuOption(name: "마늘", price: 300)
        ]),
        MenuGroup(name: "조미료 선택", summary: "원하시는 조미료를 선택해주세요! >.< (선택하지않아도 간이 되어있어요)", options: [
            MenuOption(name: "후추", price: 200),
            MenuOption(name: "소금", price: 200),
            MenuOption(name: "사워크림", price: 400),
            MenuOption(name: "생크림", price: 300)
        ]),
        MenuGroup(name: "수프 농도", summary: "원하시는 농도를 선택해주세요! @_@", options: [
            MenuOption(name: "묽게 (컵에 담아 마셔도 좋아요)"),
            MenuOption(name: "적당하게 (일반적인 농도예요)"),
            MenuOption(name: "진하게 (빵에 찍어먹기 좋아요)"),
            MenuOption(name: "고체와 액체의 그 사이 어딘가")
        ]),
    ])
    
    let tableView = UITableView().then {
        // 코드 베이스로 구현 시, register(_ cellClass:forCellReuseIdentifier:) 구현
        // MARK: cellClass 는 반드시 UITableViewCell 을 서브클래싱하는 클래스여야한다.
        $0.register(MenuTableViewCell.self, forCellReuseIdentifier: MenuTableViewCell.className)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initLayout()
    }
    
    private func initLayout() {
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

extension TableViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionHeaderView = UIView().then {
            $0.backgroundColor = .lightGray
        }
        
        let titleLabel = UILabel().then {
            $0.text = menu.menuGroup?[section].name
        }
        
        sectionHeaderView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(6)
            $0.leading.trailing.equalToSuperview().inset(12)
        }
        
        return sectionHeaderView
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
