//
//  BaseCollectionViewAdapter.swift
//  MyCardSelectCollectionView
//
//  Created by 구태호 on 2022/11/22.
//

import UIKit

class BaseCollectionViewAdapter<T> {
    public var items = [T]()
    
    // 단일 cell layout xib 등록
    init(collectionView: UICollectionView, nib: UINib, forCellReuseIdentifier identifier: String) {
        collectionView.register(nib, forCellWithReuseIdentifier: identifier)
    }
    
    // 다수의 cell layout xib 등록
    init(collectionView: UICollectionView, nibs: [UINib], forCellReuseIdentifiers identifiers: [String]) {
        for i in 0..<nibs.count {
            collectionView.register(nibs[i], forCellWithReuseIdentifier: identifiers[i])
        }
    }
    
    public func initItems(items: [T]) {
        self.items.removeAll()
        
        for item in items {
            self.items.append(item)
        }
    }
    
    public func addItems(items: [T]) {
        for item in items {
            self.items.append(item)
        }
    }
    
    public func addItem(item: T) {
        self.items.append(item)
    }
    
    public func addItem(item: T, index: Int) {
        self.items.insert(item, at: index)
    }
    
    public func getItemCount() -> Int {
        return items.count
    }
    
    public func getItem(index: Int) -> T {
        return items[index]
    }
    
    public func getItems() -> [T] {
        return items
    }
    
    public func clearItems() {
        self.items.removeAll()
    }
    
    public func setItem(item: T, index: Int) {
        self.items[index] = item
    }
    
    public func removeItem(index: Int) {
        self.items.remove(at: index)
    }
}
