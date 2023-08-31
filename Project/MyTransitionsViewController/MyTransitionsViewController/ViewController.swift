//
//  ViewController.swift
//  MyTransitionsViewController
//
//  Created by 구태호 on 2023/08/27.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func transition(_ sender: Any) {
        let vc2 = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SecondViewController")
        vc2.transitioningDelegate = self // <- 델리게이트 conform
        vc2.modalPresentationStyle = .fullScreen
        self.present(vc2, animated: true)
    }
}

extension ViewController: UIViewControllerTransitioningDelegate {
    // present 애니메이션 실행
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        PresentAnimationTransition()
    }
    
    // dismiss 애니메이션 실행
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        DismissAnimationTransition()
    }
}

