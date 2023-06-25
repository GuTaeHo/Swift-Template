//
//  ViewController.swift
//  MyLabelBaseLine
//
//  Created by 구태호 on 2023/06/25.
//

import UIKit

class TableViewItem {
    enum TableViewCellType {
        case titleOnly
        case contentOnly
        case titleAndContent
    }
    
    var section: Int?
    var title: String?
    var content: String?
    var cellType: TableViewCellType?
    
    init(section: Int, title: String? = nil, content: String? = nil, cellType: TableViewCellType? = nil) {
        self.section = section
        self.title = title
        self.content = content
        self.cellType = cellType
    }
}


class ViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    
    private var items = [TableViewItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /* 타이틀 & 콘텐츠 */
        items.append(TableViewItem(section: 0, title: "타이틀 테스트 타이틀 테스트 타이틀 테스트 타이틀 테스트 ", content: "콘텐츠 테스트 콘텐츠 테스트 콘텐츠 테스트 콘텐츠 테스트 ", cellType: .titleAndContent))
        items.append(TableViewItem(section: 0, title: "타이틀 테스트2 타이틀 테스트2", content: "콘텐츠 테스트2", cellType: .titleAndContent))
        items.append(TableViewItem(section: 0, title: "타이틀 테스트3 타이틀 테스트3 타이틀 테스트3 타이틀 테스트3 타이틀 테스트3 타이틀 테스트3 타이틀 테스트3 ", content: "콘텐츠 테스트3 콘텐츠 테스트3 콘텐츠 테스트3 콘텐츠 테스트3 콘텐츠 테스트3 ", cellType: .titleAndContent))
        
        /* 타이틀 Only */
        items.append(TableViewItem(section: 1, title: "타이틀 테스트 타이틀 테스트 타이틀 테스트 타이틀 테스트 ", cellType: .titleOnly))
        items.append(TableViewItem(section: 1, title: "타이틀 테스트2 타이틀 테스트2 타이틀 테스트2", cellType: .titleOnly))
        items.append(TableViewItem(section: 1, title: "타이틀 테스트3", cellType: .titleOnly))
        
        /* 콘텐츠 Only */
        items.append(TableViewItem(section: 2, content: "콘텐츠 테스트", cellType: .contentOnly))
        items.append(TableViewItem(section: 2, content: "콘텐츠 테스트2 콘텐츠 테스트2 콘텐츠 테스트2 콘텐츠 테스트2", cellType: .contentOnly))
        items.append(TableViewItem(section: 2, content: "Content Test3 Content Test3 Content Test3 Content Test3 ", cellType: .contentOnly))
        
        tableView.delegate = self
        tableView.dataSource = self
        // MARK: UITableView 는 contentInset에 오류가 있는 듯 함
        // MARK: 제약조건을 사용해서 간격을 두는것이 가장 나은 방법인듯, 또는 UICollectionView 를 사용하는 방법도 고려해볼 것
        // tableView.contentInset = .init(top: 18, left: 18, bottom: 18, right: 18)
        tableView.reloadData()
    }


}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var firstSectionItems = [TableViewItem]()
        var secondSectionItems = [TableViewItem]()
        var thirdSectionItems = [TableViewItem]()
        
        /* 아이템 성격에 맞게 분리 및 개수 반환 */
        items.forEach({
            switch $0.cellType {
            case .titleAndContent:
                firstSectionItems.append($0)
                break
            case .titleOnly:
                secondSectionItems.append($0)
                break
            case .contentOnly:
                thirdSectionItems.append($0)
                break
            default:
                break
            }
        })
        
        switch section {
        case 0:
            return firstSectionItems.count
        case 1:
            return secondSectionItems.count
        case 2:
            return thirdSectionItems.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = items[indexPath.row]
        
        if let aCell = tableView.dequeueReusableCell(withIdentifier: "ATypeTableViewCell", for: indexPath) as? ATypeTableViewCell {
            aCell.item = item
            aCell.configuration()
            return aCell
        }
        
        if let bCell = tableView.dequeueReusableCell(withIdentifier: "BTypeTableViewCell", for: indexPath) as? BTypeTableViewCell {
            bCell.item = item
            bCell.configuration()
            return bCell
        }
        
        if let cCell = tableView.dequeueReusableCell(withIdentifier: "CTypeTableViewCell", for: indexPath) as? CTypeTableViewCell {
            cCell.item = item
            cCell.configuration()
            return cCell
        }
        
        
        return UITableViewCell()
    }
}

