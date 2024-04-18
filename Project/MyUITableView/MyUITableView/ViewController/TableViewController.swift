//
//  TableViewController.swift
//  MyTableViewSectionHeaderAndFooterView
//
//  Created by 구태호 on 2022/11/29.
//

import UIKit
import Then
import SnapKit

class TableViewController: BaseViewController, UICodeBasable {
    lazy var testTableView = UITableView(frame: .zero, style: .insetGrouped).then {
        $0.delegate = self
        $0.dataSource = self
        $0.registerCell(fromNib: TestTableViewCell.self)
        (0...100).forEach {
            items.append("\($0). 텍스트")
        }
    }
    
    lazy var headerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 80)).then {
        $0.backgroundColor = .systemOrange
        
        lazy var headerStackView = UIStackView(arrangedSubviews: [self.headerFirstButton, self.headerSecondButton]).then {
            $0.axis = .horizontal
            $0.distribution = .fillEqually
            $0.spacing = 16
            $0.isLayoutMarginsRelativeArrangement = true
            $0.layoutMargins = .init(top: 12, left: 18, bottom: 12, right: 18)
        }
        $0.addSubview(headerStackView)
        headerStackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    lazy var footerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 150)).then {
        $0.backgroundColor = .systemTeal
    }
    let headerFirstButton = UIButton(configuration: .filled())
    let headerSecondButton = UIButton(configuration: .filled())
    
    private var items = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initSubviews()
        initAttributes()
        bindViews()
    }
    
    func initSubviews() {
        view.addSubviews(testTableView)
        testTableView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide.snp.edges)
        }
        
        let footerLabel = UILabel(frame: footerView.bounds).then {
            $0.text = "testTableView.tableHeaderView\n프로퍼티를 이용한 푸터 뷰"
            $0.numberOfLines = 0
            $0.textAlignment = .center
        }
        footerView.addSubview(footerLabel)
        
        testTableView.setHeaderView(headerView)
        testTableView.tableFooterView = footerView
    }
    
    func initAttributes() {
        headerFirstButton.setTitle("헤더 뷰가 추가된 테이블 뷰로 이동", for: .normal)
        
        headerSecondButton.setTitle("섹션 헤더와 다중 셀을 이용한 테이블 뷰로 이동", for: .normal)
        headerSecondButton.titleLabel?.adjustsFontSizeToFitWidth = true
        
        testTableView.reloadData()
    }
    
    func bindViews() {
        headerFirstButton.addAction(for: .touchUpInside) { [weak self] _ in
            if let viewController = self?.storyboard?.instantiateViewController(withIdentifier: "ScrollViewWithHeaderFooterViewController") as? ScrollViewWithHeaderFooterViewController {
                self?.present(viewController, animated: true)
            }
        }
        
        headerSecondButton.addAction(for: .touchUpInside) { [weak self] _ in
            let vc = SectionHeaderWithVariousTypeCellsViewController()
            self?.present(vc, animated: true)
        }
    }
}

extension TableViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCell(TestTableViewCell.self, for: indexPath)
        let index = indexPath.row
        let item = items[index]
        
        cell.lbTitle.text = item
        
        return cell
    }
}

