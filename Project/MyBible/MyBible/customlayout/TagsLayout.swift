//
//  TagsLayout.swift
//  MyBible
//
//  Created by 구태호 on 2023/04/10.
//

import UIKit

/**
    UICollectionView 의 레이아웃을 태그 형태로 변경
    - note: 콜렉션 뷰 셀을 커스텀하기 위해선 UICollectionViewFlowLayout을 상속 받아 하위 메소드를 오버라이딩 해주면 됨
    - 참고 문서: https://engineering.linecorp.com/ko/blog/ios-refactoring-uicollectionview-1
 */

class TagsLayout: UICollectionViewFlowLayout {
    
    required override init() {
        super.init()
        common()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        common()
    }
    
    private func common() {
        estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        minimumLineSpacing = 10
        minimumInteritemSpacing = 10
    }
    
    /// - note: 레이아웃이 준비 된 후, UICollectionView가 필요한 레이아웃 속성을 요청하며, 아래 메소드를 통해 그 속성을 지정할 수 있음
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        // 영역에 해당하는 속성(셀 사이즈, 인셋, 간격... 등) 획득
        guard let att = super.layoutAttributesForElements(in: rect) else {
            return []
        }
        
        
        var x: CGFloat = sectionInset.left
        var y: CGFloat = -1.0
        
        for a in att {
            if a.representedElementCategory != .cell { continue }
            
            if a.frame.origin.y >= y {
                x = sectionInset.left
            }
            
            a.frame.origin.x = x
            x += a.frame.width + minimumInteritemSpacing
            y = a.frame.maxY
        }
        
        return att
    }
}
