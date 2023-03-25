//
//  ViewController.swift
//  MyLazyWeak
//
//  Created by 구태호 on 2023/03/26.
//

import UIKit

/**
 강한 참조 테스트 프로그램
- note: escaping, weak, lazy 키워드 테스트 및 학습

 */
class ViewController: UIViewController {

    @IBOutlet var lbNotifyingEscapingClosureTestViewController: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func strongReferenceClick(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        if let viewController = storyboard.instantiateViewController(withIdentifier: "EscapingClosureTestViewController") as? EscapingClosureTestViewController {
            /* EscapingClosureTestViewController deinit 후 호출 */
            lbNotifyingEscapingClosureTestViewController.text = "EscapingClosureTest P.R.E.S.E.N.T 됨"
            viewController.notifyingViewControllerDeinitClosure = { [weak self] in
                self?.lbNotifyingEscapingClosureTestViewController.text = "EscapingClosureTest D.E.I.N.I.T 됨"
            }
            present(viewController, animated: true)
        }
    }
}

