import UIKit

// UserDefaults 와 UserDefaults.standard 는 서로 같은 저장소일까?
// 결론은 UserDefaults 그 자체로는 사용 할 수 없음 (객체화 되지 않았기 때문)
var userDefaults = UserDefaults?
var standardUserDefaults = UserDefaults.standard
