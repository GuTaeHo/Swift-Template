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
//        $0.dataSource = self
        $0.delegate = self
        // 셀 식별을 위한 클래스 파일 등록
//        $0.registerCell(CodeBaseHorizontalCollectionViewCell.self)
//        $0.registerCell(CodeBaseGridCollectionViewCell.self)
        // 보충 뷰 식별을 위한 클래스 파일 등록
//        $0.registerSupplementaryView(CodeBaseHorizontalCollectionReuseableView.self, ofKind: UICollectionView.elementKindSectionHeader)
//        $0.registerSupplementaryView(CodeBaseGridCollectionReusableView.self, ofKind: UICollectionView.elementKindSectionHeader)
    }
    
    enum SectionHeaderKind: Int, CaseIterable {
        case recents, food
        
        var description: String {
            switch self {
            case .recents:
                return "최근검색"
            case .food:
                return "추천음식"
            }
        }
    }
    
    private var recentItems: [Category] = [.init(title: "감자", isShowDivide: true), .init(title: "퀘사디아", isShowDivide: false)]
    
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
    
    
    var dataSource: UICollectionViewDiffableDataSource<SectionHeaderKind, Category>!
    
    func configureDataSource() {
        // 수평 셀 등록
        let horizontalCellRegistration = UICollectionView.CellRegistration
        <CodeBaseHorizontalCollectionViewCell, Category> { (cell, indexPath, item) in
            // Populate the cell with our item description.
            cell.configuration(item)
        }
        // 그리드 셀 등록
        let gridCellRegistration = UICollectionView.CellRegistration
        <CodeBaseGridCollectionViewCell, Category> { (cell, indexPath, item) in
            // Populate the cell with our item description.
            cell.configuration(item)
        }
        
        let horizontalSupplementaryViewRegistration = UICollectionView.SupplementaryRegistration<CodeBaseHorizontalCollectionReuseableView>(elementKind: UICollectionView.elementKindSectionHeader) { supplementaryView, string, indexPath in
            supplementaryView.configuration(SectionHeaderKind.recents.description)
            supplementaryView.btEdit.eventPublisher.sink { [weak self] _ in
                self?.recentItems.removeAll()
                self?.collectionView.reloadData()
            }.store(in: &self.cancellables)
        }
    
        let gridSupplementaryViewRegistration = UICollectionView.SupplementaryRegistration<CodeBaseHorizontalCollectionReuseableView>(elementKind: UICollectionView.elementKindSectionHeader) { supplementaryView, string, indexPath in
            supplementaryView.configuration(SectionHeaderKind.food.description)
            supplementaryView.btEdit.eventPublisher.sink { [weak self] _ in
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
            }.store(in: &self.cancellables)
        }
        
        // ✅ DiffableDataSource 생성
        dataSource = UICollectionViewDiffableDataSource<SectionHeaderKind, Category>(collectionView: collectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, identifier: Category) -> UICollectionViewCell? in
            guard let sectionKind = SectionHeaderKind(rawValue: indexPath.section) else { return nil }
            
            switch sectionKind {
            case .recents:
                return collectionView.dequeueConfiguredReusableCell(using: horizontalCellRegistration, for: indexPath, item: identifier)
            case .food:
                return collectionView.dequeueConfiguredReusableCell(using: gridCellRegistration, for: indexPath, item: identifier)
            }
        }
        
        dataSource.supplementaryViewProvider = { collectionView, elementKind, indexPath in
            guard let sectionKind = SectionHeaderKind(rawValue: indexPath.section) else { return .init() }
            
            switch sectionKind {
            case .recents:
                return collectionView.dequeueConfiguredReusableSupplementary(using: horizontalSupplementaryViewRegistration,
                                                                             for: indexPath)
            case .food:
                return collectionView.dequeueConfiguredReusableSupplementary(using: gridSupplementaryViewRegistration, for: indexPath)
            }
        }
    }
    
    func initSnapShot() {
        // ✅ 새로운 snapshot 생성
        var snapshot = NSDiffableDataSourceSnapshot<SectionHeaderKind, Category>()
        snapshot.appendSections([.recents, .food])
        snapshot.appendItems(recentItems)
        snapshot.appendItems(foodItems)
        
        // ✅ "DiffiableDataSource야, 업데이트한 snapshot을 apply해서 View를 다시 그려줘"
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        configureDataSource()
        initSnapShot()
        collectionView.dataSource = dataSource
    }
    
    func makeCollectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            
            guard let sectionKind = SectionHeaderKind(rawValue: sectionIndex) else { return nil }
            
            switch sectionKind {
            case .recents:
                if self.recentItems.isEmpty { return nil }
                // 헤더 뷰 사이즈 지정
                let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                             heightDimension: .estimated(44))
                let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
                    layoutSize: headerSize,
                    elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
                // 헤더 뷰 상단고정 여부
                sectionHeader.pinToVisibleBounds = true
                
                return CompositionalLayoutUtil.horizontalLayout(estimatedSize: .init(width: 200, height: 44), spacingBetweenItems: 10, contentInsets: .init(top: 0, leading: 12, bottom: 0, trailing: 12), supplementaryItems: [sectionHeader])
                
            case .food:
                // 헤더 뷰 사이즈 지정
                let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                             heightDimension: .estimated(44))
                let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
                    layoutSize: headerSize,
                    elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
                // 헤더 뷰 상단고정 여부
                sectionHeader.pinToVisibleBounds = true
                
                return CompositionalLayoutUtil.gridLayout(column: 3, spacingBetweenItems: 10, contentInsets: .init(top: 0, leading: 12, bottom: 0, trailing: 12), supplementaryItems: [sectionHeader])
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
            cell.btEdit.eventPublisher.sink { [weak self] _ in
                self?.recentItems.removeAll()
                self?.collectionView.reloadData()
            }.store(in: &cancellables)
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
