//
//  CodeBaseTestGridCollectionViewCell.swift
//  MyUICollectionViewCompositionalLayout
//
//  Created by 구태호 on 10/21/23.
//

import UIKit

class CodeBaseTestGridCollectionViewCell: UICollectionViewCell {
    @IBOutlet var lbTitle: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        contentView.backgroundColor = UIColor(red: CGFloat.random(in: 0...1), green: CGFloat.random(in: 0...1), blue: CGFloat.random(in: 0...1), alpha: 1.0)
        contentView.layer.cornerRadius = 10
    }

    func configuration(_ item: Category) {
        lbTitle.text = item.title
    }
}
