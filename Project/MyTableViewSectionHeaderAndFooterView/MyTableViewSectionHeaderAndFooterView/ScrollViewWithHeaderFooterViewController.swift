//
//  ScrollViewWithHeaderFooterViewController.swift
//  MyTableViewSectionHeaderAndFooterView
//
//  Created by 구태호 on 2022/11/30.
//

import UIKit

class ScrollViewWithHeaderFooterViewController: UIViewController {
    
    @IBOutlet var headerView: UIView!
    @IBOutlet var testTableView: UITableView!
    @IBOutlet var footerView: UIView!
    
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
        
        testTableView.reloadData()
    }
}

extension ScrollViewWithHeaderFooterViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return testTableViewAdapter.getItemCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return testTableViewAdapter.tableView(tableView, cellForRowAt: indexPath)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        testTableView.snp.remakeConstraints {
            $0.height.equalTo(self.testTableView.contentSize.height)
        }
        testTableView.layoutIfNeeded()
    }
}
