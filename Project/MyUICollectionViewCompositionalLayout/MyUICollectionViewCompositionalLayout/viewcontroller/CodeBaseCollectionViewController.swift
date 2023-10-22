//
//  CodeBaseCollectionViewController.swift
//  MyUICollectionViewCompositionalLayout
//
//  Created by 구태호 on 10/21/23.
//

import UIKit


class CodeBaseCollectionViewController: UIViewController {
    lazy var backButton: UIButton = {
        var configue = UIButton.Configuration.filled()
        configue.title = "뒤로가기"
        configue.subtitle = "메인"
        
        let button = UIButton(configuration: configue)
        button.setTitle("뒤로가기", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.configurationUpdateHandler = { [weak self] button in
            self?.dismiss(animated: true)
        }
        return button
    }()
    
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewCompositionalLayout(section: makeGridLayoutSection(column: 2, row: 3)))
        collectionView.dataSource = self
        collectionView.delegate = self
        // 셀 식별을 위한 Nib 파일 등록
        collectionView.registerCellByNib(CodeBaseTestGridCollectionViewCell.self)
        // 보충 뷰 식별을 위한 Nib 파일 등록
        collectionView.registerSupplementaryViewByNib(CodeBaseCollectionReusableView.self, ofKind: UICollectionView.elementKindSectionHeader)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
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
        view.addSubview(backButton)
        backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        backButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 18).isActive = true
        
        view.addSubview(collectionView)
        collectionView.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 18).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        collectionView.backgroundColor = .black
        
    }
    
    func makeGridLayoutSection(column: Int, row: Int) -> NSCollectionLayoutSection {
        let itemFractionalWidthFraction = 1.0 / Double(column)
        let itemInset: CGFloat = 2.5
        let groupFractionalHeightFraction = 1.0 / Double(row)
        
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(itemFractionalWidthFraction),
            heightDimension: .fractionalHeight(1)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: itemInset, leading: itemInset, bottom: itemInset, trailing: itemInset)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(groupFractionalHeightFraction)
        )
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: itemInset, leading: 0, bottom: itemInset, trailing: 0)
        
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
    
    deinit {
        print("CodeBaseCollectionViewController deinit")
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
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let cell = collectionView.dequeueSupplementaryView(CodeBaseCollectionReusableView.self, ofKind: UICollectionView.elementKindSectionHeader, for: indexPath)
        cell.configuration(headerItems[indexPath.item])
        
        return cell
    }
}
