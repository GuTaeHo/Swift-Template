//
//  TestTableViewAdapter.swift
//  MyTableViewSectionHeaderAndFooterView
//
//  Created by 구태호 on 2022/11/29.
//

import UIKit

class TestTableViewAdapter: BaseTableViewAdapter<String> {
    private let TEST_TABLE_VIEW_CELL = "TestTableViewCell"
    
    public var onClickClosure: ((Int) -> ())?
    
    init(tableView: UITableView) {
        let nib = UINib(nibName: TEST_TABLE_VIEW_CELL, bundle: nil)
        
        super.init(tableView: tableView, nib: nib, forCellReuseIdentifier: TEST_TABLE_VIEW_CELL)
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TEST_TABLE_VIEW_CELL, for: indexPath) as? TestTableViewCell
        else { return UITableViewCell() }
        
        let index = indexPath.row
        let item = getItem(index: index)
        
        cell.lbTitle.text = item
        
        return cell
    }
}
