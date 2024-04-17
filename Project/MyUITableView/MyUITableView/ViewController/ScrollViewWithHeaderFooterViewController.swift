//
//  ScrollViewWithHeaderFooterViewController.swift
//  MyTableViewSectionHeaderAndFooterView
//
//  Created by 구태호 on 2022/11/30.
//

import UIKit
import Combine
import SnapKit

class ScrollViewWithHeaderFooterViewController: UIViewController {
    lazy var headerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemIndigo
        view.addSubview(stackViewInHeaderView)
        stackViewInHeaderView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide.snp.edges)
        }
        return view
    }()
    
    lazy var stackViewInHeaderView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [label1InHeaderView, label2InHeaderView])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        return stackView
    }()
    
    lazy var label1InHeaderView: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "라벨 1"
        label.textColor = .white
        label.setContentHuggingPriority(.defaultHigh, for: .vertical)
        return label
    }()
    
    lazy var label2InHeaderView: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "라벨 2"
        label.textColor = .white
        return label
    }()
    
    @IBOutlet var testTableView: UITableView!
    
    private var items = [String]()
    private var cancellable = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initLayout()
    }
    
    private func initLayout() {
        (0...100).forEach {
            items.append("\($0). 텍스트")
        }
        testTableView.delegate = self
        testTableView.dataSource = self
        testTableView.setHeaderView(headerView)
        testTableView.reloadData()
        
        Timer.publish(every: 2.0, on: .main, in: .common).autoconnect().sink { [weak self] date in
            if self?.label1InHeaderView.isHidden == true {
                self?.label1InHeaderView.isHidden = false
            } else {
                self?.label1InHeaderView.isHidden = true
            }
            self?.testTableView.setHeaderView(self?.headerView)
        }.store(in: &cancellable)
    }
}

extension ScrollViewWithHeaderFooterViewController: UITableViewDelegate, UITableViewDataSource {
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
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        testTableView.snp.remakeConstraints {
            $0.height.equalTo(self.testTableView.contentSize.height)
        }
        testTableView.layoutIfNeeded()
    }
}
