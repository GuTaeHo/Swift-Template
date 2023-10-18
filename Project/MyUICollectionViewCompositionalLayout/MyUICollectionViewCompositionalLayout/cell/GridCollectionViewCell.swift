//
//  GridCollectionViewCell.swift
//  MyUICollectionViewCompositionalLayout
//
//  Created by 구태호 on 10/18/23.
//

import UIKit

class GridCollectionViewCell: UICollectionViewCell {
    @IBOutlet var title: UILabel!
    @IBOutlet var divideView: UIView!
    @IBOutlet var divideHeightConstraint: NSLayoutConstraint!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func configuration(_ item: Category) {
        title.text = item.title
        contentView.backgroundColor = UIColor(red: CGFloat.random(in: 0..<1), green: CGFloat.random(in: 0..<1), blue: CGFloat.random(in: 0..<1), alpha: 1)
    }
}
