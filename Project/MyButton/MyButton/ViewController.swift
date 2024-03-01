//
//  ViewController.swift
//  MyButton
//
//  Created by 구태호 on 2023/07/14.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var btCustom: CommonButton!
    // 기존 버튼
    lazy var regacyButton: UIButton = {
        let button = UIButton()
        button.setTitle("레거시 버튼", for: .normal)
        button.setTitle("레거시 버튼 눌림", for: .highlighted)
        button.setTitle("레거시 버튼 비활성화됨", for: .disabled)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    // iOS 15 부터 사용가능한 버튼
    lazy var enhancedButton: UIButton = {
        var configuration = UIButton.Configuration.filled()
        configuration.title = "개선된 버튼"
        configuration.subtitle = "iOS 15부터 사용가능"
        
        let button = UIButton(configuration: configuration)
        button.setTitle("개선된 버튼 \(5 - enhancedButtonCount)회 클릭가능", for: .normal)
        button.setTitle("개선된 버튼 눌림", for: .highlighted)
        button.setTitle("개선된 버튼 비활성화됨", for: .disabled)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.configurationUpdateHandler = { [weak self] bt in
            switch bt.state {
            case .highlighted:
                self?.enhancedButtonCount += 1
                break
            default:
                break
            }
            
            if self?.enhancedButtonCount ?? 0 > 4 {
                bt.isHighlighted = false
                bt.isEnabled = false
            }
            
            bt.setTitle("개선된 버튼 \(5 - (self?.enhancedButtonCount ?? 0))회 클릭가능", for: .normal)
        }
       
        return button
    }()
    
    var enhancedButtonCount: Int = 0
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
//        view.addSubview(regacyButton)
//        view.addSubview(enhancedButton)
        
//        NSLayoutConstraint.activate([
//            regacyButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 18),
//            regacyButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 18),
//            enhancedButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -18),
//            enhancedButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -18)
//        ])
        
//        print(UIScreen.main.nativeBounds.size)
//        print(UIScreen.main.bounds.size)
        
        
        btCustom.addAction {
            print("버튼 눌림")
        }
        
//        btCustom.addAction(.init(handler: { button in
//            
//        }), for: .touchUpInside)
    }
}

