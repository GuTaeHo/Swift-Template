//
//  MainTableViewControllerCell.swift
//  MySearchController
//
//  Created by 구태호 on 2023/06/06.
//

import UIKit

class MainTableViewControllerCell: UITableViewCell {

    @IBOutlet var lbNumber: UILabel!
    @IBOutlet var lbTitle: UILabel!
    @IBOutlet var lbContent: UILabel!
    
    var item: MainTableViewCellItem?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        
    }
    
    func configuration() {
        lbNumber.text = item?.number
        lbTitle.text = item?.title
        lbContent.text = item?.content
    }
}
