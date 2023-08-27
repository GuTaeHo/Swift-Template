//
//  HorizontalScrollableCollectionViewController.swift
//  MyTagsCollectionView
//
//  Created by 구태호 on 2023/08/27.
//

import UIKit


class HorizontalScrollableCollectionViewController: UIViewController {
    @IBOutlet var collectionView: UICollectionView!
    
    var filters: [Filter] = [
        Filter(title: "최신순", imageNames: "square.and.arrow.up"),
        Filter(title: "가까운순", imageNames: "square.and.arrow.down.fill"),
        Filter(title: "리뷰많은순", imageNames: "scribble.variable"),
        Filter(title: "금액낮은순", imageNames: "folder.fill"),
        Filter(title: "금액높은순", imageNames: "externaldrive"),
        Filter(title: "24시간운영", imageNames: "doc.richtext.fill"),
        Filter(title: "할인쿠폰", imageNames: "graduationcap")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 6, bottom: 0, right: 6)
    }
}

extension HorizontalScrollableCollectionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HorizontalScrollableCollectionViewCell", for: indexPath) as? HorizontalScrollableCollectionViewCell else { return .init() }
        
        let item = filters[indexPath.item]
        cell.configuration(item: item)
        
        return cell
    }
}
