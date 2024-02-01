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
        let roundingLayer1 = CALayer()
        roundingLayer1.frame = .init(origin: subLayersView.frame.origin, size: .init(width: 50, height: 50))
        roundingLayer1.backgroundColor = UIColor.red.cgColor
        roundingLayer1.cornerRadius = 6
        roundingLayer1.masksToBounds = true
        
        // offsetBy(dx:dy:) 로 x 와 y 를 더한 새로운 CGRect(상대적인 위치) 를 가져올 수 있다.
        let circleLayer2 = CALayer()
        circleLayer2.frame = roundingLayer1.frame.offsetBy(dx: 10 + roundingLayer1.bounds.size.width, dy: 0)
        circleLayer2.backgroundColor = UIColor.cyan.cgColor
        circleLayer2.cornerRadius = circleLayer2.bounds.height / 2
        
        // 삼각형은 CGPAth 와 CAShapeLayer 를 활용해 그릴 수 있다
        let triangleLayer3 = CAShapeLayer()
        triangleLayer3.frame = circleLayer2.frame.offsetBy(dx: 10 + circleLayer2.bounds.size.width, dy: 0)
        print(triangleLayer3.frame)
        
        let path = CGMutablePath()
        path.move(to: CGPoint(x: 0, y: triangleLayer3.frame.height))
        path.addLine(to: CGPoint(x: triangleLayer3.frame.width, y: triangleLayer3.frame.height))
        path.addLine(to: CGPoint(x: triangleLayer3.frame.width / 2, y: 0))
        path.closeSubpath()
        
        triangleLayer3.path = path
        triangleLayer3.fillColor = UIColor.magenta.cgColor
        triangleLayer3.cornerRadius = triangleLayer3.bounds.height / 2
        
        subLayersView.layer.addSublayers(roundingLayer1, circleLayer2, triangleLayer3)
    }
}
