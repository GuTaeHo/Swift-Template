//
//  HorizontalScrollCollectionViewCell.swift
//  MyUICollectionViewCompositionalLayout
//
//  Created by 구태호 on 2023/09/26.
//

import UIKit


class HorizontalScrollCollectionViewCell: UICollectionViewCell {
    @IBOutlet var title: UILabel!
    @IBOutlet var divideView: UIView!
    @IBOutlet var divideHeightConstraint: NSLayoutConstraint!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func configuration(_ item: Category) {
        title.text = item.title
        if item.isShowDivide {
            divideHeightConstraint.constant = 2
            divideView.backgroundColor = .systemCyan
        } else {
            divideHeightConstraint.constant = 1
            divideView.backgroundColor = .lightGray
        }
    }
}
