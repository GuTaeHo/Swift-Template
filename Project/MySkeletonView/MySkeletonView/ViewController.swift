//
//  ViewController.swift
//  MySkeletonView
//
//  Created by 구태호 on 2022/11/09.
//

import UIKit
import SnapKit
import SkeletonView

class ViewController: UIViewController {
    @IBOutlet var titleView: UIView!
    @IBOutlet var ivTitle: UIImageView!
    @IBOutlet var lbTitle: UILabel!
    
    @IBOutlet var skeletonTableView: UITableView!
    
    @IBOutlet var btCollection: UIButton!
    
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
        
        btCollection.addTarget(self, action: #selector(onClickButton), for: .touchUpInside)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
            self.view.hideSkeleton()
        }
        
        // Xib 파일명으로 셀을 찾아 등록
        let nib = UINib(nibName: "SkeletonCell", bundle: nil)
        skeletonTableView.register(nib, forCellReuseIdentifier: "SkeletonCell")
        skeletonTableView.dataSource = self
        skeletonTableView.reloadData()
        
        view.showAnimatedGradientSkeleton()
    }
    
    @objc func onClickButton() {
        if let viewController = storyboard?.instantiateViewController(withIdentifier: "PackageCollectionViewController") as? PackageCollectionViewController {
            present(viewController, animated: true)
        }
    }
}

extension ViewController: SkeletonTableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SkeletonCell", for: indexPath) as? SkeletonCell
        else { return UITableViewCell() }
        
        let index = indexPath.row
        let item = packages[index]
        
        if let thumbnail = item.thumbnail {
            cell.ivThumbnail.image = UIImage(named: "\(thumbnail).jpg")
        }
        
        if let title = item.title {
            cell.lbTitle.text = title
        }
        
        if let subTitle = item.subTitle {
            cell.lbSubTitle.text = subTitle
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return packages.count
    }
    
    /// 스켈레톤 델리게이트를 쓰기 위해선 반드시 해당 셀의 이름을 반환해주어야하는듯
    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return "SkeletonCell"
    }
    
    /// 스켈레톤 뷰 표시를 위해서 "반드시" 구현해주어야됨
    func collectionSkeletonView(_ skeletonView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return packages.count
    }
}

/*
 extension ViewController: SkeletonTableViewDelegate {
 func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
 
 guard let clickedCell = tableView.dequeueReusableCell(withIdentifier: "SkeletonCell", for: indexPath) as? SkeletonCell
 else { return }
 
 clickedCell.showAnimatedGradientSkeleton()
 
 DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
 clickedCell.hideSkeleton()
 }
 }
 }
 */
