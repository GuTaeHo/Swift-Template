//
//  ViewController.swift
//  MySafeArea
//
//  Created by 구태호 on 2022/09/22.
//

import UIKit

// 현재 기기의 상,하,좌,우 SafeArea 확인 예제
class ViewController: UIViewController {
    @IBOutlet var lbSafeAreas: [UILabel]!
    
    private let TOP = 0
    private let LEFT = 1
    private let RIGHT = 2
    private let BOTTOM = 3
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        for index in 0..<lbSafeAreas.count {
            lbSafeAreas[index].text = "\(safeArea(direction: index) ?? 0)"
        }
    }
    
    private func safeArea(direction: Int) -> CGFloat? {
        guard
            let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
            let safeAreaInsets = windowScene.windows.first?.safeAreaInsets else
        {
            return nil
        }
        
        switch direction {
        case TOP:
            return safeAreaInsets.top
            
        case LEFT:
            return safeAreaInsets.left
            
        case RIGHT:
            return safeAreaInsets.right
            
        case BOTTOM:
            return safeAreaInsets.bottom
            
        default:
            return nil
        }
    }
}

