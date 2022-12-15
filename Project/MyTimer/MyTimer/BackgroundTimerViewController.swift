//
//  BackgroundTimerViewController.swift
//  MyTimer
//
//  Created by 구태호 on 2022/12/12.
//

import UIKit

class BackgroundTimerViewController: UIViewController {
    
    @IBOutlet var lbTimer: UILabel!
    @IBOutlet var btStartAndPause: UIButton!
    @IBOutlet var btStop: UIButton!
    
    enum TimerStatus: String {
        case start
        case pause
        case stop
    }
    
    var timer: DispatchSourceTimer?
    var timerStatus: TimerStatus = .pause
    var timerCount: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(didEnterForeground), name: UIApplication.didBecomeActiveNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(didEnterBackground), name: UIApplication.willResignActiveNotification, object: nil)
    }
    
    // 앱이 "Active[활성화]" 상태일 때 호출
    @objc func didEnterForeground() {
        startTimer()
    }
    
    // 앱이 "In-Active[비 활성화]" 상태일 때 호출
    @objc func didEnterBackground() {
        pauseTimer()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
        stopTimer()
    }
    
    private func startTimer() {
        if timer == nil {
            // 1. UI 관련 작업을 원한다면 queue에 .main 할당
            timer = DispatchSource.makeTimerSource(flags: [], queue: DispatchQueue.main)
            // 2. .now() 로 타이머 즉시 실행, repeating 엔 타이머 간격 지정
            timer?.schedule(deadline: .now(), repeating: 1)
            // 3. 타이머 동작 시 함께 실행될 이벤트 지정
            timer?.setEventHandler(handler: { [weak self] in
                self?.timerCount += 1
                self?.lbTimer.text = "\(self?.timerCount ?? -999)"
            })
        }
        
        resumeTimer()
    }
    
    // 재개
    private func resumeTimer() {
        timerStatus = .start
        btStartAndPause.setTitle("일시정지", for: .normal)
        timer?.resume()
    }
    
    // 일시정지
    private func pauseTimer() {
        timerStatus = .pause
        btStartAndPause.setTitle("재개", for: .normal)
        timer?.suspend()
    }
    
    // 정지(== 종료)
    private func stopTimer() {
        switch timerStatus {
        // MARK: resume() 상태로 다시 resume() 을 하면 에러 발생... 주의
        case .start:
            break
        // MARK: 타이머를 중지 시키기 전에 반드시 resume() 을 시켜야 크래쉬가 나지 않음.....
        case .pause:
            timer?.resume()
            break
        case .stop:
            return
        }
        timerCount = 0
        lbTimer.text = "\(timerCount)"
        btStartAndPause.setTitle("시작", for: .normal)
        timerStatus = .stop
        timer?.cancel()
        timer = nil
    }
    
    @IBAction func onClickStart(_ sender: Any) {
        switch timerStatus {
        case .start:
            pauseTimer()
            break
        case .pause, .stop:
            startTimer()
            break
        }
    }
    
    
    @IBAction func onClickStop(_ sender: Any) {
        stopTimer()
    }
    
    @IBAction func onClickBack(_ sender: Any) {
        dismiss(animated: true)
    }
}
