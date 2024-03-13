//
//  OrangeViewController.swift
//  MyNavigationViewController
//
//  Created by 구태호 on 2022/11/02.
//

import UIKit

class OrangeViewController: UIViewController {
    @IBOutlet var lbCurrentViewController: UILabel!
    
    public var dataClosure: ((Any) -> ())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func sendDataPreviousViewController(_ sender: UIButton) {
        dataClosure?("안녕!")
    }
    
    @IBAction func previousViewController(_ sender: Any) {
        // MARK: 함수에서 제네릭을 사용할 경우, 타입을 명시해주지 않으면, 에러 발생
        if let viewController = self.navigationController?.previousViewController(context: RedViewController.self) {
            lbCurrentViewController.text = String(describing: type(of: viewController))
            print("\(viewController.dummyDataNextViewController)")
        }
    }
}
