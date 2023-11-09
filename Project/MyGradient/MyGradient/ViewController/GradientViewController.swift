//
//  GradientViewController.swift
//  MyGradient
//
//  Created by 구태호 on 2022/10/13.
//

import UIKit

class GradientViewController: UIViewController {
    @IBOutlet var stackView: UIStackView!
    @IBOutlet var bottomGradientView: UIView!
    @IBOutlet var topGradientView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        bottomGradientView.transparentGradient(startColor: .systemRed, gradientDirection: .bottom)
        topGradientView.transparentGradient(startColor: .systemBlue, gradientDirection: .top)
        
        let view = TransparentGradientView(frame: .zero)
        view.gradientColor = .black
        view.isBottomDirection = false
        stackView.addArrangedSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        self.view.layoutIfNeeded()
    }
}

