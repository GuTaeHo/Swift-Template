//
//  ViewController.swift
//  MyDate
//
//  Created by 구태호 on 3/12/24.
//

import UIKit
import Combine

class ViewController: UIViewController {
    var runLoopPublisherLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    var timerPublisherLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    var timerScheduledButton: UIButton = {
        let button = UIButton(configuration: .filled())
        button.translatesAutoresizingMaskIntoConstraints = false
        button.configuration?.baseForegroundColor = .black
        button.configuration?.baseBackgroundColor = .lightGray
        button.layer.cornerRadius = 0
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.darkGray.cgColor
        return button
    }()
    
    private var cancellable = Set<AnyCancellable>()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(runLoopPublisherLabel)
        view.addSubview(timerPublisherLabel)
        view.addSubview(timerScheduledButton)
        
        NSLayoutConstraint.activate([
            runLoopPublisherLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 18),
            runLoopPublisherLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 12),
            runLoopPublisherLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -12)
        ])
        NSLayoutConstraint.activate([
            timerPublisherLabel.topAnchor.constraint(equalTo: runLoopPublisherLabel.bottomAnchor),
            timerPublisherLabel.leadingAnchor.constraint(equalTo: runLoopPublisherLabel.leadingAnchor),
            timerPublisherLabel.trailingAnchor.constraint(equalTo: runLoopPublisherLabel.trailingAnchor)
        ])
        NSLayoutConstraint.activate([
            timerScheduledButton.topAnchor.constraint(equalTo: timerPublisherLabel.bottomAnchor),
            timerScheduledButton.leadingAnchor.constraint(equalTo: timerPublisherLabel.leadingAnchor),
            timerScheduledButton.trailingAnchor.constraint(equalTo: timerPublisherLabel.trailingAnchor)
        ])
        
        DispatchQueue.main.async {
            let runLoop = RunLoop.main
            runLoop.schedule(
                after: runLoop.now,
                interval: .seconds(1)) { [weak self] in
                    self?.runLoopPublisherLabel.text = "RunLoop 핸들러를 이용한 타이머:\n" + runLoop.now.date.formatted(date: .complete, time: .standard)
                }.store(in: &self.cancellable)
            
            Timer.publish(every: 1.0, on: .main, in: .common)
                .autoconnect()
                .sink { [weak self] in
                    self?.timerPublisherLabel.text = "Timer 퍼블리셔를 이용한 타이머:\n" + $0.formatted(date: .numeric, time: .standard)
                }.store(in: &self.cancellable)
            Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] timer in
                self?.timerScheduledButton.configuration?.title = "Timer 스케쥴러를 이용한 타이머:\n\(Date().formatted(date: .numeric, time: .standard))"
            }
        }
    }
}

