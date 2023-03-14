//
//  ViewController.swift
//  MyCustomView
//
//  Created by 구태호 on 2023/03/09.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var baseTextFieldView: CommonTextFieldView!
    @IBOutlet var underlineLabelView: CommonLabelView!
    @IBOutlet var btShortMessage: CommonButton!
    @IBOutlet var btMassiveMessage: CommonButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // TODO: safeAreaLayoutGuild 추가 정리하기
        /*
         let safeAreaGuide = view.safeAreaLayoutGuide
         tintButton.topAnchor.constraint(equalTo: safeAreaGuide.topAnchor, constant: 18).isActive = true
         tintButton.leadingAnchor.constraint(equalTo: safeAreaGuide.leadingAnchor, constant: 18).isActive = true
         tintButton.trailingAnchor.constraint(equalTo: safeAreaGuide.trailingAnchor, constant: -18).isActive = true
         */
        
        initAction()
        
        underlineLabelView.labelClickClosure = { [self] _ in
            underlineLabelView.underline = true
            showToast(message: "지정된 URL: \(underlineLabelView.url ?? "지정된 URL 없음!")")
        }
    }
    
    func initAction() {
        btShortMessage.addAction(isIndicate: true) {
            self.showToast(message: "NVidia Tegra X1 chop inside Switch")
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.btShortMessage.hideIndicator()
            }
        }
        
        btMassiveMessage.addAction(isIndicate: true) {
            self.showToast(message: "When the view is visible onscreen, this guide reflects the portion of the view that is not covered by navigation bars, tab bars, toolbars, and other ancestor views. (In tvOS, the safe area reflects the area not covered the screen's bezel.) If the view is not currently installed in a view hierarchy, or is not yet visible onscreen, the layout guide edges are equal to the edges of the view.")
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.btMassiveMessage.hideIndicator()
            }
        }
    }
}

