//
//  DiffableCollectionViewCell.swift
//  MyDiffableDatasource
//
//  Created by 구태호 on 2023/09/25.
//

import UIKit

class DiffableCollectionViewCell: UICollectionViewCell {
    @IBOutlet var thumbnail: UIImageView!
    @IBOutlet var brand: UILabel!
    @IBOutlet var name: UILabel!
    @IBOutlet var price: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configuration(_ item: Product) {
        thumbnail.imageDownload(url: item.thumbnail)
        brand.text = item.brand
        name.text = item.name
        price.text = "$\(item.price)"
    }
}
