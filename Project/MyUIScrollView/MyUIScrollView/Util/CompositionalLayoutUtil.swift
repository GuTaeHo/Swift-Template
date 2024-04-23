//
//  CompositionalLayoutUtil.swift
//  MyUIScrollView
//
//  Created by 구태호 on 4/23/24.
//

import UIKit


class CompositionalLayoutUtil: NSObject {
    static func gridLayout(column: Int, spacingBetweenItems: CGFloat = 0, contentInsets: NSDirectionalEdgeInsets = .zero, supplementaryItems: [NSCollectionLayoutBoundarySupplementaryItem] = []) -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0 / CGFloat(column)),
            heightDimension: .fractionalHeight(1.0)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalWidth(1.0 / CGFloat(3))
        )
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: column)
        group.interItemSpacing = .fixed(spacingBetweenItems)
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = spacingBetweenItems
        section.contentInsets = contentInsets
        section.boundarySupplementaryItems = supplementaryItems
        
        return section
    }
    
    static func horizontalLayout(estimatedSize: CGSize, spacingBetweenItems: CGFloat = 0, contentInsets: NSDirectionalEdgeInsets = .zero, supplementaryItems: [NSCollectionLayoutBoundarySupplementaryItem] = []) -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .estimated(estimatedSize.width), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .estimated(estimatedSize.width), heightDimension: .absolute(estimatedSize.height))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(top: 0, leading: 12, bottom: 0, trailing: 12)
        // 그룹 사이 간격을 지정합니다.
        section.interGroupSpacing = 10
        section.orthogonalScrollingBehavior = .continuous
        section.boundarySupplementaryItems = supplementaryItems
        
        return section
    }
}
