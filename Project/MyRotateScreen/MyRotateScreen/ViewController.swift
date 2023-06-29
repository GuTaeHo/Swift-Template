//
//  ViewController.swift
//  MyRotateScreen
//
//  Created by 구태호 on 2023/06/28.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var textField: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textField.delegate = self
        // Do any additional setup after loading the view.
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        
        /// 현재 연결된 window 객체 반환
        /// - note: compactMap -> 값이 nil 인 경우 제거, Optional 인 경우 벗겨서 배열 반환
        let window = UIApplication.shared.connectedScenes.filter({ $0.activationState == .foregroundActive }).map({ $0 as? UIWindowScene }).compactMap({$0}).first?.windows.filter({ $0.isKeyWindow }).first
        
        /// 현재 화면 회전 방향 확인
        if window?.windowScene?.interfaceOrientation.isPortrait == true {
            print("portrait")
        } else {
            print("landscape")
        }
    }
}

extension ViewController: UITextViewDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
}

