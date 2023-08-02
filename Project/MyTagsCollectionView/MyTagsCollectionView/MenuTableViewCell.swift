//
//  MenuTableViewCell.swift
//  MyTagsCollectionView
//
//  Created by 구태호 on 2023/08/01.
//

import UIKit


class MenuTableViewCell: UITableViewCell {
    @IBOutlet var ivThumbnail: UIImageView!
    @IBOutlet var lbTitle: UILabel!
    @IBOutlet var lbPrice: UILabel!
    
    var item: MenuOption?
    
    
    func configuration() {
        ivThumbnail.layer.cornerRadius = 6
        ivThumbnail.imageDownload(url: "https://recipe1.ezmember.co.kr/cache/recipe/2021/01/02/4093c51f12b962c7426ae4c3ec65412d1.jpg")
        
        lbTitle.text = item?.name
        
        if let price = item?.price {
            lbPrice.isHidden = false
            lbPrice.text = "+\(price)원"
        } else {
            lbPrice.isHidden = true
        }
    }
}
