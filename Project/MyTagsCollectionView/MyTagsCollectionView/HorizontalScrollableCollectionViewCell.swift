//
//  HorizontalScrollableCollectionViewCell.swift
//  MyTagsCollectionView
//
//  Created by 구태호 on 2023/08/27.
//

import UIKit

struct Filter {
    var title: String?
    var imageNames: String?
}


class HorizontalScrollableCollectionViewCell: UICollectionViewCell {
    @IBOutlet var title: UILabel!
    @IBOutlet var image: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configuration(item: Filter?) {
        title.text = item?.title
        image.image = UIImage(systemName: item!.imageNames!)
    }
}
