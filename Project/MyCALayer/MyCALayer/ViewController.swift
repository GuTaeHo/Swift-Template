//
//  ViewController.swift
//  MyCALayer
//
//  Created by 구태호 on 2023/09/06.
//

import UIKit

class ViewController: UIViewController {
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "Vision-Pro.jpg")
        imageView.contentMode = .scaleAspectFit
       
        return imageView
    }()
    
    lazy var cameraView: UIView = {
        let cameraView = UIView()
        cameraView.translatesAutoresizingMaskIntoConstraints = false
        cameraView.backgroundColor = UIColor.black.withAlphaComponent(0.75)
       
        return cameraView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        view.addSubview(cameraView)
        NSLayoutConstraint.activate([
            cameraView.topAnchor.constraint(equalTo: view.topAnchor),
            cameraView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            cameraView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            cameraView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        cameraView.layoutIfNeeded()
        
        // 뷰에 레이어를 씌움
        cameraView.layer.addSublayer(makeCameraLayer())
        cameraView.mask(rect: CGRect(origin: calcGuideContentRectOrigin(), size: .init(width: view.bounds.width / 2, height: view.bounds.width / 2)), isRectMasking: true)
        
    }
    
    private func makeCameraLayer() -> CAShapeLayer {
        // 카메라 뷰 사이즈에 맞게 레이어 초기화
        let guideLayer = CAShapeLayer()
        guideLayer.frame = CGRect(origin: calcGuideBorderRectOrigin(), size: .init(width: (view.bounds.width / 2) + 10, height: (view.bounds.width / 2) + 10))
        guideLayer.strokeColor = UIColor.systemGray3.cgColor
        guideLayer.lineWidth = 10
        
        // 패스 생성
        let path = UIBezierPath()
        
        // 브라켓 세 점의 위치
        var pathA: CGPoint = .zero
        var pathB: CGPoint = .zero
        var pathC: CGPoint = .zero
        
        /* 좌측 상단 브라켓 */
        pathA.x = guideLayer.bounds.minX
        pathA.y = guideLayer.bounds.minY + 30
        pathB.x = guideLayer.bounds.minX
        pathB.y = guideLayer.bounds.minY
        pathC.x = guideLayer.bounds.minX + 30
        pathC.y = guideLayer.bounds.minY
        
        path.move(to: pathA)
        path.addLine(to: pathB)
        path.addLine(to: pathC)
        
        /* 우측 상단 브라켓 */
        pathA.x = guideLayer.bounds.maxX - 30
        pathA.y = guideLayer.bounds.minY
        pathB.x = guideLayer.bounds.maxX
        pathB.y = guideLayer.bounds.minY
        pathC.x = guideLayer.bounds.maxX
        pathC.y = guideLayer.bounds.minY + 30
        
        path.move(to: pathA)
        path.addLine(to: pathB)
        path.addLine(to: pathC)
        
        /* 우측 하단 브라켓 */
        pathA.x = guideLayer.bounds.maxX
        pathA.y = guideLayer.bounds.maxY - 30
        pathB.x = guideLayer.bounds.maxX
        pathB.y = guideLayer.bounds.maxY
        pathC.x = guideLayer.bounds.maxX - 30
        pathC.y = guideLayer.bounds.maxY
        
        path.move(to: pathA)
        path.addLine(to: pathB)
        path.addLine(to: pathC)
        
        /* 좌측 하단 브라켓 */
        pathA.x = guideLayer.bounds.minX + 30
        pathA.y = guideLayer.bounds.maxY
        pathB.x = guideLayer.bounds.minX
        pathB.y = guideLayer.bounds.maxY
        pathC.x = guideLayer.bounds.minX
        pathC.y = guideLayer.bounds.maxY - 30
        
        path.move(to: pathA)
        path.addLine(to: pathB)
        path.addLine(to: pathC)
        
        guideLayer.path = path.cgPath
        guideLayer.lineCap = .round
        guideLayer.lineJoin = .round
        return guideLayer
    }
    
    private func calcGuideContentRectOrigin() -> CGPoint {
        let startX = view.center.x - cameraView.bounds.width / 4
        let startY = view.center.y - cameraView.bounds.height / 4
        
        return CGPoint(x: startX, y: startY)
    }
    
    private func calcGuideBorderRectOrigin() -> CGPoint {
        let startX = (view.center.x - cameraView.bounds.width / 4) - 5
        let startY = (view.center.y - cameraView.bounds.height / 4) - 5
        
        return CGPoint(x: startX, y: startY)
    }
}

