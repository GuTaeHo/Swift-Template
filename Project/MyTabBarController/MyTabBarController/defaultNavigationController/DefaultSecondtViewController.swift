//
//  DefaultSecondtViewController.swift
//  MyTabBarController
//
//  Created by 구태호 on 2022/12/02.
//

import UIKit

class DefaultSecondViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    private var tableViewItems = ["가나다", "라마바", "사아자", "차카타", "파하"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: "DefaultTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "DefaultTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
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
        let title = tableViewItems[index]
        
        cell.lbTitle.text = title
        
        return cell
    }
}
