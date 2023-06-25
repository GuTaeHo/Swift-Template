//
//  ATypeTableViewCell.swift
//  MyLabelBaseLine
//
//  Created by 구태호 on 2023/06/25.
//

import UIKit


class ATypeTableViewCell: UITableViewCell {
    @IBOutlet var lbTitle: UILabel!
    @IBOutlet var lbContent: UILabel!
    
    var item: TableViewItem?
    
    
    func configuration() {
        lbTitle.text = item?.title
        lbContent.text = item?.content
        
        lbTitle.isHidden = true
        lbContent.isHidden = true
        
        switch item?.cellType {
        case .titleOnly:
            lbTitle.isHidden = false
            break
            
        case .contentOnly:
            lbContent.isHidden = false
            break
            
        case .titleAndContent:
            lbTitle.isHidden = false
            lbContent.isHidden = false
            break
            
        default:
            break
        }
    }
}
