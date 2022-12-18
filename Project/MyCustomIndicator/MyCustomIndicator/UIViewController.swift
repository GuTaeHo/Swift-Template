//
//  UIViewController.swift
//  MyCustomIndicator
//
//  Created by 구태호 on 2022/12/17.
//

import UIKit


extension UIViewController {
    
    var rectIndicatorTag: Int {
        get { return 76053717 }
    }
    
    func showRectIndicator() {
        let backgroundView = UIView()
        backgroundView.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height)
        backgroundView.backgroundColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        backgroundView.tag = rectIndicatorTag
        view.isUserInteractionEnabled = false
        
        let indicator = UIActivityIndicatorView()
        indicator.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        indicator.center = view.center
        indicator.style = .large
        indicator.startAnimating()
        indicator.color = .black
        indicator.hidesWhenStopped = false
        
        let rectView = UIView()
        rectView.frame = CGRect(x: 0, y: 0, width: view.bounds.width / 2, height: view.bounds.width / 3)
        rectView.center = view.center
        rectView.backgroundColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1.0)
        rectView.layer.cornerRadius = 10
        rectView.layer.shadowColor = UIColor.black.cgColor
        rectView.layer.shadowOffset = .zero
        rectView.layer.shadowRadius = 6.0
        rectView.layer.shadowOpacity = 0.5
        rectView.layer.masksToBounds = false
        rectView.addSubview(indicator)
        
        backgroundView.addSubview(rectView)
        view.addSubview(backgroundView)
        view.layoutIfNeeded()
        
        print("indicator.centor \(indicator.center)")
        print("rectView.centor \(rectView.center)")
        print("backgroundView.centor \(backgroundView.center)")
    }
    
    func hideRectIndicator(){
        if let background = view.viewWithTag(rectIndicatorTag){
            background.removeFromSuperview()
        }
        view.isUserInteractionEnabled = true
    }
}
