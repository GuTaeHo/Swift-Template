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
    }

    func configuration(_ item: Category) {
        lbTitle.text = item.title
    }
}
