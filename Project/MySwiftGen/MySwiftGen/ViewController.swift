//
//  ViewController.swift
//  MySwiftGen
//
//  Created by 구태호 on 4/20/24.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let marineImage = Asset.Images.imgMarine
        let marineImageView = UIImageView(image: .init(asset: marineImage))
        view.addSubview(marineImageView)
        
        NSLayoutConstraint.activate([
            marineImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            marineImageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            marineImageView.widthAnchor.constraint(equalToConstant: 120),
            marineImageView.heightAnchor.constraint(equalToConstant: 120),
        ])
    }
}

