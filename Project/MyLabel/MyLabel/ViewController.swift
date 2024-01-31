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
    @IBOutlet var lbFontValue: UILabel!
    
    @IBOutlet var fontSizeSlider: UISlider!
    @IBOutlet var letterSpacingSlider: UISlider!
    @IBOutlet var lineSpacingSlider: UISlider!
    @IBOutlet var fontSlider: UISlider!
    
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
        guard let value = formatter(num: sender.value) else { return }
        lbLetterValue.text = value
        lbSingleline.letterSpace = CGFloat((value as NSString).floatValue)
        lbMultiline.letterSpace = CGFloat((value as NSString).floatValue)
    }
    
    @IBAction func lineValueChanged(_ sender: UISlider) {
        guard let value = formatter(num: sender.value) else { return }
        lbLineValue.text = value
        lbSingleline.letterSpace = CGFloat((value as NSString).floatValue)
        lbMultiline.letterSpace = CGFloat((value as NSString).floatValue)
    }
    
    @IBAction func fontValueChanged(_ sender: UISlider) {
        let step: Float = 1
        let roundedValue = round(sender.value / step) * step
        sender.value = roundedValue
        
        var fontType: UIFont.FontType = .pretendardRegular
        switch Int(sender.value) {
        case 0:
            fontType = .pretendardRegular
            lbFontValue.text = "Regular"
        case 1:
            fontType = .pretendardMedium
            lbFontValue.text = "Medium"
        case 2:
            fontType = .pretendardSemiBold
            lbFontValue.text = "Semi-Bold"
        case 3:
            fontType = .pretendardBold
            lbFontValue.text = "Bold"
        default:
            lbFontValue.text = "오류"
        }
        
        lbSingleline.fontType = fontType
        lbMultiline.fontType = fontType
    }
    
    
    func formatter(num: Float) -> String? {
        return String(format: "%.2f", num)
    }
}

