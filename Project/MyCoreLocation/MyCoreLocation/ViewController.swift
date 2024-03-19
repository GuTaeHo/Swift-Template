//
//  ViewController.swift
//  MyCoreLocation
//
//  Created by 구태호 on 3/19/24.
//

import UIKit
import Combine
import CoreLocation


class ViewController: UIViewController {
    lazy var authorization: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "위치 정보 접근 권한 확인중..."
        label.font = .systemFont(ofSize: 18)
        return label
    }()
    lazy var recentLocation: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "최근 위치:"
        label.font = .systemFont(ofSize: 14)
        label.numberOfLines = 0
        return label
    }()
    lazy var currentLocation: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "현재 위치:"
        label.font = .systemFont(ofSize: 14)
        label.numberOfLines = 0
        return label
    }()
    
    let locationManager = LocationManager()
    var cancellable = Set<AnyCancellable>()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.addSubview(authorization)
        view.addSubview(recentLocation)
        view.addSubview(currentLocation)
        NSLayoutConstraint.activate([
            authorization.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            authorization.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        NSLayoutConstraint.activate([
            recentLocation.topAnchor.constraint(equalTo: authorization.bottomAnchor, constant: 12),
            recentLocation.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 12),
            recentLocation.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -12)
        ])
        NSLayoutConstraint.activate([
            currentLocation.topAnchor.constraint(equalTo: recentLocation.bottomAnchor, constant: 12),
            currentLocation.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 12),
            currentLocation.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -12)
        ])
        
        locationManager.authorizationStatusPublisher.sink { [weak self] status in
            switch status {
            case .denied:
                self?.authorization.text = "위치 정보 권한 거부됨"
            case .authorizedAlways, .authorizedWhenInUse:
                self?.authorization.text = "위치 정보 권한 허용됨"
                self?.locationManager.requestLocation()
            default:
                self?.authorization.text = "위치 정보 권한 필요"
                self?.locationManager.requestAuthorization()
            }
        }.store(in: &cancellable)
        
        locationManager.locationPublisher.sink { [weak self] location in
            self?.currentLocation.text = "현재 위치: \(location?.coordinate ?? .init())"
        }.store(in: &cancellable)
        recentLocation.text = "최근 위치: \(locationManager.requestLocationImmediately()?.coordinate ?? .init())"
    }
}

