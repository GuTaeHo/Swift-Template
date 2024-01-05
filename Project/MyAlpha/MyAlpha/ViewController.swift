//
//  ViewController.swift
//  MyAlpha
//
//  Created by 구태호 on 1/5/24.
//

import UIKit

/**
 UIView 숨김/표시 애니메이션 테스트 예제
 
 */
class ViewController: UIViewController {
    lazy var hidedView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .darkGray
        return view
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.addSubview(hidedView)
        hidedView.frame = .init(origin: .zero, size: .init(width: 150, height: 150))
        hidedView.center = view.center
        
        /* 3초 후 숨김 & 2초 후 표시 */
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.hidedView.hidden()
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.hidedView.display()
            }
        }
        
        view.addSubview(stackView)
        NSLayoutConstraint.activate([
            // stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.heightAnchor.constraint(equalToConstant: 100),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        let view1 = UIView(frame: .init(x: 0, y: 0, width: 200, height: 100))
        view1.backgroundColor = .blue
        let view2 = UIView(frame: .init(x: 0, y: 0, width: 200, height: 100))
        view2.backgroundColor = .red
        stackView.addArrangedSubview(view1)
        stackView.addArrangedSubview(view2)
        
        /* (view1) 3초 후 숨김 & (view1) 2초 후 표시, (view2) 숨김 */
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            view1.hidden()
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                view1.display()
                view2.hidden()
            }
        }
    }
}

