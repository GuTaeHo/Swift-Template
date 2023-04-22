//
//  TagsCollectionViewCell.swift
//  MyBible
//
//  Created by 구태호 on 2023/04/10.
//

import UIKit

class TagsCollectionViewCell: UICollectionViewCell {

    @IBOutlet var containerView: UIView!
    @IBOutlet var lbTag: UILabel!
    
    var item: Tag?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func configuration() {
        guard let item = item else { return }
        
        containerView.cornerRadius = containerView.frame.height / 2
        
        containerView.backgroundColor = item.backgroundColor
        lbTag.text = "\(item.number ?? 0)"
    }
}
