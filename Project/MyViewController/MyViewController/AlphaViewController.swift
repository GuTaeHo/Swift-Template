//
//  AlphaViewController.swift
//  MyViewController
//
//  Created by 구태호 on 2023/01/11.
//

import UIKit

class AlphaViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func onClickBack(_ sender: Any) {
        dismiss(animated: true)
    }
    
    // MARK: AlphaViewController 의 부모인 MainViewController 는 현재 AlphaViewController 를 표시하고 있기 때문에 BravoViewController 를 띄울 수 없음
    /*
        [Presentation] Attempt to present <MyViewController.BravoViewController: 0x103204b60> on <MyViewController.MainViewController: 0x10090a750> (from <MyViewController.MainViewController: 0x10090a750>) which is already presenting <MyViewController.AlphaViewController: 0x100f055d0>.
     */
    @IBAction func showBravo(_ sender: Any) {
        if let parant = presentingViewController as? MainViewController {
            parant.showBravoViewController()
        }
    }
}
