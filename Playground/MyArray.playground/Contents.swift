import UIKit

let sectionItems = [["가", "나", "다"], ["라", "마", "바"]]

sectionItems.count
sectionItems[0].count

/// 배열 사이즈 보다 큰 위치에 insert 시...?
var arrayForInsert = [1, 2, 3, 4, 5]

arrayForInsert.insert(3717, at: 5)




struct Customer: Codable {
    var intValue: Int?
    var stringValue: String?
    var boolValue: Bool?
    
    
}


var items = [Customer]()
items.append(Customer())
items.append(Customer(intValue: 5))
items.append(Customer(intValue: 3, stringValue: "ㅎㅇ"))
items.append(Customer(intValue: 1, stringValue: "ㅎㅇ", boolValue: true))


items.forEach {
    print($0)
}

let customer = Customer()
// MARK: 클래스 타입 -> 문자열 추출
print(String(describing: Customer.self))
// MARK: 인스턴스 -> 문자열 추출
print(String(describing: type(of: customer)))
