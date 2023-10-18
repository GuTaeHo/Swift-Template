//
//  InnerCellCollectionViewController.swift
//  MyUICollectionViewCompositionalLayout
//
//  Created by 구태호 on 2023/09/26.
//

import UIKit

/**
 좌우로 스크롤되는 콜렉션 뷰 생성 시 UILabel 의 높이를 반드시 지정해줄 것, itemSize 가 폰트에 맞게 자동 변경되는 것 확인
 */
class InnerCellCollectionViewController: UIViewController {
    @IBOutlet var collectionView: UICollectionView!
    
    enum Section: Int, CaseIterable {
        case horizontal
        case grid
    }
    
    private var items: [Category] = [
        .init(title: "감자", isShowDivide: true),
        .init(title: "고구마", isShowDivide: false),
        .init(title: "토마토", isShowDivide: false),
        .init(title: "당근", isShowDivide: false),
        .init(title: "키위", isShowDivide: false),
        .init(title: "바나나", isShowDivide: false),
        .init(title: "브로콜리", isShowDivide: false),
        .init(title: "토르티야", isShowDivide: false),
        .init(title: "레쓰비", isShowDivide: false),
        .init(title: "퀘사디아", isShowDivide: false)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK: 셀이 콜렉션 뷰 내부에 내장되어있는경우, register 작업이 필요없음
        // MARK: 단, Cell Identifier 는 반드시 등록..!! (재사용 시 필수적)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.collectionViewLayout = makeCompositionalLayout()
        collectionView.reloadData()
    }
    
    func makeHorizontalScrollLayoutSection() -> NSCollectionLayoutSection {
        // 셀(아이템) 사이즈 정의
        let itemSize = NSCollectionLayoutSize(widthDimension: .estimated(50), heightDimension: .estimated(45))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .estimated(50), heightDimension: .estimated(45))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        // MARK: orthogonalScrollingBehavior 속성은 내부적으로 UICollectionView 를 추가하여 덧대는(?) 방식을 사용함
        section.orthogonalScrollingBehavior = .continuous
        // continuousGroupLeadingBoundary 속성은 각 그룹의 leading 에서 자연스럽게 멈춤
        // section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
        section.visibleItemsInvalidationHandler = { (visibleItems, offset, env) in
            print("visibleItems \(visibleItems.first?.bounds)\noffset \(offset)\nenv \(env)")
        }
        
        return section
    }
    
    func makeGridLayoutSection(column: Int, row: Int) -> NSCollectionLayoutSection {
        let itemFractionalWidthFraction = 1.0 / Double(column)
        let groupFractionalHeightFraction = 1.0 / Double(row)
        // 아이템 간 간격
        let itemInset: CGFloat = 2.5
        
        // 아이템
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(itemFractionalWidthFraction),
            heightDimension: .fractionalHeight(1)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: itemInset, leading: itemInset, bottom: itemInset, trailing: itemInset)
        
        // 그룹
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(groupFractionalHeightFraction)
        )
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        // 섹션
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: itemInset, leading: itemInset, bottom: itemInset, trailing: itemInset)
        return section
    }
    
    /// 각 섹션 별 다른 레이아웃을 할당
    func makeCompositionalLayout() -> UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout { [weak self] (section, evv) -> NSCollectionLayoutSection? in
            switch section {
            case 0:
                return self?.makeHorizontalScrollLayoutSection()
                
            case 1:
                return self?.makeGridLayoutSection(column: 3, row: 4)
                
            default:
                return nil
            }
        }
    }
}

extension InnerCellCollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return Section.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch indexPath.section {
        case Section.horizontal.rawValue:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HorizontalScrollCollectionViewCell", for: indexPath) as? HorizontalScrollCollectionViewCell else { return .init() }
            
            cell.configuration(items[indexPath.item])
            return cell
            
        default:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GridCollectionViewCell", for: indexPath) as? GridCollectionViewCell else { return .init() }
            
            cell.configuration(items[indexPath.item])
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        items = items.enumerated().map({ (index, item) in
            var temp = item
            if index == indexPath.item {
                temp.isShowDivide = true
                return temp
            } else {
                temp.isShowDivide = false
                return temp
            }
        })
        collectionView.reloadData()
    }
}
