//
//  UITableView.swift
//  MyCustomView
//
//  Created by 구태호 on 2023/03/09.
//

import UIKit


extension UITableView {
    /// 테이블 뷰에 커스텀 셀 등록
    /// - parameter cellName: Cell.xib 파일 명
    // TODO: cellName class명으로 변경하기
    func registerCell(cellName: String) {
        self.register(UINib(nibName: cellName, bundle: nil), forCellReuseIdentifier: cellName)
    }
}
