//
//  UITableView+.swift
//  MyTableViewSectionHeaderAndFooterView
//
//  Created by 구태호 on 3/26/24.
//

import UIKit

extension UITableView {
    /// 헤더 뷰를 지정하고, 레이아웃을 업데이트 합니디.
    /// - Important: 헤더 뷰의 오토레이아웃이 완전하게 지정되어있어야 동작합니다.
    func setHeaderView(_ headerView: UIView?) {
        guard let headerView else { return }
        self.tableHeaderView = headerView
        self.tableHeaderView?.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            headerView.widthAnchor.constraint(equalTo: self.widthAnchor)
        ])
        headerView.setNeedsLayout()
        headerView.layoutIfNeeded()
        headerView.frame.size =  headerView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        self.tableHeaderView = headerView
    }
}
