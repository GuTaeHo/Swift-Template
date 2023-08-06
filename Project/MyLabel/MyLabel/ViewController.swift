//
//  ViewController.swift
//  MyLabel
//
//  Created by 구태호 on 2023/07/04.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var lbDefaultSpacing: UILabel!
    @IBOutlet var lbSpacingZero: UILabel!
    @IBOutlet var lbSpacingFivePointZero: UILabel!
    @IBOutlet var lbIntrinsicContentSize: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        lbSpacingZero.characterSpacing(0)
        lbSpacingFivePointZero.characterSpacing(5)
        
        print(lbIntrinsicContentSize.size())
    }
}

