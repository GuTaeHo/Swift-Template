//
//  UITableView+.swift
//  MyCodeBaseViews
//
//  Created by 구태호 on 11/21/23.
//

import UIKit


extension UITableView {
    func dequeueReusableCell<T: UITableViewCell>(_ type: T.Type, for: IndexPath) -> T {
        return self.dequeueReusableCell(withIdentifier: type.className, for: `for`) as! T
    }
}


/**
 testTableView.tableHeaderView = headerView
 testTableView.tableFooterView = footerView
 */
