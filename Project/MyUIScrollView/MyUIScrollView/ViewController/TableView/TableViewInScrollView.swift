//
//  TableViewInScrollView.swift
//  MyUIScrollView
//
//  Created by 구태호 on 6/12/24.
//

import UIKit
import Then
import SnapKit


class TableViewInScrollView: BaseViewController, UICodeBasable {
    lazy var scrollView = UIScrollView().then {
        $0.delegate = self
    }
    lazy var containerStackView = UIStackView(arrangedSubviews: [headerView, testTableView, footerView]).then {
        $0.axis = .vertical
    }
    lazy var testTableView = SelfSizingTableView(frame: .zero, style: .plain).then {
        $0.delegate = self
        $0.dataSource = self
        $0.isUserInteractionEnabled = false
        $0.registerCell(fromNib: TestTableViewCell.self)
        (0...100).forEach {
            items.append("\($0). 텍스트")
        }
        $0.contentInset = .init(top: 12, left: 18, bottom: 12, right: 18)
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
    let headerFirstButton = UIButton(configuration: .filled()).then {
        $0.configuration?.title = "헤더 버튼 1"
    }
    
    let headerSecondButton = UIButton(configuration: .filled()).then {
        $0.configuration?.title = "헤더 버튼 2"
    }
    
    private var items = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initSubviews()
        initAttributes()
        bindViews()
    }
    
    func initSubviews() {
        view.addSubviews(scrollView)
        scrollView.addSubview(containerStackView)
        scrollView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide.snp.edges)
        }
        
        containerStackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalToSuperview()
        }
    }
    
    func initAttributes() {
        
    }
    
    func bindViews() {
//        headerFirstButton.addAction(for: .touchUpInside) { [weak self] _ in
//            if let viewController = self?.storyboard?.instantiateViewController(withIdentifier: "ScrollViewWithHeaderFooterViewController") as? ScrollViewWithHeaderFooterViewController {
//                self?.present(viewController, animated: true)
//            }
//        }
//        
//        headerSecondButton.addAction(for: .touchUpInside) { [weak self] _ in
//            let vc = SectionHeaderWithVariousTypeCellsViewController()
//            self?.present(vc, animated: true)
//        }
    }
}

extension TableViewInScrollView: UITableViewDelegate, UITableViewDataSource {
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

