//
//  MainViewController.swift
//  MyCodeBaseViews
//
//  Created by 구태호 on 11/20/23.
//

import UIKit
import SnapKit
import Then


class MainViewController: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initLayout()
    }
    
    private func initLayout() {
        let scrollView = UIScrollView()
        
        let vStackView = UIStackView().then {
            $0.axis = .horizontal
            $0.isLayoutMarginsRelativeArrangement = true
            $0.layoutMargins = .init(top: 18, left: 12, bottom: 18, right: 12)
            $0.axis = .vertical
            $0.spacing = 12
        }
        
        let hStackView1 = UIStackView().then {
            $0.distribution = .fillEqually
            $0.heightAnchor.constraint(equalToConstant: 48).isActive = true
            $0.axis = .horizontal
            $0.spacing = 12
        }
        
        let hStackView2 = UIStackView().then {
            $0.distribution = .fillEqually
            $0.heightAnchor.constraint(equalToConstant: 48).isActive = true
            $0.axis = .horizontal
            $0.spacing = 12
        }
        
        let button1 = UIButton().then {
            $0.configuration = .filled()
            $0.configuration?.title = "테이블 뷰"
            $0.addAction(.init(handler: { [weak self] action in
                let vc = TableViewController()
                self?.present(vc, animated: true)
            }), for: .touchUpInside)
        }
        
        let button2 = UIButton().then {
            $0.configuration = .filled()
            $0.configuration?.title = "콜렉션 뷰"
        }
        
        let button3 = UIButton().then {
            $0.configuration = .filled()
            $0.configuration?.title = "다중 섹션 콜렉션 뷰(Compositional)"
        }
        
        let button4 = UIButton().then {
            $0.configuration = .filled()
            $0.configuration?.title = ""
        }
        
        view.addSubview(scrollView)
        scrollView.addSubview(vStackView)
        vStackView.addArrangedSubviews(hStackView1, hStackView2)
        hStackView1.addArrangedSubviews(button1, button2)
        hStackView2.addArrangedSubviews(button3, button4)
        
        scrollView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        vStackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalToSuperview()
        }
    }
}

