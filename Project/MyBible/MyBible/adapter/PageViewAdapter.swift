//
//  PageViewAdapter.swift
//  MyBible
//
//  Created by 구태호 on 2023/03/11.
//
import UIKit

class PageViewAdapter {
    public var items = [UIViewController]()
    
    public func initItems(items: [UIViewController]) {
        self.items.removeAll()
        
        for item in items {
            self.items.append(item)
        }
    }
    
    public func addItems(items: [UIViewController]) {
        for item in items {
            self.items.append(item)
        }
    }
    
    public func addItem(item: UIViewController) {
        self.items.append(item)
    }
    
    public func getItemCount() -> Int {
        return items.count
    }
    
    public func getItem(index: Int) -> UIViewController? {
        if items.count == 0 { return nil }
        
        return items[index]
    }
    
    public func getItems() -> [UIViewController] {
        return items
    }
    
    public func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard
            let viewControllerIndex = getItems().firstIndex(of: viewController)
        else {
            return nil
        }
        
        let prevIndex = viewControllerIndex - 1
        
        if prevIndex >= 0 {
            return getItem(index: prevIndex)
        } else {
            return nil
        }
    }
    
    public func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard
            let viewControllerIndex = getItems().firstIndex(of: viewController)
        else {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        
        if getItemCount() > nextIndex {
            return getItem(index: nextIndex)
        } else {
            return nil
        }
    }
}
