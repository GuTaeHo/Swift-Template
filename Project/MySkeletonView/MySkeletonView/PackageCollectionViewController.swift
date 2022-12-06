//
//  PackageCollectionViewController.swift
//  MySkeletonView
//
//  Created by 구태호 on 2022/12/03.
//

import UIKit
import SkeletonView

class PackageCollectionViewController: UIViewController {
    @IBOutlet var titleView: UIView!
    @IBOutlet var ivTitle: UIImageView!
    @IBOutlet var lbTitle: UILabel!
    
    @IBOutlet var packageCollectionView: UICollectionView!
    
    var packages = [
        Package(thumbnail: "imgCocoa3", title: "CocoaPods", subTitle: "iOS"),
        Package(thumbnail: "imgCocoa2", title: "Gradle", subTitle: "Android"),
        Package(thumbnail: "imgCocoa1", title: "Carthage", subTitle: "Apple"),
        Package(thumbnail: "imgCocoa2", title: "Maven", subTitle: "Spring"),
        Package(thumbnail: "imgCocoa1", title: "Ant", subTitle: "Spring"),
        Package(thumbnail: "imgCocoa3", title: "Swift Package Manager", subTitle: "Apple"),
        Package(thumbnail: "imgCocoa3", title: "PHP: Hypertext Preprocessor", subTitle: "PHP"),
        Package(thumbnail: "imgCocoa2", title: "Dalvik Virtual Machine", subTitle: "Google"),
        Package(thumbnail: "imgCocoa2", title: "Android RunTime", subTitle: "Google"),
        Package(thumbnail: "imgCocoa3", title: "APACHE LICENSE 2.0", subTitle: "Sun Micro Systems"),
        Package(thumbnail: "imgCocoa1", title: "Glue Glue", subTitle: "Google"),
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
            self.view.hideSkeleton()
        }
        
        // Xib 파일명으로 셀을 찾아 등록
        let nib = UINib(nibName: "PackageCollectionViewCell", bundle: nil)
        packageCollectionView.register(nib, forCellWithReuseIdentifier: "PackageCollectionViewCell")
        packageCollectionView.dataSource = self
        packageCollectionView.delegate = self
        packageCollectionView.reloadData()
        
        view.showAnimatedGradientSkeleton()
    }
}

extension PackageCollectionViewController: SkeletonCollectionViewDelegate, SkeletonCollectionViewDataSource {
    func collectionSkeletonView(_ skeletonView: UICollectionView, cellIdentifierForItemAt indexPath: IndexPath) -> SkeletonView.ReusableCellIdentifier {
        return "PackageCollectionViewCell"
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return packages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PackageCollectionViewCell", for: indexPath) as? PackageCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let item = packages[indexPath.item]
        
        cell.ivThumbnail.image = UIImage(named: item.thumbnail ?? "")
        
        return cell
    }
}
