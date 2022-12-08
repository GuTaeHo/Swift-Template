//
//  DefaultSecondtViewController.swift
//  MyTabBarController
//
//  Created by 구태호 on 2022/12/02.
//

import UIKit

class DefaultSecondViewController: BaseViewController {
    
    @IBOutlet var tableView: UITableView!
    
    private var items = ["imgCocoa6.jpg", "imgCocoa4.jpg", "imgJar1.jpg", "imgCocoa2.jpg"]
    private var tableViewItems = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initNavigationItemLayout()
        
        let nib = UINib(nibName: "DefaultTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "DefaultTableViewCell")
        
        for _ in 0..<5 {
            for item in items {
                tableViewItems.append(item)
            }
        }
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func initNavigationItemLayout() {
        let backButtonImage = UIImage(systemName: "arrow.backward")
        
        navigationController?.navigationItem.backBarButtonItem = UIBarButtonItem(image: backButtonImage, style: .plain, target: self, action: #selector(popToPrevious))
    }
    
    @objc func popToPrevious() {
        self.navigationController?.popViewController(animated: true)
    }
}

extension DefaultSecondViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "DefaultTableViewCell", for: indexPath) as? DefaultTableViewCell else {
            return UITableViewCell()
        }
        
        let index = indexPath.row
        let imageName = tableViewItems[index]
        
        cell.ivThumbNail.image = UIImage(named: imageName)
        
        return cell
    }
}
