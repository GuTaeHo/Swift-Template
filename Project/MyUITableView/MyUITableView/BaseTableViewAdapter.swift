//
//  BaseTableViewAdapter.swift
//  MyTableViewSectionHeaderAndFooterView
//
//  Created by 구태호 on 2022/11/29.
//

import UIKit


class BaseTableViewAdapter<T> {
    public var items = [T]()
    
    // 단일 cell layout xib 등록
    init(tableView: UITableView, nib: UINib, forCellReuseIdentifier identifier: String) {
        tableView.register(nib, forCellReuseIdentifier: identifier)
    }
    
    // 다수의 cell layout xib 등록
    init(tableView: UITableView, nibs: [UINib], forCellReuseIdentifiers identifiers: [String]) {
        for i in 0..<nibs.count {
            tableView.register(nibs[i], forCellReuseIdentifier: identifiers[i])
        }
    }
    
    public func initItems(items: [T]) {
        self.items.removeAll()
        
        for item in items {
            self.items.append(item)
        }
    }
    
    public func addItems(items: [T]) {
        self.items.append(contentsOf: items)
    }
    
    public func addItems(items: [T], at: Int) {
        self.items.insert(contentsOf: items, at: at)
    }
    
    public func addItem(item: T) {
        self.items.append(item)
    }
    
    public func addItem(item: T, at: Int) {
        self.items.insert(item, at: at)
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
        items.removeAll()
    }
    
    public func removeItem(index: Int) {
        items.remove(at: index)
    }
    
    public func updateItem(index: Int, item: T) {
        items[index] = item
    }
}
