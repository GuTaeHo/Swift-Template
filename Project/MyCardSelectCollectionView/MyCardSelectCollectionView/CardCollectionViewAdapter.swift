//
//  CardCollectionViewAdapter.swift
//  MyCardSelectCollectionView
//
//  Created by 구태호 on 2022/11/22.
//

import UIKit

class CardCollectionViewAdapter: BaseCollectionViewAdapter<String> {
    private let CARD_COLLECTION_VIEW_CELL = "CardCollectionViewCell"
    
    var onClickClosure: ((String)->())?
    
    init(collectionView: UICollectionView) {
        let nibName = UINib(nibName: CARD_COLLECTION_VIEW_CELL, bundle: nil)
        
        super.init(collectionView: collectionView, nib: nibName, forCellReuseIdentifier: CARD_COLLECTION_VIEW_CELL)
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CARD_COLLECTION_VIEW_CELL, for: indexPath) as? CardCollectionViewCell
        else { return UICollectionViewCell() }
        
        let index = indexPath.item
        let item = getItem(index: index)
        
        let randomRed = CGFloat.random(in: 0...1.0)
        let randomGreen = CGFloat.random(in: 0...1.0)
        let randomBlue = CGFloat.random(in: 0...1.0)
        
        cell.contentView.backgroundColor = UIColor(red: randomRed, green: randomGreen, blue: randomBlue, alpha: 0.8)
        cell.contentView.layer.cornerRadius = 6
        
        if item != "" {
            cell.lbName.text = item
        } else {
            cell.lbName.text = "에러"
        }
        
        cell.addAction {
            self.onClickClosure?(item)
        }
        
        return cell
    }
}
