//
//  ContactsTableViewCell.swift
//  MyCoreData
//
//  Created by 구태호 on 2023/01/20.
//

import UIKit

class ContactsTableViewCell: UITableViewCell {

    @IBOutlet var lbName: UILabel!
    @IBOutlet var lbPhoneNumber: UILabel!
    @IBOutlet var lbEtc: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
