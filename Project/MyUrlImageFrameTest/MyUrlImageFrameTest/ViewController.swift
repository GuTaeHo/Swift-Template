//
//  ViewController.swift
//  MyUrlImageFrameTest
//
//  Created by 구태호 on 2023/05/16.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var stackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let view = UIView()
        view.backgroundColor = .green
        view.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 150)
        let view2 = UIView()
        view2.backgroundColor = .black
        view2.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 150)
        
        stackView.addSubview(view)
        stackView.addSubview(view2)
        
        let imageView = ResizableImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        
        imageView.urlImage(url: "https://blog.wijman.net/content/images/size/w760h400/2021/12/debian-11-bullseye.png") { [weak self] image in
            self?.stackView.addArrangedSubview(imageView)
            imageView.image = image
        }
        
        let imageView2 = ResizableImageView(frame: .zero)
        imageView2.translatesAutoresizingMaskIntoConstraints = false
        imageView2.contentMode = .scaleAspectFill
        
        imageView2.urlImage(url: "https://i.ebayimg.com/images/g/L5UAAOSwyHdhhBL6/s-l1600.jpg") { [weak self] image in
            self?.stackView.addArrangedSubview(imageView2)
            
            imageView2.image = image
        }
    }
}

