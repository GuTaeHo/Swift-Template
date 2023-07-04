//
//  MenuTableViewCell.swift
//  MyDynamicHeightTableView
//
//  Created by 구태호 on 2023/07/04.
//

import UIKit


class MenuTableViewCell: UITableViewCell {
    @IBOutlet var lbTitle: UILabel!
    @IBOutlet var lbPrice: UILabel!
    
    var item: MenuOption?
    
    
    func configuration() {
        lbTitle.text = item?.name
        
        if let price = item?.price {
            lbPrice.isHidden = false
            lbPrice.text = "+\(price)원"
        } else {
            lbPrice.isHidden = true
        }
    }
}
