//
//  CommonTableViewCell.swift
//  MyBible
//
//  Created by 구태호 on 2023/04/10.
//

import UIKit

class CommonTableViewCell: UITableViewCell {

    @IBOutlet weak var lbCode: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var item: Dummy?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(TagsCollectionViewCell.self, forCellWithReuseIdentifier: "TagsCollectionViewCell")
        collectionView.collectionViewLayout = TagsLayout()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configuration() {
        guard let item = item else { return }
        
        lbCode.text = "코드: \(item.code ?? 0)"
        collectionView.reloadData()
    }
}

extension CommonTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return item?.tags?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TagsCollectionViewCell", for: indexPath) as? TagsCollectionViewCell else { return UICollectionViewCell() }
        
        let item = item?.tags?[indexPath.item]
        cell.item = item
        cell.configuration()
        
        return cell
    }
}
