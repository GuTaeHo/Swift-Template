import UIKit

class Cocobean {
    var androidKing: String
    
    // 이니셜라이저 등록 (스위프트는 반드시 변수를 등록할 때 초기화를 해주어야함.)
    // 변수를 초기화 하지 않으려면 옵서널로 선언하거나, 이니셜라이저(생성자)를 선언해주어야 함
    init(name: String) {
        self.androidKing = name
    }
    
    func commonMethod() -> String {
        return self.androidKing
    }
    
    var commonProperty: String {
        get {
            return self.androidKing
        }
    }
    
    // lazy 키워드는 최초로 호출될 경우에 초기화를 함(즉, 미리만들어두는 것이 아닌 필요할 때 만들어서 반환함)
    // 한번 호출된 이후에 다시 호출되지 않음(메모리에 계속 상주함)
    // MARK: 클로저를 만들어두고 호출시 함수를 () 로 만들고 바로 반환하기 때문에 메모리 누수가 일어나지 않음
    lazy var meetAndKing: String = {
        return "Hello my name is \(self.androidKing)"
    }()
    
    deinit {
        print("Cocobean deinit")
    }
}

var cocobean = Cocobean(name: "andKing~~!")
cocobean.meetAndKing

cocobean = nil

// 타입 프로퍼티 접근 방법 "클래명.프로퍼티명"
// Cocobean.commonProperty
