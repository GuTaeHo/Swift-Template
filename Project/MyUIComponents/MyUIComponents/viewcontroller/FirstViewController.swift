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
        
        print("viewDidLoad view.window is nil? -> \(view.window)")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        print("viewWillAppear view.window is nil? -> \(view.window)")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        print("viewDidAppear view.window is nil? -> \(view.window)")
    }
    
    // MARK: UIView 의 UIWindow 를 참조하는 프로퍼티인 window 는 UIView 가 레이아웃 되기 시작할 때 참조할 수 있다
    // MARK: 주의할점은, 뷰 컨트롤러가 준비 완료된 시점인 viewDidAppear 에서 window 가 nil 이라는 점이다.
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        print("viewWillLayoutSubviews view.window is nil? -> \(view.window)")
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
