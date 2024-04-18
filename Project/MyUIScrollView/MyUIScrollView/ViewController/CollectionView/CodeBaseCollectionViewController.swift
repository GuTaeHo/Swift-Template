//
//  CodeBaseCollectionViewController.swift
//  MyUIScrollView
//
//  Created by 구태호 on 10/21/23.
//

import UIKit
import SnapKit
import Then

class CodeBaseCollectionViewController: UIViewController {
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewCompositionalLayout(section: makeGridLayoutSection(column: 3, row: 3))).then {
        $0.dataSource = self
        $0.delegate = self
        // 셀 식별을 위한 Nib 파일 등록
        $0.registerCellByNib(CodeBaseTestGridCollectionViewCell.self)
        // 보충 뷰 식별을 위한 Nib 파일 등록
        $0.registerSupplementaryViewByNib(CodeBaseCollectionReusableView.self, ofKind: UICollectionView.elementKindSectionHeader)
    }
    
    private var headerItems: [Category] = [
        .init(title: "배고프다")
    ]
    
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
        view.backgroundColor = .white
        
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func makeGridLayoutSection(column: Int, row: Int) -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0 / Double(column)),
            heightDimension: .fractionalHeight(1.0)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalWidth(1.0 / CGFloat(column))
        )
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.interItemSpacing = .fixed(10)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 4, leading: 0, bottom: 4, trailing: 0)
        section.interGroupSpacing = 10
        section.contentInsets = .init(top: 0, leading: 12, bottom: 0, trailing: 18)
        
        // 헤더 뷰 사이즈 지정
        let headerFooterSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                     heightDimension: .estimated(44))
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerFooterSize,
            elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        // 헤더 뷰 상단고정 여부
        sectionHeader.pinToVisibleBounds = true
        section.boundarySupplementaryItems = [sectionHeader]
        
        return section
    }
}

extension CodeBaseCollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCell(CodeBaseTestGridCollectionViewCell.self, for: indexPath)
        cell.configuration(items[indexPath.item])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.dequeueCell(CodeBaseTestGridCollectionViewCell.self, for: indexPath)
        print(cell.lbTitle.text ?? "" + "쉐이크!")
        cell.shake()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            cell.stopShaking()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let cell = collectionView.dequeueSupplementaryView(CodeBaseCollectionReusableView.self, ofKind: UICollectionView.elementKindSectionHeader, for: indexPath)
        cell.configuration(headerItems[indexPath.item])
        
        return cell
    }
}
