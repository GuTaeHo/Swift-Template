import UIKit

class Cocobean {
    /* instance function 은 우리가 일반적으로 사용하는 메소드 임 */
    func instanceFunction() {
        print("Instance Function did override")
    }
    
    /*  class function 은 static func 처럼 클래스명.함수명 으로 객체 생성없이 바로 사용이 가능함
        static function 과 다르게 overriding 이 가능함. */
    class func classFunction() {
        print("Class Function did override")
    }
    
    /*  static function 은 클래스명.함수명 으로 객체 생성없이 바로 사용이 가능함
        class function 과 다르게 overriding 이 불가능함. */
    static func staticFunction() {
        print("Static Function didn't override")
    }
}

class CocobeanSon: Cocobean {
    override func instanceFunction() {
        print("Overrided Instance Function!")
    }
    
    override class func classFunction() {
        print("Overrided Class Function!")
    }
}

let cocobeanInstance = Cocobean()
cocobeanInstance.instanceFunction()

Cocobean.classFunction()
Cocobean.staticFunction()

let cocobeanSonInstance = CocobeanSon()
cocobeanSonInstance.instanceFunction()

CocobeanSon.classFunction()

