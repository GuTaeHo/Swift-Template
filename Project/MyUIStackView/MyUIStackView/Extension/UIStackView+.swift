//
//  UIStackView+.swift
//  MyUIStackView
//
//  Created by 구태호 on 4/16/24.
//

import UIKit


extension UIStackView {
    /// - Parameters:
    ///     - axis: 뷰 배치 방향 (기본값: .horizontal)
    ///     - spacing: 서브 뷰 간 간격 (기본값: 0)
    ///     - alignment: 정렬방식 (기본값: .fill)
    ///     - distribution: 채우기 방식 (기본값: .fill)
    ///     - margins: 기본 마진 (기본값: .zero)
    ///     - subviews: 뷰 배치 방향 (기본값: .horizontal)
    convenience init(axis: NSLayoutConstraint.Axis = .horizontal, spacing: CGFloat = 0, alignment: Alignment = .fill, distribution:  UIStackView.Distribution = .fill, margins: UIEdgeInsets = .zero, subviews: [UIView] = []) {
        self.init(arrangedSubviews: subviews)
        self.axis = axis
        self.spacing = spacing
        self.alignment = alignment
        self.distribution = distribution
        self.layoutMargins = margins
        self.isLayoutMarginsRelativeArrangement = true
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
