//
//  UIScrollView.swift
//  MyBible
//
//  Created by 구태호 on 2023/03/27.
//

import UIKit


extension UIScrollView {
    /// 원하는 좌표로 스크롤
    /// - parameter point: 스크롤 할 원하는 좌표
    /// - parameter animated: 스크롤 애니메이션 여부 (기본값: true)
    /// - note: 스크롤 애니메이션 후 원하는 작업이 필요할 경우, scrollViewDidEndScrollingAnimation Delegate 콜백에 구현할 것!
    func scrollToPoint(point: CGPoint, animated: Bool = true) {
        setContentOffset(point, animated: animated)
    }
    
    /// UIView 의 위치로 스크롤 시 사용
    /// - parameter view: 스크롤 할 뷰
    /// - parameter animated: 스크롤 애니메이션 여부
    func scrollToView(view: UIView, animated: Bool = true) {
        guard let superView = view.superview else { return }
        
        let convertedPoint = convert(view.frame.origin, from: superView)
        let point = CGPoint(x: 0, y: convertedPoint.y)
        
        /* 스크롤 가능한 최하단 Y origin 좌표 */
        let maximumScrollableYPosition = contentSize.height - bounds.height
        
        /// - note: 스크롤 가능한 최하단 좌표를 넘어버리면 최하단 좌표로 스크롤
        if point.y > maximumScrollableYPosition {
            setContentOffset(CGPoint(x: 0, y: maximumScrollableYPosition), animated: animated)
        } else {
            setContentOffset(point, animated: animated)
        }
    }
}
