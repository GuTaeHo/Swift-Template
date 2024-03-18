//
//  ViewController.swift
//  MyUILayoutGuide
//
//  Created by 구태호 on 3/18/24.
//

import UIKit
import Combine

class ViewController: UIViewController {
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .lightGray
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    let timerPublisher = Timer.publish(every: 2, on: .main, in: .default).autoconnect()
    var cancellable = Set<AnyCancellable>()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        initScrollView()
        addIndicatorView()
        bind()
    }
    
    func initScrollView() {
        let redView: UIView = {
            let redView = UIView(frame: .zero)
            redView.backgroundColor = .systemPink
            redView.translatesAutoresizingMaskIntoConstraints = false
            return redView
        }()
        
        let indigoView: UIView = {
            let indigoView = UIView(frame: .zero)
            indigoView.backgroundColor = .systemIndigo
            indigoView.translatesAutoresizingMaskIntoConstraints = false
            return indigoView
        }()
        
        let orangeView: UIView = {
            let orangeView = UIView(frame: .zero)
            orangeView.backgroundColor = .systemOrange
            orangeView.translatesAutoresizingMaskIntoConstraints = false
            return orangeView
        }()
        
        view.addSubview(scrollView)
        
        // 스크롤 뷰를 뷰 컨트롤러와 맞춤
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
        
        scrollView.addSubview(redView)
        scrollView.addSubview(indigoView)
        scrollView.addSubview(orangeView)
        
        NSLayoutConstraint.activate([
            redView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            redView.leadingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.leadingAnchor),
            redView.trailingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.trailingAnchor),
            redView.heightAnchor.constraint(equalToConstant: 300)
        ])
        
        NSLayoutConstraint.activate([
            indigoView.topAnchor.constraint(equalTo: redView.bottomAnchor),
            indigoView.leadingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.leadingAnchor),
            indigoView.trailingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.trailingAnchor),
            indigoView.heightAnchor.constraint(equalToConstant: 300)
        ])
        
        NSLayoutConstraint.activate([
            orangeView.topAnchor.constraint(equalTo: indigoView.bottomAnchor),
            orangeView.leadingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.leadingAnchor),
            orangeView.trailingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.trailingAnchor),
            orangeView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            orangeView.heightAnchor.constraint(equalToConstant: 300)
        ])
    }
    
    func addIndicatorView() {
        let containerView: UIView = {
            let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.isUserInteractionEnabled = false
            view.backgroundColor = .init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
            return view
        }()
        
        let activityView: UIActivityIndicatorView = {
            let activityView = UIActivityIndicatorView()
            activityView.hidesWhenStopped = true
            activityView.startAnimating()
            activityView.color = .white
            activityView.translatesAutoresizingMaskIntoConstraints = false
            return activityView
        }()
        
        containerView.addSubview(activityView)
        NSLayoutConstraint.activate([
            activityView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            activityView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            activityView.widthAnchor.constraint(equalToConstant: 40),
            activityView.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        view.addSubview(containerView)
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            containerView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            containerView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        ])
    }
    
    func bind() {
        timerPublisher.sink { timer in
            print(timer.timeIntervalSinceNow)
        }.store(in: &cancellable)
    }
}
