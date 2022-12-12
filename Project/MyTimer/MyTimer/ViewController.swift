//
//  ViewController.swift
//  MyTimer
//
//  Created by 김경환 on 2021/11/23.
//

import UIKit

class ViewController: UIViewController {
    let timeSelector: Selector = #selector(ViewController.updateTime)
    // 타이머 업데이트 간격
    let interval = 1.0
    var count = 0
    
    @IBOutlet var timeCountBinding: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 타이머 간격, 동작될 뷰, 타이머가 구동될 때 실행될 함수, 사용자 정보, 반복 여부
        Timer.scheduledTimer(timeInterval: interval, target: self, selector: timeSelector, userInfo: nil, repeats: true)
    }
    
    @objc func updateTime() {
//        timeCountBinding.text = String(count)
//        count = count + 1
        let date = NSDate()
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss EEE"
        timeCountBinding.text = "현재시간 : " + formatter.string(from: date as Date)
    }

}

