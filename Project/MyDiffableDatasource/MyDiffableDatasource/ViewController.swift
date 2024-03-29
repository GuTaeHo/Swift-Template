//
//  ViewController.swift
//  MyDiffableDatasource
//
//  Created by 구태호 on 2023/09/25.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var collectionView: UICollectionView!
    
    enum Section: CaseIterable {
        case main
    }
    
    let collections: [Product] = [
        .init(code: 0, thumbnail: "https://img.danawa.com/prod_img/500000/148/824/img/17824148_3.jpg?_v=20220929125243", brand: "Apple", name: "아이폰14 프로 512GB, LG U+", price: 999),
        .init(code: 1, thumbnail: "https://image.lguplus.com/common/images/hphn/product/A2628-128/imge_cut/ushop_A2628-128_67_A.jpg", brand: "Apple", name: "아이폰13 mini 128GB, LG U+", price: 549),
        .init(code: 2, thumbnail: "https://img.danawa.com/prod_img/500000/242/814/img/17814242_2.jpg?_v=20230707132057", brand: "Apple", name: "아이폰14 플러스 512GB, LG U+, 아이폰 15 pro 는 언제 출시되냐고오", price: 999),
        .init(code: 3, thumbnail: "https://support.apple.com/library/APPLE/APPLECARE_ALLGEOS/SP705/SP705-iphone_6-mul.png", brand: "Apple", name: "아이폰6 64GB, LG U+", price: 549),
        .init(code: 4, thumbnail: "https://www.thelec.kr/news/photo/202203/16269_14623_2632.png", brand: "Apple", name: "아이폰SE3 128GB, LG U+", price: 449),
        .init(code: 0, thumbnail: "https://img.danawa.com/prod_img/500000/148/824/img/17824148_3.jpg?_v=20220929125243", brand: "Apple", name: "아이폰14 프로 512GB, LG U+", price: 999),
    ]
    
    var dataSource: UICollectionViewDiffableDataSource<Section, Product>!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.collectionViewLayout = makeCompositionalLayout()
        
        configureDataSource()
        initSnapshot()
    }
    
    /// 셀 등록 및 데이터 소스 생성
    func configureDataSource() {
        // 1. Cell 등록자 생성
        let cellRegistration = UICollectionView.CellRegistration<DiffableCollectionViewCell, Product> { (cell, indexPath, product) in
            cell.configuration(product)
        }
        
        // 2. DiffableDataSource 생성
        dataSource = UICollectionViewDiffableDataSource<Section, Product>(collectionView: collectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, identifier: Product) -> UICollectionViewCell? in
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: identifier)
        }
    }
    
    // 그리드 형태의 컴포지셔널 레이아웃 생성
    func makeCompositionalLayout() -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout { [weak self] sectionIndex, env -> NSCollectionLayoutSection? in
            return self?.gridLayout()
        }
    }
    
    // 그리드 형태의 레이아웃 생성
    func gridLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .estimated(200))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 12, bottom: 0, trailing: 12)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(200))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 2)

        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 14, bottom: 16, trailing: 14)
        return section
    }
    
    func initSnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Product>()
        snapshot.appendSections([.main])
        snapshot.appendItems(collections)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    func performQuery(with filter: String?) {
        let filtered = self.collections.filter { $0.name.hasPrefix(filter ?? "") }
        
        // 스냅샷 생성 [특정 시점의 데이터를 나타냄]
        var snapshot = NSDiffableDataSourceSnapshot<Section, Product>()
        // 섹션과 아이템으로 구성
        snapshot.appendSections([.main])
        snapshot.appendItems(filtered)
        // 변경된 섹션, UI를 적용
        self.dataSource.apply(snapshot, animatingDifferences: true)
    }
}

