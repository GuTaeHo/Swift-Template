//
//  ViewController.swift
//  MyUIResponder
//
//  Created by 구태호 on 2023/07/28.
//

import UIKit

/**
 `UIResponder(이하 리스폰더로 칭함)` 는 이벤트에 반응 및 처리할 수 있는 객체를 의미한다.
 일반적으로 UIView 가 리스폰더를 상속받고있으며, UIApplication 도 이를 상속하고 있다.
 + UIApplication 은 앱당 하나만 존재하는 객체[shared 로 접근]로 앱의 주요한 이벤트(앱 상태변화, 사용자 이벤트 등)들을 관리한다.
 
 리스폰더는 처리되지 않은 이벤트를 상위 리스폰더로 전달하는 기능도 한다.
 만약 UIApplication -> UIWindow -> UIViewController -> UIView -> UIButton 계층이 있을 때,
 UIButton 이 이벤트를 처리하지않는다면 UIView 로 이벤트를 전달, UIView 가 처리하지않는다면 UIViewController 로 전달을 반복하며,
 최종적으로 UIApplication 이 이벤트를 처리하지 않는다면 버린다.
 - 일반적인 터치이벤트의 경우 터치된 뷰에서 시작해, 최종적으로 앱까지 도달함.
 
 위 이벤트를 처리하는 흐름을 하나의 사슬과 같다고 하여 `리스폰더 체인(Responder Chain)` 으로 부른다.
 
 이벤트를 가장 처음 받는 리스폰더를 `First Responder` 라고 부르며, 앱이 이벤트를 받을 경우 이 First Responder 에게 보낸다.
 
 리스폰더의 `next` 프로퍼티는 상위 리스폰더를 반환한다.
 예를들어, UIViewController 의 최상위 UIView 에 next 는 UIViewController 가 되며,
 UINavigationController 의 rootViewController 에 next 는 UINavigationController 가 된다.
 
 
 이를 프로퍼티를 오버라이딩하여 리스폰더 체인을 변경할 수 있다.
 
 만약, 사용자 터치 이벤트를 직접 처리하고 싶다면,
 touchesBegan(_:with:),
 touchesMoved(_:with:),
 touchesEnded(_:with:),
 touchesCancelled(_:with:)
 메서드를 오버라이딩하여 구현하면 된다.
 
 
 참고
 - https://seizze.github.io/2019/11/26/iOS%EC%9D%98-Responder%EC%99%80-Responder-Chain-%EC%9D%B4%ED%95%B4%ED%95%98%EA%B8%B0.html
 */
class ViewController: UIViewController {
    @IBOutlet var userInteractionDisabledView: UIView!
    @IBOutlet var textView: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        NotificationCenter.default.addObserver(self, selector: #selector(notifying), name: .post, object: nil)
        
        // UIResponder.next 는 이벤트처리가 가능한 다음 리스폰더를 반환한다.
        print(self.view == userInteractionDisabledView.next)
        print(self == self.view.next)
        
        
        // print(Unmanaged.passUnretained(userInteractionDisabledView).toOpaque())
    }
    
    // 리스폰더 체인의 다음 리스폰더를 항상 뷰로 제한
    override var next: UIResponder? {
        get { self.view }
    }

    @objc func notifying() {
        if let delegate = UIApplication.shared.delegate as? AppDelegate {
            textView.text = delegate.sharedText
        }
    }

    @IBAction func disableButton(_ sender: UIButton) {
        textView.text = "클릭됨"
    }
    
    @IBAction func printViewControllerOfButton(_ sender: UIButton) {
        textView.text = ""
        if let delegate = UIApplication.shared.delegate as? AppDelegate {
            delegate.sharedText = ""
        }
        _ = sender.viewController
    }
    
    // 뷰 컨트롤러 터치 시 호출, 처리할 수 있는 하위 뷰가 있다면 호출되지 않음.
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("터치 개수: \(touches.count)")
        touches.forEach {
            print("터치 좌표 (뷰 컨트롤러 기준): \($0.location(in: self.view))")
            print("터치 이전 좌표 (뷰 컨트롤러 기준): \($0.previousLocation(in: self.view))")
            print("터치 세기 (3D 터치 지원기종이거나 애플펜슬 사용 시): \($0.force)")
            print("터치 타입 (0: 직접 터치, 1: 별도의 입력 장치, 2: 펜슬, 3: 트랙패드나 마우스를 말하는 듯): \($0.type.rawValue)")
            print("터치 반경: \($0.majorRadius)")
        }
        print("터치 종류 (0: 터치, 1: 모션, 2: 원격 컨트롤, 3: 눌림, 10: 스크롤, 11: 호버, 14: 변형?): \(event?.type.rawValue ?? .zero)")
    }
    
    // 터치 이동시 호출
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        print(touches.first?.location(in: self.view) ?? .init())
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("터치 개수: \(touches.count)")
        touches.forEach {
            print("터치 좌표 (뷰 컨트롤러 기준): \($0.location(in: self.view))")
            print("터치 이전 좌표 (뷰 컨트롤러 기준): \($0.previousLocation(in: self.view))")
            print("터치 세기 (3D 터치 지원기종이거나 애플펜슬 사용 시): \($0.force)")
            print("터치 타입 (0: 직접 터치, 1: 별도의 입력 장치, 2: 펜슬, 3: 트랙패드나 마우스?): \($0.type.rawValue)")
            print("터치 반경: \($0.majorRadius)")
        }
        print("터치 종류 (0: 터치, 1: 모션, 2: 원격 컨트롤, 3: 눌림, 10: 스크롤, 11: 호버, 14: 변형?): \(event?.type.rawValue ?? .zero)")
    }
}

