//
//  PanGestureViewController.swift
//  MyUIGestureRecognizer
//
//  Created by 구태호 on 5/12/24.
//

import UIKit

class PanGestureViewController: UIViewController {
    @IBOutlet weak var showModal: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initAction()
    }
    
    func initAction() {
        showModal.addAction { [weak self] in
            let vc = PanGestureModalViewController()
            vc.modalPresentationStyle = .overFullScreen
            self?.present(vc, animated: true)
        }
    }
}
