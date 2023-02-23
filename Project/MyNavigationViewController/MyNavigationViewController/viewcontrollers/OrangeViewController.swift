//
//  OrangeViewController.swift
//  MyNavigationViewController
//
//  Created by 구태호 on 2022/11/02.
//

import UIKit

class OrangeViewController: UIViewController {
    @IBOutlet var lbCurrentViewController: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func next(_ sender: Any) {
        if let viewController = storyboard?.instantiateViewController(withIdentifier: "YellowViewController") {
            self.navigationController?.pushViewController(viewController, animated: true)
        } else {
            print("뷰 컨트롤러 추가 오류...")
        }
    }
    
    @IBAction func previousViewController(_ sender: Any) {
        // MARK: 함수에서 제네릭을 사용할 경우, 값을 전달 받는 변수 부분의 타입을 명시해주지 않으면, 에러가 발생함
        // MARK: 위 방법이 마음에들지 않으면 그냥 인자로 MetaType을 받는 수 밖에없는듯...
        if let viewController = self.navigationController?.previousViewController(context: RedViewController().self) {
            lbCurrentViewController.text = String(describing: type(of: viewController))
            print("\(viewController.dummyDataNextViewController)")
        }
    }
}
