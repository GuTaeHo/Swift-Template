//
//  ViewController.swift
//  MyLabel
//
//  Created by 구태호 on 2023/07/04.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var lbDefaultSpacing: CommonLabel!
    @IBOutlet var lbSpacingZero: CommonLabel!
    @IBOutlet var lbSpacingFivePointZero: CommonLabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // lbSpacingFivePointZero.letterSpace = 10
        lbSpacingZero.concatLetterSpacing(20)?.concatLineSpacing(5)
    }
}

