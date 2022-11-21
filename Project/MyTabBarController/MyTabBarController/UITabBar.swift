//
//  UITabBar.swift
//  MyTabBarController
//
//  Created by 구태호 on 2022/11/21.
//

import UIKit

extension UITabBar {
    var TAB_BAR_TAG_IDENTIFIER: Int {
        get {
            return 65536
        }
    }
    
    /// position에 해당하는 탭에 배지(Badge) 추가
    func addBadge(position: Int) {
        // 탭의 개수가 position보다 큰지 체크
        guard let itemCount = self.items?.count, itemCount > position else {
            return
        }
        
        removeBadge(position: position)
        
        let badgeView = UILabel()
        // 태그가 서로 겹치지 않게 고유 번호 + 태그 위치 로 지정
        badgeView.tag = TAB_BAR_TAG_IDENTIFIER + position
        badgeView.clipsToBounds = true
        badgeView.layer.cornerRadius = 4
        badgeView.backgroundColor = .red
        badgeView.textColor = .white
        badgeView.textAlignment = .center
        
        let tabFrame = self.frame
        let percentX = (CGFloat(position) + 0.7) / CGFloat(itemCount)
        let x = (percentX * tabFrame.size.width).rounded(.up)
        let y = (CGFloat(0.05) * tabFrame.size.height).rounded(.up)
        
        badgeView.frame = CGRect(x: x, y: y, width: 8, height: 8)
        addSubview(badgeView)
    }
    
    @discardableResult
    func removeBadge(position: Int) -> Bool {
        for subView in self.subviews {
            if subView.tag == (TAB_BAR_TAG_IDENTIFIER + position) {
                subView.removeFromSuperview()
                return true
            }
        }
        return false
    }
}
