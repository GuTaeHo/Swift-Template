//
//  MainTableViewController.swift
//  MySearchController
//
//  Created by 구태호 on 2023/06/06.
//

import UIKit

// MARK: 테이블 형태 구현 - UIViewController 내부에 delegate 방식으로 테이블 뷰를 구현하는 방식이 있고, UITableViewController 의 메소드를 오버라이딩하여 구현하는 방식이 있음
class MainTableViewController: UITableViewController {
    var items: [MainTableViewCellItem]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addItems()
        // addSearchBar()
        addSearchController()
    }
    
    func addItems() {
        items = [MainTableViewCellItem]()
        
        for index in 1..<100 {
            items?.append(MainTableViewCellItem(number: "\(index)", title: "고유번호", content: UUID().uuidString))
        }
    }
    
    /*
     // MARK: 기본적인 검색바 추가 방식
    func addSearchBar() {
        let searchBar = UISearchBar()
        /* 검색바 추가 */
        searchBar.placeholder = "검색어를 입력 해 주세요."
        navigationItem.titleView = searchBar
        
        /* 취소 버튼 추가 */
        let cancel = UIBarButtonItem(systemItem: .cancel, primaryAction: UIAction(handler: { [weak self] _ in
            self?.resignFirstResponder()
        }))
        self.navigationItem.rightBarButtonItem = cancel
    }
     */
    
    // MARK: 검색 컨트롤러를 추가하는 방식
    func addSearchController() {
        let searchController = UISearchController(searchResultsController: nil)
        /* 힌트 추가 */
        searchController.searchBar.placeholder = "검색어를 입력 해 주세요."
        /* 스코프 바 추가 */
        searchController.searchBar.scopeButtonTitles = ["번호로 찾기", "고유번호로 찾기"]
        /* 스코프 바 항상 표시 */
        searchController.searchBar.showsScopeBar = true
        /* 검색 시 헤더 타이틀 표시 */
        searchController.hidesNavigationBarDuringPresentation = false
        /* 스크롤 시 검색바 유지 */
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController = searchController
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let index = indexPath.row
        
        print("\(index)번 디바이스 고유번호 -> \(items?[index].content ?? "번호 없음...")")
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MainTableViewControllerCell", for: indexPath) as! MainTableViewControllerCell
        
        let index = indexPath.row
        
        cell.item = items?[index]
        cell.configuration()
        
        return cell
    }
}


// MARK: 검색바 결과가 변경될 때 호출
extension MainTableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let filteredText = searchController.searchBar.text else { return }
        
        // TODO:
    }
}
