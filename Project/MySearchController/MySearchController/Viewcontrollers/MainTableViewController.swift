//
//  MainTableViewController.swift
//  MySearchController
//
//  Created by 구태호 on 2023/06/06.
//

import UIKit

// MARK: 테이블 형태 구현 - UIViewController 내부에 delegate 방식으로 테이블 뷰를 구현하는 방식이 있고, UITableViewController 의 메소드를 오버라이딩하여 구현하는 방식이 있음
class MainTableViewController: UITableViewController {
    private var items: [MainTableViewCellItem]?
    private var searchedItems: [MainTableViewCellItem]?
    lazy var navigationRightButton: UIButton = {
        var configuration = UIButton.Configuration.plain()
        configuration.baseForegroundColor = .darkGray
        configuration.baseBackgroundColor = .clear
        configuration.image = UIImage(systemName: "lasso.and.sparkles")
        configuration.imagePadding = 6
        configuration.title = "안녕하세요"
        
        let handler: ((UIAction) -> ()) = { action in
            print("버튼 클릭됨")
        }
        
        let button = UIButton(configuration: configuration, primaryAction: .init(handler: handler))
        
        return button
    }()
    
    // 접두사 일치 시
    private let SORT_AS_PREFIX = 0
    // 포함 시
    private let SORT_AS_CONTAINS = 1
    
    private var isShowSearchedItems: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: navigationRightButton)
        addItems()
        // addSearchBar()
        addSearchController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    @objc func headerClicked() {
        print("@@@")
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "SecondViewController")
        navigationController?.present(vc, animated: true)
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
        searchController.searchBar.scopeButtonTitles = ["앞 문자 일치 시", "문자 일치 시"]
        /* 스코프 바 항상 표시 */
        searchController.searchBar.showsScopeBar = true
        /* 검색 시 헤더 타이틀 표시 */
        searchController.hidesNavigationBarDuringPresentation = true
        /* 검색 결과 델리게이트 위임 */
        searchController.searchResultsUpdater = self
        /* 스크롤 시 검색바 유지 */
        navigationItem.hidesSearchBarWhenScrolling = true
        navigationItem.searchController = searchController
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        view.layoutIfNeeded()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isShowSearchedItems {
            return searchedItems?.count ?? 0
        } else {
            return items?.count ?? 0
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let index = indexPath.row
        
        print("\(index)번 디바이스 고유번호 -> \(items?[index].content ?? "번호 없음...")")
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MainTableViewControllerCell", for: indexPath) as! MainTableViewControllerCell
        
        let index = indexPath.row
        
        cell.configuration(items?[index])
        
        return cell
    }
}


// MARK: 검색바 결과가 변경될 때 호출
extension MainTableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text?.lowercased() else { return }
        
        // 빈 값일 때는 모든 아이템 표시
        if text == "" {
            isShowSearchedItems = false
            tableView.reloadData()
            return
        }
        
        
        let items = items?.filter({
            switch searchController.searchBar.selectedScopeButtonIndex {
            case SORT_AS_PREFIX:
                // 접두사가 일치하는지 검사
                return $0.content?.lowercased().hasPrefix(text) ?? false
                
            case SORT_AS_CONTAINS:
                // localizedCaseInsensitiveContains() - 대소문자를 구분하지 않고, 해당 문자가 포함되어있는지 검사
                return $0.content?.localizedCaseInsensitiveContains(text) ?? false
                
            default:
                return false
            }
        })
        
        // 결과없음
        guard let items = items, items.count > 0 else {
            searchedItems = nil
            isShowSearchedItems = true
            tableView.reloadData()
            return
        }
        
        searchedItems = items
        isShowSearchedItems = true
        tableView.reloadData()
    }
}
