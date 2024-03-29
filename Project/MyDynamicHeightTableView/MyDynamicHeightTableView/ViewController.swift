//
//  ViewController.swift
//  MyDynamicHeightTableView
//
//  Created by 구태호 on 2023/07/04.
//

import UIKit

struct Menu {
    var name: String?
    var thumbNailUrl: String?
    var menuGroup: [MenuGroup]?
}

struct MenuGroup {
    var name: String?
    var summary: String?
    var options: [MenuOption]?
}

struct MenuOption {
    var name: String?
    var price: Int?
    var isSelected: Bool = false
}

class ViewController: UIViewController {
    
    @IBOutlet var scrollview: UIScrollView!
    @IBOutlet var ivThumbnail: UIImageView!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var tableViewHeightConstraint: NSLayoutConstraint!
    
    var menu =
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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        ivThumbnail.imageDownload(url: menu.thumbNailUrl)
        
        scrollview.refreshControl = UIRefreshControl()
        scrollview.refreshControl?.addTarget(self, action: #selector(pullDownRefresh), for: .valueChanged)
        
        tableView.sectionHeaderTopPadding = 0
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 40
        tableView.sectionHeaderHeight = UITableView.automaticDimension
        tableView.estimatedSectionHeaderHeight = 50
        tableView.reloadData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        tableViewHeightConstraint.constant = tableView.contentSize.height
    }
    
    @objc func pullDownRefresh() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.tableView.reloadData()
            self.scrollview.refreshControl?.endRefreshing()
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return menu.menuGroup?[section].name
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return menu.menuGroup?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menu.menuGroup?[section].options?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuTableViewCell", for: indexPath) as! MenuTableViewCell
        
        let sectionIndex = indexPath.section
        let rowIndex = indexPath.row
        
        cell.item = menu.menuGroup?[sectionIndex].options?[rowIndex]
        cell.configuration()
        
        return cell
    }
}

