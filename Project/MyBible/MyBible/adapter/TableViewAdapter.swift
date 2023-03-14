//
//  TableViewAdapter.swift
//  MyBible
//
//  Created by 구태호 on 2023/03/11.
//

import UIKit


class TableViewAdapter<T> {
    public var items = [T]()
    
    /// 단일 cell layout xib 등록
    init(tableView: UITableView, nib: UINib, forCellReuseIdentifier identifier: String) {
        tableView.register(nib, forCellReuseIdentifier: identifier)
    }
    
    /// 다수의 cell layout xib 등록
    init(tableView: UITableView, nibs: [UINib], forCellReuseIdentifiers identifiers: [String]) {
        for i in 0..<nibs.count {
            tableView.register(nibs[i], forCellReuseIdentifier: identifiers[i])
        }
    }
    
    /// 어댑터 아이템 초기화
    /// - parameter items: 초기화할 아이템 배열
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
        if items.count < at { return LogUtil.print(message: "테이블에 아이템을 추가할 수 없습니다...\n해당 인덱스는 테이블 아이템 개수를 넘어섭니다...", context: self, methodName: "addItem")}
        
        self.items.insert(contentsOf: items, at: at)
    }
    
    public func addItem(item: T) {
        self.items.append(item)
    }
    
    /// - warning: 저장된 개수보다 큰 위치 지정 시 무시됨!
    public func addItem(item: T, at: Int) {
        if items.count < at { return  }
        self.items.insert(item, at: at)
    }
    
    /// 어댑터에 저장된 아이템 개수 반환
    public func getItemCount() -> Int {
        return items.count
    }
    
    /// 어댑터에 저장된 아이템 반환
    /// - parameter index: 획득할 아이템 위치
    /// - warning: 어댑터에 저장된 아이템의 개수보다 index 가 작으면 동작하지 않음!
    public func getItem(index: Int) -> T? {
        if items.count == 0 { return nil }
        
        return items[index]
    }
    
    
    /// 어댑터에 저장된 아이템 전부 반환
    public func getItems() -> [T] {
        return items
    }
    
    /// 어댑터에 저장된 아이템 전부 제거
    public func clearItems() {
        items.removeAll()
    }
    
    /// 어댑터에 저장된 아이템 제거
    /// - parameter index: 제거할 아이템 위치
    /// - warning: 어댑터에 저장된 아이템의 개수보다 index 가 작으면 동작하지 않음!
    public func removeItem(index: Int) {
        if items.count == 0 { return }
        
        items.remove(at: index)
    }
    
    /// 어댑터에 저장된 아이템 갱신
    /// - parameter index: 갱신할 아이템 위치
    /// - parameter item: 대체할 아이템 객체
    /// - warning: 어댑터에 저장된 아이템의 개수보다 index 가 작으면 동작하지 않음!
    public func updateItem(index: Int, item: T) {
        if items.count == 0 { return }
        
        items[index] = item
    }
}
