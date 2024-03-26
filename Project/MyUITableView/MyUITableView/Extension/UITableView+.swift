//
//  UITableView+.swift
//  MyTableViewSectionHeaderAndFooterView
//
//  Created by 구태호 on 3/26/24.
//

import UIKit

extension UITableView {
    /// 헤더 뷰를 지정하고, 레이아웃을 업데이트 합니디.
    /// - Important: 헤더 뷰의 오토레이아웃이 완전하게 지정되어있어야 동작합니다.
    func setHeaderView(_ headerView: UIView?) {
        guard let headerView else { return }
        self.tableHeaderView = headerView
        self.tableHeaderView?.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            headerView.widthAnchor.constraint(equalTo: self.widthAnchor)
        ])
        headerView.setNeedsLayout()
        headerView.layoutIfNeeded()
        headerView.frame.size =  headerView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        self.tableHeaderView = headerView
    }
    
    /// 테이블 뷰 셀 등록
    /// - Parameter fromClass: 셀 메타 타입
    func registerCell<T: UITableViewCell>(fromClass metaType: T.Type) {
        register(metaType, forCellReuseIdentifier: metaType.className)
    }
    
    /// 테이블 뷰 셀 등록
    /// - Parameter fromNib: 셀 메타 타입
    func registerCell<T: UITableViewCell>(fromNib metaType: T.Type) {
        register(.init(nibName: metaType.className, bundle: nil), forCellReuseIdentifier: metaType.className)
    }
    
    /// 테이블 헤더, 푸터 뷰 등록
    /// - Parameter fromClass: 헤더, 푸터 뷰 메타 타입
    func registerHeaderFooterView<T: UITableViewHeaderFooterView>(fromClass metaType: T.Type) {
        register(metaType, forHeaderFooterViewReuseIdentifier: metaType.className)
    }
    
    /// 테이블 헤더, 푸터 뷰 등록
    /// - Parameter fromNib: 헤더, 푸터 뷰 메타 타입
    func registerHeaderFooterView<T: UITableViewHeaderFooterView>(fromNib metaType: T.Type) {
        register(.init(nibName: metaType.className, bundle: nil), forHeaderFooterViewReuseIdentifier: metaType.className)
    }
    
    /// 해당 셀 타입으로 캐스팅된 재사용 셀을 가져옵니다.
    /// - Parameters:
    ///   - metaType: 셀 타입
    ///   - indexPath: 인덱스 (IndexPath)
    func dequeueCell<T: UITableViewCell>(_ metaType: T.Type, for indexPath: IndexPath) -> T {
        return (dequeueReusableCell(withIdentifier: metaType.className, for: indexPath) as? T) ?? .init()
    }
    
    /// 해당 셀 타입으로 캐스팅된 재사용 셀을 가져옵니다.
    /// - Parameters:
    ///   - metaType: 셀 타입
    ///   - indexPath: 인덱스 (IndexPath)
    /// - Important: 테이블에서 다양한 셀을 사용하는 경우, 이 메소드 사용
    func dequeueCellForVarious<T: UITableViewCell>(_ metaType: T.Type, for indexPath: IndexPath) -> T? {
        return dequeueReusableCell(withIdentifier: metaType.className, for: indexPath) as? T
    }
    
    /// 해당 뷰 타입으로 캐스팅된 재사용 헤더/푸터 뷰를 가져옵니다.
    /// - Parameter viewClass: 헤더/푸터 뷰 타입
    /// - Returns: 캐스팅된 재사용 해더/푸터 뷰 인스턴스 또는 `nil`
    func dequeueHeaderFooterView<T: UITableViewHeaderFooterView>(_ metaType: T.Type) -> T {
        return dequeueReusableHeaderFooterView(withIdentifier: metaType.className) as? T ?? .init()
    }
}
