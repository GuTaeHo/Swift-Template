//
//  CALayerPlaygroundViewController.swift
//  MyCALayer
//
//  Created by 구태호 on 2/1/24.
//

import UIKit

class CALayerPlaygroundViewController: UIViewController {
    @IBOutlet var subLayersView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initSubLayersView()
    }
    
    func initSubLayersView() {
        // 마스킹 테스트용 커버 레이어
        let coverLayer0 = CALayer()
        coverLayer0.frame = .init(origin: .zero, size: subLayersView.bounds.size)
        coverLayer0.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5).cgColor
        
        let roundingLayer1 = CALayer()
        roundingLayer1.frame = .init(origin: subLayersView.frame.origin, size: .init(width: 50, height: 50))
        roundingLayer1.backgroundColor = UIColor.red.cgColor
        roundingLayer1.cornerRadius = 6
        roundingLayer1.masksToBounds = true
        
        // offsetBy(dx:dy:) 로 x 와 y 를 더한 새로운 CGRect(상대적인 위치) 를 가져올 수 있다.
        let circleLayer2 = CALayer()
        circleLayer2.frame = roundingLayer1.frame.offsetBy(dx: 10 + roundingLayer1.bounds.width, dy: 0)
        circleLayer2.backgroundColor = UIColor.cyan.cgColor
        circleLayer2.cornerRadius = circleLayer2.bounds.height / 2
        
        // 삼각형은 CGPAth 와 CAShapeLayer 를 활용해 그릴 수 있다
        let triangleLayer3 = CAShapeLayer()
        triangleLayer3.frame = circleLayer2.frame.offsetBy(dx: 10 + circleLayer2.bounds.width, dy: 0)
        print(triangleLayer3.frame)
        
        let path = CGMutablePath()
        path.move(to: CGPoint(x: 0, y: triangleLayer3.frame.height))
        path.addLine(to: CGPoint(x: triangleLayer3.frame.width, y: triangleLayer3.frame.height))
        path.addLine(to: CGPoint(x: triangleLayer3.frame.width / 2, y: 0))
        path.closeSubpath()
        
        triangleLayer3.path = path
        triangleLayer3.fillColor = UIColor.magenta.cgColor
        triangleLayer3.cornerRadius = triangleLayer3.bounds.height / 2
        
        // mask 와 fillRule 을 이용하면 뚫린 형태의 뷰를 그릴 수 있다.
        let maskLayer4 = CAShapeLayer()
        maskLayer4.frame = triangleLayer3.frame.offsetBy(dx: 10 + triangleLayer3.frame.width, dy: 0)
        coverLayer0.mask(rect: maskLayer4.frame, cornerRadius: 6)
        
        subLayersView.layer.addSublayers(coverLayer0, roundingLayer1, circleLayer2, triangleLayer3, maskLayer4)
    }
}
