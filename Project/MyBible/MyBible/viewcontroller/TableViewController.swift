//
//  TableViewController.swift
//  MyBible
//
//  Created by 구태호 on 2023/04/10.
//

import UIKit

struct Dummy {
    var code: Int?
    var content: String?
    var tags: [Tag]?
}

struct Tag {
    var number: Int?
    var backgroundColor: UIColor?
}

class TableViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    var tableViewItems = [Dummy]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for index in 0..<100 {
            var dummy = Dummy()
            dummy.code = index
            dummy.content = UUID().uuidString
            
            if dummy.tags == nil {
                dummy.tags = [Tag]()
            }
            
            for _ in 0..<Int.random(in: 3...20) {
                let randomBackgroundColor = UIColor(r: CGFloat.random(in: 0...255), g: CGFloat.random(in: 0...255), b: CGFloat.random(in: 0...255), a: 1)
                let randomCode = Int.random(in: 0...65536)
                let tag = Tag(number: randomCode, backgroundColor: randomBackgroundColor)
                
                dummy.tags?.append(tag)
            }
            
            tableViewItems.append(dummy)
        }
        
        tableView.registerCell(cellName: "CommonTableViewCell")
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.reloadData()
    }
}

extension TableViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(tableViewItems.count)
        return tableViewItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CommonTableViewCell", for: indexPath) as? CommonTableViewCell else {
            return UITableViewCell()
        }
        
        let item = tableViewItems[indexPath.row]
        cell.item = item
        cell.configuration()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        tableView.layoutIfNeeded()
        
        tableView.snp.remakeConstraints {
            $0.height.equalTo(tableView.contentSize.height)
        }
    }
}
