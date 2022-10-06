import UIKit

/**
 생성된 객체 A의 하위에 또 다른 객체 B가 있을 때, A의 참조를 nil로 변경하면 어떻게 될까?
 - 당연하게도 A의 참조가 사라져 B를 확인할 방법이 없음...
 - iOS 의 메모리 관리방법인 ARC 에서는 객체에 nil이 할당되었으며, 다른 객체가 참조하지 않다고 판단되었다면 메모리에서 객체를 지워버림
 */

class Parent {
    var child: Child?
}

class Child: Parent {
    var data: String?
}
var parent: Parent?
var child = Child()

parent = Parent()
parent?.child = child
child.data = "Child"
print(parent?.child?.data ?? "")

parent = nil

print(child.data ?? "")
