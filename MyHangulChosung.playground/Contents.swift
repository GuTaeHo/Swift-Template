import UIKit

let hangul = ["ㄱ","ㄲ","ㄴ","ㄷ","ㄸ","ㄹ","ㅁ","ㅂ","ㅃ","ㅅ","ㅆ","ㅇ","ㅈ","ㅉ","ㅊ","ㅋ","ㅌ","ㅍ","ㅎ"]
/// 1. 초성분리해주는 함수
/// - Parameter word: 검색어
/// - Returns: 초성분리된 결과
func chosungCheck(word: String) -> String {
    var result = ""
    /*
     참고 : https://hongssup.tistory.com/130
     유니코드에서 한글 분리
     
     유니코드에서 한글은 0xAC00에서 0xD7A3 사이의 코드 값을 갖는다. 각 16진수 값은 10진수로 표시하면 44032와 55203으로 총 11,172개. 유니코드 내 한글은 초/중/종성의 조합으로 표현되며, 초성 19개, 중성 21개, 종성 28개를 조합하여 하나의 글자가 된다.

     초성 = ((문자코드 - 0xAC00) / 28) / 21
     중성 = ((문자코드 - 0xAC00) / 28 % 21
     종성 = (문자코드 - 0xAC00) % 28
     */
    
    /*
     부하예상되는 부분으로 초성 검색해야하는 (갯수 * 각 글자수) 만큼 for 문이 진행될텐데
     몇개 없을때는 괜찮겠지만, 1000개, 10000개 되었을때 이슈가 생기지 않을까..?
     애플 주소록도 첫번째 문자가 초성일때만 초성검색 하고 두개이상일때는 초성검색 하고 있지 않음.
     띄어쓰기 이슈, 특수문자 이슈 (한글유니코드값 범위 예외 추가함)
     */
    
    // 문자열하나씩 짤라서 확인
    for char in word {
        let octal = char.unicodeScalars[char.unicodeScalars.startIndex].value
        if 44032...55203 ~= octal { // 유니코드가 한글값 일때만 분리작업
            let index = (octal - 0xac00) / 28 / 21
            result = result + hangul[Int(index)]
        }
    }
    
    return result
}

/// 2. 현재 문자열이 초성으로만 이뤄졌는지
/// - Parameter word: 검색어
/// - Returns: Bool
func isChosung(word: String) -> Bool {
    // 해당 문자열이 초성으로 이뤄져있는지 확인하기.
    var isChosung = false
    for char in word {
        // 검색하는 문자열전체가 초성인지 확인하기
        if 0 < hangul.filter({ $0.contains(char)}).count {
            isChosung = true
        } else {
            // 초성이 아닌 문자섞이면 false 끝.
            isChosung = false
            break
        }
    }
    return isChosung
}

var searchText:String = "이용내역" // 초성 검색
var array = [
    "예약취소는 어떻게 하나요?", "이용내역을 삭제할 수 있나요?", "회원탈퇴는 어떻게 하나요?", "안심번호가 무엇인가요?"
]

chosungCheck(word: searchText)


/*
// 해당 문자열이 초성으로 이뤄져있는지 확인하기.
let isChosungCheck = isChosung(word: searchText)

// 필터링 조건
let filter = array.filter ({
    // 초성인경우
    // 검색되는 문자도 초성검색 옵션 추가.
    if isChosungCheck {
       return ($0.contains(searchText) || chosungCheck(word: $0).contains(searchText))
    }
    // 디폴트 동일문자열 검색
    else {
       return $0.contains(searchText)
    }
})
print(filter)
 */
