import UIKit

var greeting = "Hello, playground"


class DateUtil {
    public static func getDate(format: String = "MM-dd") -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: Date())
    }
    
    // startDate -> 미 입력 시 오늘을 기준으로 차이 계산
    // format -> 날짜 반환 형태
    public static func getSubDate(startDate: String? = nil, endDate: String, format: String) -> Int? {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.locale = Locale(identifier: "ko")
        
        // 시작일이 입력된 경우
        if let startDate = startDate {
            guard
                let start = formatter.date(from: startDate),
                let end = formatter.date(from: endDate)
            else {
                return nil
            }
            
            var unwrapDate1 = 0
            var unwrapDate2 = 0
            
            if let date1 = Calendar.current.dateComponents([.day], from: start).day {
                unwrapDate1 = date1
            }
            
            if let date2 = Calendar.current.dateComponents([.day], from: end).day {
                unwrapDate2 = date2
            }
            
            return unwrapDate2 - unwrapDate1
        } else {
            guard
                let end = formatter.date(from: endDate)
            else {
                return nil
            }
            
            let start = Date()
            
            var unwrapDate1 = 0
            var unwrapDate2 = 0
            
            if let date1 = Calendar.current.dateComponents([.day], from: start).day {
                unwrapDate1 = date1
            }
            
            if let date2 = Calendar.current.dateComponents([.day], from: end).day {
                unwrapDate2 = date2
            }
            
            if unwrapDate2 > unwrapDate1 {
                return unwrapDate2 - unwrapDate1
            }
            
            return nil
        }
    }
    
    public static func dateDiffrence(fromString: String, toString: String, format: String = "yyyyMMdd") -> Int?  {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        
        let fromDate = formatter.date(from: fromString) ?? Date()
        let toDate = formatter.date(from: toString) ?? Date()
        
        let delta = toDate.timeIntervalSince(fromDate)
        let today = Date()
        if delta < 0 {
            return nil
        } else {
            return Int(delta / 60 / 60 / 24)
        }
    }
}

DateUtil.getDate()
DateUtil.getDate(format: "yyyy-MM-dd")
DateUtil.getDate(format: "MM.dd")


var dic = [String:String]()
dic.updateValue("가가가가나", forKey: "가")
dic.updateValue("나가가가나", forKey: "나")
dic.updateValue("다라가가나", forKey: "라")
dic.updateValue("마마마마바", forKey: "삼")
dic.updateValue("후아후아히", forKey: "후")
dic.updateValue("라저라고누", forKey: "니")

let orderTime = DateUtil.getDate(format: "yyyyMMdd")
let reserDate = "20220719"

DateUtil.getSubDate(endDate: reserDate, format: "yyyyMMdd")
DateUtil.dateDiffrence(fromString: orderTime, toString: reserDate, format: "yyyyMMdd")

// let interval = Date() - reserDate
// print(interval.day)
// print(interval.month)
// print(interval.hour)


extension Date {
    static func -(recent: Date, previous: Date) -> (month: Int?, day: Int?, hour: Int?, minute: Int?, second: Int?) {
        let day = Calendar.current.dateComponents([.day], from: previous, to: recent).day
        let month = Calendar.current.dateComponents([.month], from: previous, to: recent).month
        let hour = Calendar.current.dateComponents([.hour], from: previous, to: recent).hour
        let minute = Calendar.current.dateComponents([.minute], from: previous, to: recent).minute
        let second = Calendar.current.dateComponents([.second], from: previous, to: recent).second

        return (month: month, day: day, hour: hour, minute: minute, second: second)
    }
}



