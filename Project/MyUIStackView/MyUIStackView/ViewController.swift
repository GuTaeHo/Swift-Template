//
//  ViewController.swift
//  MyUIStackView
//
//  Created by 구태호 on 4/16/24.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    lazy var stackView = UIStackView(axis: .vertical, spacing: 12, margins: .init(horizontal: 12, vertical: 18), subviews: [aView, bView])
    let aView = UIView(backgroundColor: .systemPink)
    let bView = UIView(backgroundColor: .systemIndigo)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
        
        aView.snp.makeConstraints {
            $0.height.equalTo(80)
        }
        
        bView.snp.makeConstraints {
            $0.height.equalTo(80)
        }
    }
}

