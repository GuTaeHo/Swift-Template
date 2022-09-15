//
//  ViewController.swift
//  MyZIndex
//
//  Created by 구태호 on 2022/07/22.
//

import UIKit

class ViewController: UIViewController {
    lazy var sampleSuperview: UIView = {
        let view = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 200, height: 200)))
        view.backgroundColor = .darkGray
        
        return view
    }()
    
    lazy var sampleSubview: UIView = {
        let view = UIView(frame: CGRect(origin: CGPoint(x: 50, y: 50), size: CGSize(width: 100, height: 100)))
        view.backgroundColor = .lightGray
        
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sampleSuperview.center = view.center
        view.addSubview(sampleSuperview)
        sampleSubview.autoresizingMask = [.flexibleLeftMargin]
        sampleSubview.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        sampleSuperview.addSubview(sampleSubview)
        
        UIView.animate(withDuration: 1.5) {
            self.sampleSuperview.bounds.size = CGSize(width: 300, height: 300)
        }
    }
}

