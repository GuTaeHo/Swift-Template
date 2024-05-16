//
//  ViewController.swift
//  MyAppTrackingTransparency
//
//  Created by 구태호 on 5/16/24.
//

/**
 사용자 및 사용자 장치를 추적하기위한 데이터에 접근하기 위해선
 
 1. plist 에 NSUserTrackingUsageDescription 을 추가하고 내용을 작성한다.
 2. ATTrackingManager 의 trackingAuthorizationStatus 를 확인한다.
 3. 아직 결정되지 않았다면 requestTrackingAuthorization(completionHandler:) 을 호출하여 권한을 요청한다.
 4. 광고 식별자: IDFA(Identifier for Advertising) 는 AdSupport 프레임워크를 통해 발급받을 수 있다.
    - ASIdentifierManager.shared().advertisingIdentifier.uuidString
 5. 앱 추적 허용이되지않은 앱에서는 광고 식별자를 획득해도 무의미한 값이 전달된다.
    ex)
    허용
    502D48C5-5201-432C-BAB9-5E72CA8266A2
    거부
    00000000-0000-0000-0000-000000000000
 */


import UIKit
import AdSupport
import AppTrackingTransparency


class ViewController: UIViewController {
    var trackingAuthorizationStatusLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 24)
        label.text = "앱 추적 허용 여부: 확인불가"
        return label
    }()
    
    var advertisingIdentifierLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 24)
        label.text = "IDFA: 확인불가"
        label.numberOfLines = 0
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.addSubview(trackingAuthorizationStatusLabel)
        view.addSubview(advertisingIdentifierLabel)
        
        NSLayoutConstraint.activate([
            trackingAuthorizationStatusLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 128),
            trackingAuthorizationStatusLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 18),
            trackingAuthorizationStatusLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -18),
            advertisingIdentifierLabel.topAnchor.constraint(equalTo: trackingAuthorizationStatusLabel.bottomAnchor, constant: 12),
            advertisingIdentifierLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 18),
            advertisingIdentifierLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -18),
        ])
        
        switch ATTrackingManager.trackingAuthorizationStatus {
        case .authorized:
            trackingAuthorizationStatusLabel.text = "앱 추적 허용 여부: 허용됨"
        case .denied:
            trackingAuthorizationStatusLabel.text = "앱 추적 허용 여부: 거부됨"
        case .notDetermined:
            trackingAuthorizationStatusLabel.text = "앱 추적 허용 여부: 허용됨"
        case .restricted:
            trackingAuthorizationStatusLabel.text = "앱 추적 허용 여부: 제한됨"
        @unknown default:
            break
        }
        // IDFA 획득
        advertisingIdentifierLabel.text = "IDFA: \(ASIdentifierManager.shared().advertisingIdentifier.uuidString)"
    }
}

