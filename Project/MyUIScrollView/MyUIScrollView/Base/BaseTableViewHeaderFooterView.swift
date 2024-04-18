//
//  BaseTableViewHeaderFooterView.swift
//  MyUIScrollView
//
//  Created by 구태호 on 4/18/24.
//

import UIKit


class BaseTableViewHeaderFooterView: UITableViewHeaderFooterView, UICodeBasable {
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        initSubviews()
        initAttributes()
        bindViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initSubviews() { }
    
    func initAttributes() { }
    
    func bindViews() { }
}
