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
        
        let header = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 150))
        let footer = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 150))
        
        header.backgroundColor = .systemOrange
        footer.backgroundColor = .systemTeal
//        let headerLabel = UILabel(frame: header.bounds)
//        headerLabel.text = "testTableView.tableHeaderView\n프로퍼티를 이용한 헤더 뷰"
//        headerLabel.numberOfLines = 0
//        headerLabel.textAlignment = .center
//        header.addSubview(headerLabel)
        
        let headerButton = UIButton(type: .system)
        headerButton.configuration = .filled()
        headerButton.setTitle("스크롤 뷰로 만들어진 헤더뷰로 이동", for: .normal)
        headerButton.addTarget(self, action: #selector(onClickButton(_:)), for: .touchUpInside)
        header.addSubview(headerButton)
        headerButton.snp.remakeConstraints {
            $0.edges.equalToSuperview().inset(32)
        }
        
        header.layoutIfNeeded()
        
        let footerLabel = UILabel(frame: footer.bounds)
        footerLabel.text = "testTableView.tableHeaderView\n프로퍼티를 이용한 푸터 뷰"
        footerLabel.numberOfLines = 0
        footerLabel.textAlignment = .center
        footer.addSubview(footerLabel)
        
        testTableView.tableHeaderView = header
        testTableView.tableFooterView = footer
        testTableView.layoutIfNeeded()
        testTableView.reloadData()
    }
    
    @objc func onClickButton(_ sender: UIButton) {
        if let viewController = self.storyboard?.instantiateViewController(withIdentifier: "ScrollViewWithHeaderFooterViewController") as? ScrollViewWithHeaderFooterViewController {
            present(viewController, animated: true)
        }
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

