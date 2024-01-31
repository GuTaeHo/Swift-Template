//
//  ViewController.swift
//  MyUIViewConvert
//
//  Created by 구태호 on 1/31/24.
//

import UIKit

/**
 특정 뷰의 좌표계를 부모 뷰가 아닌 지정된 뷰를 기준으로 변경할 때, `UIView.convert(_:to)` 를 사용하면된다.
 
 좌표를 변환하는 방법은 두 가지가 있다.
 1. convert(_ point:from):
    - point: 기존 뷰의 좌표 또는 프레임
    - from: 기존 뷰의 슈퍼 뷰 (`nil을 전달하면` window를 기준으로 상대좌표를 구하므로, 절대좌표 획득이 가능하다.)
    `새로운 기준이 될 뷰` 에서 호출하면 된다.
 2. convert(_ point:to) -
    - point: 기존 뷰의 좌표 또는 프레임
    - to: 새로운 기준이 될 뷰 (`nil을 전달하면` window를 기준으로 상대좌표를 구하므로, 절대좌표 획득이 가능하다.)
    `기존 뷰의 슈퍼 뷰` 에서 호출하면 된다.
 */
class ViewController: UIViewController {
    @IBOutlet var parentView: UIView!
    @IBOutlet var childView: UIView!
    @IBOutlet var childIndigoView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        print("view frame: \(view.frame)")
        print("parentView frame: \(parentView.frame)")
        print("childView frame:  \(childView.frame)")
        print("childIndigoView frame:  \(childIndigoView.frame)")
        
        let childToView1 = childView.convert()!
        print("childView1 to view: \(childToView1)")
        
        let childToView2 = childView.convert(to: view)!
        print("childView2 to view: \(childToView2)")
        
        let childFromView1 = view.convert(childView.frame, from: parentView)
        print("childView1 from view: \(childFromView1)")
        
        let childFromView2 = view.convert(childView.frame, from: view)
        print("childView2 from view: \(childFromView2)")
        
        let childIndigoView = childIndigoView.convert(to: parentView)!
        print("childIndigoView to parentView: \(childIndigoView)")
    }
    
}


extension UIView {
    /// 변경된 좌표계를 기준으로 좌표를 반환합니다.
    /// - view: 새로운 기준이 될 뷰
    /// - Warning: `view` 가 nil 일 경우 `window` 를 기준으로 계산합니다.
    /// - Returns: 새로운 좌표가 반환됩니다,
    func convert(to view: UIView? = nil) -> CGPoint? {
        guard let parentView = self.superview else { return nil }
        return parentView.convert(frame.origin, to: view)
    }
}
