//
//  ViewController.swift
//  MyLabel
//
//  Created by 구태호 on 2023/07/04.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var lbSingleline: CommonLabel!
    @IBOutlet var lbMultiline: CommonLabel!
    
    @IBOutlet var lbFontSizeValue: UILabel!
    @IBOutlet var lbLetterValue: UILabel!
    @IBOutlet var lbLineValue: UILabel!
    
    @IBOutlet var fontSizeSlider: UISlider!
    @IBOutlet var letterSpacingSlider: UISlider!
    @IBOutlet var lineSpacingSlider: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func fontSizeChanged(_ sender: UISlider) {
        let step: Float = 1
        let roundedValue = round(sender.value / step) * step
        sender.value = roundedValue
        
        lbFontSizeValue.text = "\(Int(sender.value))"
        lbSingleline.fontSize = Int(sender.value)
        lbMultiline.fontSize = Int(sender.value)
    }
    
    @IBAction func letterValueChanged(_ sender: UISlider) {
        lbLetterValue.text = "\(sender.value)"
        lbSingleline.letterSpace = CGFloat(sender.value)
        lbMultiline.letterSpace = CGFloat(sender.value)
    }
    
    @IBAction func lineValueChanged(_ sender: UISlider) {
        lbLineValue.text = "\(sender.value)"
        lbSingleline.lineSpace = CGFloat(sender.value)
        lbMultiline.lineSpace = CGFloat(sender.value)
    }
}

