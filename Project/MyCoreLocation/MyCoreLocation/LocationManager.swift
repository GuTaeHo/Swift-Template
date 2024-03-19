//
//  LocationManager.swift
//  MyCoreLocation
//
//  Created by 구태호 on 3/19/24.
//

import Foundation
import CoreLocation
import Combine

protocol LocationService {
    /// 사용자 위치
    var locationPublisher: AnyPublisher<CLLocation?, Never> { get }
    /// 위치 권한 상태
    var authorizationStatusPublisher: AnyPublisher<CLAuthorizationStatus, Never> { get }
    /// 사용자에게 위치 권한을 요청
    func requestAuthorization()
    /// 사용자의 현재 위치를 요청 (사용자 현재 위치를 반환하고 자동 중지)
    func requestLocation()
    /// 수동으로 위치를 가져오기 시작
    func startUpdatingLocation()
    /// 수동으로 위치를 가져오기 중지
    func stopUpdatingLocation()
}


final class LocationManager: NSObject, LocationService {
    
    private let locationManager: CLLocationManager
    
    private let location: CurrentValueSubject<CLLocation?, Never>
    private let authorizationStatus: CurrentValueSubject<CLAuthorizationStatus, Never>
    
    var locationPublisher: AnyPublisher<CLLocation?, Never> {
        return location.eraseToAnyPublisher()
    }
    
    var authorizationStatusPublisher: AnyPublisher<CLAuthorizationStatus, Never> {
        return authorizationStatus.eraseToAnyPublisher()
    }
    
    override init() {
        locationManager = CLLocationManager()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        location = .init(nil)
        authorizationStatus = .init(locationManager.authorizationStatus)
        super.init()
        locationManager.delegate = self
    }
    
    /// 일회성으로 현재 위치를 요청합니다.
    /// - Note: 위치 정보 갱신에 수 초가 소요될 수 있음
    func requestLocation() {
        locationManager.requestLocation()
    }
    
    func requestLocationImmediately() -> CLLocation? {
        locationManager.location
    }
    
    func requestAuthorization() {
        locationManager.requestWhenInUseAuthorization()
    }
    
    func startUpdatingLocation() {
        locationManager.startUpdatingLocation()
    }
    
    func stopUpdatingLocation() {
        locationManager.stopUpdatingLocation()
    }
}

extension LocationManager: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        location.send(locations.last)
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        authorizationStatus.send(manager.authorizationStatus)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        location.send(nil)
    }
}
