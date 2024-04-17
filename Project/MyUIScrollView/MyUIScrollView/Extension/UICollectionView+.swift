//
//  UICollectionView+.swift
//  MyCodeBaseViews
//
//  Created by 구태호 on 10/21/23.
//

import UIKit


extension UICollectionView {
    /// 컬렉션 뷰 셀 등록
    /// - Parameter cellClass: 셀 메타 타입
    func registerCell<T: UICollectionViewCell>(_ cellClass: T.Type) {
        register(cellClass, forCellWithReuseIdentifier: cellClass.className)
    }
    
    /// 컬렉션 뷰 셀 등록
    /// - Parameter cellClass: 셀 메타 타입
    func registerCellByNib<T: UICollectionViewCell>(_ cellClass: T.Type) {
        register(.init(nibName: cellClass.className, bundle: nil), forCellWithReuseIdentifier: cellClass.className)
    }
    
    /// 컬렉션 보충 뷰 등록
    /// - Parameters:
    ///   - viewClass: 뷰 메타 타입
    ///   - elementKind: 보충 뷰 종류 (헤더, 푸터 등)
    func registerSupplementaryView<T: UICollectionReusableView>(_ viewClass: T.Type, ofKind elementKind: String) {
        register(viewClass, forSupplementaryViewOfKind: elementKind, withReuseIdentifier: viewClass.className)
    }
    
    /// 컬렉션 보충 뷰 등록
    /// - Parameters:
    ///   - viewClass: 뷰 메타 타입
    ///   - elementKind: 보충 뷰 종류 (헤더, 푸터 등)
    func registerSupplementaryViewByNib<T: UICollectionReusableView>(_ viewClass: T.Type, ofKind elementKind: String) {
        register(.init(nibName: viewClass.className, bundle: nil), forSupplementaryViewOfKind: elementKind, withReuseIdentifier: viewClass.className)
    }
    
    /// 해당 셀 타입으로 캐스팅 된 재사용 셀을 가져옵니다.
    /// - Parameters:
    ///   - cellClass: 셀 타입
    ///   - indexPath: 인덱스 (IndexPath)
    /// - Returns: 캐스팅된 재사용 셀 인스턴스
    func dequeueCell<T: UICollectionViewCell>(_ cellClass: T.Type, for indexPath: IndexPath) -> T {
        return (dequeueReusableCell(withReuseIdentifier: cellClass.className, for: indexPath) as? T) ?? .init()
    }
    
    /// 해당 뷰 타입의 캐스팅 된 재사용 Supplementary 뷰를 가져옵니다.
    /// - Parameters:
    ///   - viewClass: UICollectionReusableView를 상속한 뷰 타입
    ///   - elementKind: Supplementary 뷰 종류
    ///   - indexPath: 인덱스 (IndexPath)
    /// - Returns: 캐스팅된 재사용 Supplementary 뷰 인스턴스
    func dequeueSupplementaryView<T: UICollectionReusableView>(_ viewClass: T.Type, ofKind elementKind: String, for indexPath: IndexPath) -> T {
        let identifier = String(describing: viewClass)
        return (dequeueReusableSupplementaryView(ofKind: elementKind, withReuseIdentifier: identifier, for: indexPath) as? T) ?? .init()
    }
}
