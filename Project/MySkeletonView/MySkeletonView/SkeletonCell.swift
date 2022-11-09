//
//  SkeletonCell.swift
//  MySkeletonView
//
//  Created by 구태호 on 2022/11/09.
//

import UIKit

class SkeletonCell: UITableViewCell {

    @IBOutlet var ivThumbnail: UIImageView!
    @IBOutlet var lbTitle: UILabel!
    @IBOutlet var lbSubTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
