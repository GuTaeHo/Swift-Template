//
//  ViewController.swift
//  MyTableViewSectionHeaderAndFooterView
//
//  Created by 구태호 on 2022/11/29.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    @IBOutlet var testTableView: UITableView!
    
    private var testTableViewAdapter: TestTableViewAdapter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initLayout()
    }
    
    private func initLayout() {
        testTableViewAdapter = TestTableViewAdapter(tableView: testTableView)
        testTableView.delegate = self
        testTableView.dataSource = self
        for index in 0..<100 {
            testTableViewAdapter.addItem(item: "\(index). 텍스트")
        }
        
        let header = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 80))
        let footer = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 150))
        
        header.backgroundColor = .systemOrange
        footer.backgroundColor = .systemTeal
        
        let headerFirstButton = UIButton(type: .system)
        headerFirstButton.configuration = .filled()
        headerFirstButton.setTitle("헤더 뷰가 추가된 테이블 뷰로 이동", for: .normal)
        headerFirstButton.addTarget(self, action: #selector(onClickButton(_:)), for: .touchUpInside)
        
        let headerSecondButton = UIButton(type: .system)
        headerSecondButton.configuration = .filled()
        headerSecondButton.setTitle("섹션 헤더와 다중 셀을 이용한 테이블 뷰로 이동", for: .normal)
        headerSecondButton.titleLabel?.adjustsFontSizeToFitWidth = true
        headerSecondButton.addTarget(self, action: #selector(onClickSecondButton(_:)), for: .touchUpInside)
        
        let headerStackView = UIStackView()
        headerStackView.axis = .horizontal
        headerStackView.distribution = .fillEqually
        headerStackView.spacing = 15
        
        headerStackView.addArrangedSubview(headerFirstButton)
        headerStackView.addArrangedSubview(headerSecondButton)
        
        header.addSubview(headerStackView)
        headerStackView.snp.remakeConstraints {
            $0.edges.equalToSuperview().inset(15)
        }
        
        
        let footerLabel = UILabel(frame: footer.bounds)
        footerLabel.text = "testTableView.tableHeaderView\n프로퍼티를 이용한 푸터 뷰"
        footerLabel.numberOfLines = 0
        footerLabel.textAlignment = .center
        footer.addSubview(footerLabel)
        
        testTableView.tableHeaderView = header
        testTableView.tableFooterView = footer
        testTableView.reloadData()
    }
    
    @objc func onClickButton(_ sender: UIButton) {
        if let viewController = self.storyboard?.instantiateViewController(withIdentifier: "ScrollViewWithHeaderFooterViewController") as? ScrollViewWithHeaderFooterViewController {
            present(viewController, animated: true)
        }
    }
    
    @objc func onClickSecondButton(_ sender: UIButton) {
        
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return testTableViewAdapter.getItemCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return testTableViewAdapter.tableView(tableView, cellForRowAt: indexPath)
    }
}

