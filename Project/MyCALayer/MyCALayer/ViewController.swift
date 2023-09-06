//
//  ViewController.swift
//  MyCALayer
//
//  Created by 구태호 on 2023/09/06.
//

import UIKit

class ViewController: UIViewController {
    lazy var testView: UIView = {
        let testView = UIView()
        testView.translatesAutoresizingMaskIntoConstraints = false
        testView.backgroundColor = UIColor.red
       
        return testView
    }()
    
    lazy var cameraView: UIView = {
        let cameraView = UIView()
        cameraView.translatesAutoresizingMaskIntoConstraints = false
        cameraView.backgroundColor = UIColor.black.withAlphaComponent(0.75)
       
        return cameraView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(testView)
        NSLayoutConstraint.activate([
            testView.topAnchor.constraint(equalTo: view.topAnchor),
            testView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            testView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            testView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        
        view.addSubview(cameraView)
        NSLayoutConstraint.activate([
            cameraView.topAnchor.constraint(equalTo: view.topAnchor),
            cameraView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            cameraView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            cameraView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        cameraView.layoutIfNeeded()
        
        initCameraLayer()
        cameraView.mask(rect: CGRect(origin: calcGuideContentRectOrigin(), size: .init(width: view.bounds.width / 2, height: view.bounds.width / 2)), isRectMasking: true)
        
    }
    
    private func initCameraLayer() {
        // 카메라 뷰 사이즈에 맞게 레이어 초기화
        let guideLayer = CAShapeLayer()
        guideLayer.frame = CGRect(origin: calcGuideBorderRectOrigin(), size: .init(width: (view.bounds.width / 2) + 20, height: (view.bounds.width / 2) + 20))
        guideLayer.fillColor = UIColor.black.cgColor
        
        // 패스 생성
        let path = UIBezierPath(rect: guideLayer.bounds)
        guideLayer.fillRule = .evenOdd
        
        // 오버레이 이미지 등록 `camOverlayImageView.frame`
        // path.append(UIBezierPath(rect: <#T##CGRect#>))
        guideLayer.path = path.cgPath
        
        // 뷰에 레이어를 씌움
        cameraView.layer.addSublayer(guideLayer)
    }
    
    private func calcGuideContentRectOrigin() -> CGPoint {
        let startX = view.center.x - cameraView.bounds.width / 4
        let startY = view.center.y - cameraView.bounds.height / 4
        
        return CGPoint(x: startX, y: startY)
    }
    
    private func calcGuideBorderRectOrigin() -> CGPoint {
        let startX = (view.center.x - cameraView.bounds.width / 4) - 10
        let startY = (view.center.y - cameraView.bounds.height / 4) - 10
        
        return CGPoint(x: startX, y: startY)
    }
}

