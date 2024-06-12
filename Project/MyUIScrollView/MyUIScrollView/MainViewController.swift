//
//  MainViewController.swift
//  MyUIScrollView
//
//  Created by 구태호 on 2023/09/26.
//

import UIKit
import Combine
import Then


class MainViewController: UIViewController {
    @IBOutlet weak var stackView: UIStackView!
    
    let tableViewButton = UIButton(configuration: .filled()).then {
        $0.configuration?.title = "(CodeBase) 테이블 뷰"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        stackView.addArrangedSubview(tableViewButton)
        bind()
    }
    
    func bind() {
        tableViewButton.addAction(.init(handler: { [weak self] _ in
            let vc = TableViewController()
            self?.navigationController?.pushViewController(vc, animated: true)
        }), for: .touchUpInside)
    }
    
    @IBAction func shakeButton(_ sender: UIButton) {
        sender.shake()
    }
    
    @IBAction func moveCodeBaseCollectionViewCollectionViewController(_ sender: Any) {
        let vc = CodeBaseCollectionViewController()
        vc.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func moveTableViewInScrollViewVC(_ sender: Any) {
        let vc = TableViewInScrollView()
        vc.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(vc, animated: true)
    }
}
