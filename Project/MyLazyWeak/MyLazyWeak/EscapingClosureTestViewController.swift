//
//  EscapingClosureTestViewController.swift
//  MyLazyWeak
//
//  Created by 구태호 on 2023/03/26.
//

import UIKit


class EscapingClosureTestViewController: UIViewController {
    
    private var timer: Timer = Timer()
    private var repeatCount: Int = 0
    private var dummyValue: Int = 1
    public var notifyingViewControllerDeinitClosure: (() ->())?
    
    @IBOutlet var btEscape: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK: escaping 된 클로저 내부에서 self(현재 뷰 컨트롤러)를 강하게 참조[캡쳐]하고 있기 때문에, 뷰 컨트롤러가 dismiss 되더라도 deinit 이 호출되지 않고 타이머가 계속해서 동작함.
        /**
         - Reference Count
         1. 이전 ViewController 가 현재 뷰 컨트롤러를 present(참조) 하면서 reference count +1
         2. escaping 클로저 즉, repeatingClosure 가 내부에서 **강하게** 뷰 컨트롤러(self)를 참조함으로써 reference count +1
         3. 사용자가 ESCAPE 버튼을 누르면서 현재 뷰 컨트롤러 dismiss() 및 reference count -1
         4. 이미 뷰 컨트롤러는 사라졌지만 **클로저 내부에서 뷰 컨트롤러를 강하게 참조** 중임 reference **count == 1**
         5. deinit 이 호출(= 해당 뷰 컨트롤러는 사라지지않음)되지 않으며, 타이머도 지속적으로 클로저 호출 (메모리 누수 발생)
         */
        /*
        let repeatingClosure: (Timer) -> () = { timer in
            self.repeatCount += 1
            self.btEscape.setTitle("\(self.repeatCount)", for: .normal)
            print("\(self.repeatCount)")
        }
         */
        
        // MARK: escaping 된 클로저에서 현재 뷰 컨트롤러를 약하게 참조한다면...
        /**
         - Reference Count
         1. 이전 ViewController 가 현재 뷰 컨트롤러를 present(참조) 하면서 reference count +1
         2. escaping 클로저 즉, repeatingClosure 가 내부에서 **약하게** 뷰 컨트롤러(self)를 참조함으로써 reference count **유지**
         3. 사용자가 ESCAPE 버튼을 누르면서 현재 뷰 컨트롤러 dismiss() 및 reference count -1
         4. reference count 가 **0**이 되었으므로, 시스템은 deinit() 을 호출, 타이머 멈춤
         5. 뷰 컨트롤러가 완벽하게 사라졌으며, 타이머도 동작하지 않음
         */
        /*
        let repeatingClosure: (Timer) -> () = { [weak self] timer in
            self?.repeatCount += 1
            self?.btEscape.setTitle("\(self?.repeatCount ?? 0)", for: .normal)
            print("\(self?.repeatCount ?? 0)")
        }
         */
        
        
        // MARK: guard let self = self else { return } 구문 테스트...
        /// - note: 해당 구문을 사용해 항상 self? 로 옵셔널 체크를 하는게 아닌, 옵셔널이면 클로저를 즉시 종료할 수 있음,
        /// **하지만** 클로저가 하는 작업이 무거운(오래걸리는) 경우 클로저가 모두 동작(종료)한 다음 해제됨...
        /**
         - Reference Count
         1.
         */
        let repeatingClosure: (Timer) -> () = { [weak self] timer in
            guard let self = self else { return }
            for index in 1...100000 {
                self.dummyValue += index
                print("\(self.dummyValue)")
            }
            self.repeatCount += 1
            self.btEscape.setTitle("\(self.repeatCount)", for: .normal)
            print("\(self.repeatCount)")
        }
        
        
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true, block: repeatingClosure)
    }
    
    @IBAction func escapeClicked(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    deinit {
        print("EscapingClosureTestViewController 해제됨")
        timer.invalidate()
        notifyingViewControllerDeinitClosure?()
    }
}
