//
//  CodeBaseCollectionViewController.swift
//  MyUIScrollView
//
//  Created by 구태호 on 10/21/23.
//

import UIKit
import SnapKit
import Then
import Combine

class CodeBaseCollectionViewController: UIViewController {
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: makeCollectionViewLayout()).then {
        $0.dataSource = self
        $0.delegate = self
        // 셀 식별을 위한 클래스 파일 등록
        $0.registerCell(CodeBaseHorizontalCollectionViewCell.self)
        $0.registerCell(CodeBaseGridCollectionViewCell.self)
        // 보충 뷰 식별을 위한 클래스 파일 등록
        $0.registerSupplementaryView(CodeBaseHorizontalCollectionReuseableView.self, ofKind: UICollectionView.elementKindSectionHeader)
        $0.registerSupplementaryView(CodeBaseGridCollectionReusableView.self, ofKind: UICollectionView.elementKindSectionHeader)
    }
    
    enum SectionHeaderKind: Int, CaseIterable {
        case food, recents
        
        var description: String {
            switch self {
            case .recents:
                return "최근검색"
            case .food:
                return "추천음식"
            }
        }
    }
    
    private var recentItems: [String] = ["감자", "퀘사디아"]
    
    private var foodItems: [Category] = [
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
    
    var cancellables: Set<AnyCancellable> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func makeCollectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            
            guard let sectionKind = SectionHeaderKind(rawValue: sectionIndex) else { return nil }
            
            switch sectionKind {
            case .recents:
                let itemSize = NSCollectionLayoutSize(widthDimension: .estimated(200), heightDimension: .fractionalHeight(1))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                
                let groupSize = NSCollectionLayoutSize(widthDimension: .estimated(200), heightDimension: .absolute(44))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = .init(top: 0, leading: 12, bottom: 0, trailing: 12)
                // 그룹 사이 간격을 지정합니다.
                section.interGroupSpacing = 10
                section.orthogonalScrollingBehavior = .continuous
                
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
                
            case .food:
                let itemSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0 / Double(3)),
                    heightDimension: .fractionalHeight(1.0)
                )
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                
                let groupSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .fractionalWidth(1.0 / CGFloat(3))
                )
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                group.interItemSpacing = .fixed(10)
                
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = NSDirectionalEdgeInsets(top: 4, leading: 0, bottom: 4, trailing: 0)
                section.interGroupSpacing = 10
                section.contentInsets = .init(top: 0, leading: 12, bottom: 0, trailing: 12)
                
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
        
        return layout
    }
}

extension CodeBaseCollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return SectionHeaderKind.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let sectionKind = SectionHeaderKind(rawValue: section) else { return 0 }
        switch sectionKind {
        case .recents:
            return recentItems.count
        case .food:
            return foodItems.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let sectionKind = SectionHeaderKind(rawValue: indexPath.section) else { return .init() }
    
        switch sectionKind {
        case .recents:
            let cell = collectionView.dequeueCell(CodeBaseHorizontalCollectionViewCell.self, for: indexPath)
            cell.configuration(foodItems[indexPath.item])
            return cell
        case .food:
            let cell = collectionView.dequeueCell(CodeBaseGridCollectionViewCell.self, for: indexPath)
            cell.configuration(foodItems[indexPath.item])
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let sectionKind = SectionHeaderKind(rawValue: indexPath.section) else { return }
        switch sectionKind {
        case .recents:
            break
        case .food:
            let cell = collectionView.dequeueCell(CodeBaseGridCollectionViewCell.self, for: indexPath)
            print(cell.lbTitle.text ?? "" + "쉐이크!")
            cell.shake()
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                cell.stopShaking()
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let sectionKind = SectionHeaderKind(rawValue: indexPath.section) else { return .init() }
        switch sectionKind {
        case .recents:
            let cell = collectionView.dequeueSupplementaryView(CodeBaseHorizontalCollectionReuseableView.self, ofKind: UICollectionView.elementKindSectionHeader, for: indexPath)
            cell.configuration(sectionKind.description)
            return cell
            
        case .food:
            let cell = collectionView.dequeueSupplementaryView(CodeBaseGridCollectionReusableView.self, ofKind: UICollectionView.elementKindSectionHeader, for: indexPath)
            cell.configuration(sectionKind.description)
            cell.btEdit.eventPublisher.sink { [weak self] _ in
                self?.collectionView.performBatchUpdates {
                    if let items = self?.foodItems {
                        self?.foodItems.removeAll()
                        
                        let indexPaths = items.enumerated().map { index, element in
                            IndexPath(item: index, section: indexPath.section)
                        }
                        self?.collectionView.deleteItems(at: indexPaths)
                    }
                } completion: { [weak self] _ in
                    self?.collectionView.numberOfItems(inSection: indexPath.item)
                }
            }.store(in: &cancellables)
            
            return cell
        }
    }
}
