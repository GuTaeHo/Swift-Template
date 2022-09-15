import UIKit

// lowercased() 테스트
// contains() 테스트
// 공백 테스트
// split() 테스트

// 모두 통과한 경우 어댑터에 추가

var menuName = [
    " [동궁찜닭] ㅠㅠ 둘이먹다 셋이죽어도 모를맛!!!",
    "Nano_Machine_Son !!",
    "(New) 치즈바사삭",
    "불금치킨+시카고피자+에그타르트"
]

struct Item {
    var code: String
    var name: String
    
    init(_ code: String, _ name: String) {
        self.code = code
        self.name = name
    }
}

var Items = [
    Item("M", "간장장"),
    Item("204", "사이다"),
    Item("651", "전화기"),
    Item("E", "충전기"),
    Item("123", "모니터"),
    Item("E", "이클립스"),
    Item("M", "화과자"),
    Item("404", "정물화"),
    Item("503", "장독대"),
    Item("E", "멀티탭"),
    Item("452", "스위프트"),
    Item("349", "손가락"),
    Item("600", "꼬마김밥"),
    Item("M", "화산재"),
    Item("E", "장발장"),
    Item("M", "화장실"),
    Item("649", "무더위"),
    Item("503", "말린감"),
    Item("306", "포카칩"),
    Item("M", "양꼬치"),
    Item("E", "자동차"),
    Item("A", "운동화")
]

let keyword = "화"


for menuName in menuName {
    if menuName.lowercased().contains(keyword.lowercased()) {
        print(menuName)
    }
}

for item in Items {
    if item.name.contains(keyword) == false {
        // 키워드 해당 안됨(다음 반복)
        continue
    } else if item.code == "M" || item.code == "E" || item.code == "A" {
        // 대표메뉴, 이벤트 아이템 인 경우
        continue
    } else {
        // 키워드에 존재하면서, 대표메뉴, 이벤트 등에 포함이 안되는 아이템
        print(item.name)
    }
}
