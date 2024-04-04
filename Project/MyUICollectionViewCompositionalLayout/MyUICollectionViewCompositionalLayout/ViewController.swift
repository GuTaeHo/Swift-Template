//
//  ViewController.swift
//  MyUICollectionViewCompositionalLayout
//
//  Created by 구태호 on 2023/09/26.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func shakeButton(_ sender: UIButton) {
        sender.shake()
    }
    
    @IBAction func moveCodeBaseCollectionViewCollectionViewController(_ sender: Any) {
        let vc = CodeBaseCollectionViewController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
}
