//
//  FirstViewController.swift
//  MyUIComponents
//
//  Created by 구태호 on 2022/09/05.
//

import UIKit

class FirstViewController: UIViewController {
    lazy var myView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemIndigo
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func showToastInWindow(_ sender: Any) {
        // 현재 뷰의 UIWindow 객체를 가져옵니다.
        guard let window = view.window else { return }
        
        window.addSubview(myView)
        NSLayoutConstraint.activate([
            myView.centerXAnchor.constraint(equalTo: window.centerXAnchor),
            myView.centerYAnchor.constraint(equalTo: window.centerYAnchor),
            myView.widthAnchor.constraint(equalToConstant: 200),
            myView.heightAnchor.constraint(equalToConstant: 300)
        ])
    }
    
    deinit {
        print("FirstViewController deinit")
    }
}
