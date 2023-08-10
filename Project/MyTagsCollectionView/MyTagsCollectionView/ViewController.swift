//
//  ViewController.swift
//  MyTagsCollectionView
//
//  Created by 구태호 on 2023/08/01.
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
    
    @IBOutlet var tableView: UITableView!
    
    var menu =
    Menu(name: "감자스프", thumbNailUrl: "https://recipe1.ezmember.co.kr/cache/recipe/2021/01/02/4093c51f12b962c7426ae4c3ec65412d1.jpg", menuGroup: [
        MenuGroup(name: "태그 리스트로 이동", options: [
            MenuOption(name: "태그 리스트로 이동!")
        ]),
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
        MenuGroup(name: "연소자의 근로는 특별한 보호를 받는다. 국가는 균형있는 국민경제의 성장 및 안정과 적정한 소득의 분배를 유지하고, 시장의 지배와 경제력의 남용을 방지하며, 경제주체간의 조화를 통한 경제의 민주화를 위하여 경제에 관한 규제와 조정을 할 수 있다.", summary: "국가원로자문회의의 의장은 직전대통령이 된다. 다만, 직전대통령이 없을 때에는 대통령이 지명한다. 국가는 주택개발정책등을 통하여 모든 국민이 쾌적한 주거생활을 할 수 있도록 노력하여야 한다.", options: [
            MenuOption(name: "대통령은 헌법과 법률이 정하는 바에 의하여 국군을 통수한다. 일반사면을 명하려면 국회의 동의를 얻어야 한다. 제2항과 제3항의 처분에 대하여는 법원에 제소할 수 없다.", price: 4294967295),
            MenuOption(name: "대한민국의 국민이 되는 요건은 법률로 정한다. 국민의 자유와 권리는 헌법에 열거되지 아니한 이유로 경시되지 아니한다. 국회의원은 그 지위를 남용하여 국가·공공단체 또는 기업체와의 계약이나 그 처분에 의하여 재산상의 권리·이익 또는 직위를 취득하거나 타인을 위하여 그 취득을 알선할 수 없다.", price: 9223372036854775807),
            MenuOption(name: "제3항의 승인을 얻지 못한 때에는 그 처분 또는 명령은 그때부터 효력을 상실한다. 이 경우 그 명령에 의하여 개정 또는 폐지되었던 법률은 그 명령이 승인을 얻지 못한 때부터 당연히 효력을 회복한다."),
            MenuOption(name: "국가는 건전한 소비행위를 계도하고 생산품의 품질향상을 촉구하기 위한 소비자보호운동을 법률이 정하는 바에 의하여 보장한다. 이 헌법은 1988년 2월 25일부터 시행한다. 다만, 이 헌법을 시행하기 위하여 필요한 법률의 제정·개정과 이 헌법에 의한 대통령 및 국회의원의 선거 기타 이 헌법시행에 관한 준비는 이 헌법시행 전에 할 수 있다.")
        ]),
    ])
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.addTarget(self, action: #selector(pullDownRefresh), for: .valueChanged)
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
        
        // tableViewHeightConstraint.constant = tableView.contentSize.height
    }
    
    @objc func pullDownRefresh() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.tableView.refreshControl?.endRefreshing()
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    /// 섹션 커스텀 뷰 적용
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        // 1. 섹션 헤더 명은 메뉴 그룹 명
        let menuGroupName = menu.menuGroup?[section].name
        
        let headerView = UITableViewHeaderFooterView()
        headerView.backgroundView = {
            let view = UIView()
            view.backgroundColor = .lightGray
            return view
        }()
        
        let label: UILabel = {
            let label = UILabel()
            label.font = .systemFont(ofSize: 20)
            label.text = menuGroupName
            label.textColor = .gray
            label.numberOfLines = 0
            // 2. 사용자 오토레이아웃 지정을 위한 mask false
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        
        headerView.contentView.addSubview(label)
        
        // 3. 레이아웃 지정, iOS 8 부터 추가된 동적 셀 높이는 정확하게 오토레이아웃 지정되어있어야 동작함
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: headerView.contentView.leadingAnchor, constant: 18),
            label.trailingAnchor.constraint(equalTo: headerView.contentView.trailingAnchor, constant: -18),
            label.topAnchor.constraint(equalTo: headerView.contentView.topAnchor, constant: 12),
            label.bottomAnchor.constraint(equalTo: headerView.contentView.bottomAnchor, constant: -12)
        ])
        
        return headerView
        /*
         // 커스텀 섹션 셀 구현 할 경우 주석 참고
         let headerView = UIView()
         let headerCell = tableView.dequeueReusableCell(withIdentifier: "customTableCell") as! CustomTableCell
         headerView.addSubview(headerCell)
         return headerView
         */
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return menu.menuGroup?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menu.menuGroup?[section].options?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 && indexPath.row == 0 {
            performSegue(withIdentifier: "TagsViewSegue", sender: nil)
            return
        }
        
        tableView.reloadSections(.init(integer: indexPath.section), with: .automatic)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuTableViewCell", for: indexPath) as! MenuTableViewCell
        
        let sectionIndex = indexPath.section
        let rowIndex = indexPath.row
        
        cell.selectionStyle = .none
        cell.item = menu.menuGroup?[sectionIndex].options?[rowIndex]
        cell.configuration()
        
        return cell
    }
}



