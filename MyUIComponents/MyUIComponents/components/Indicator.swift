//
//  Indicator.swift
//  MyUIComponents
//
//  Created by 구태호 on 2022/07/24.
//

import UIKit

extension UIViewController {
    private static var indicator = UIView()
    
    func initIndicator() {
        // 기초 View
        let indicator = UIView()
        indicator.frame.size = CGSize(width: 128.0, height: 128.0)
        indicator.layer.cornerRadius = indicator.frame.height / 6
        indicator.clipsToBounds = true
        indicator.center = self.view.center
        // 블러처리
        indicator.backgroundColor = .clear
        indicator.blur()
        
        let layer = CAReplicatorLayer()
        layer.frame = CGRect(x: 0, y: 0, width: 15, height: 7)
        
        let circle = CALayer()
        // 점 간 간격, 점 개수, 점 크기
        let CIRCLE_SPACE = 20.0
        let CIRCLE_COUNT = 3
        let CIRCLE_WIDTH = 14.0
        let CIRCLE_HEIGHT = 14.0
        // 점을 포함한 레이어의 너비
        // let LAYER_WIDTH = (CIRCLE_WIDTH * Double(CIRCLE_COUNT)) + (CIRCLE_SPACE * (Double(CIRCLE_COUNT - 1)))
        // 점 위치
        // let CIRCLE_X_POSITION = self.view.center.x - LAYER_WIDTH / 2
        // let CIRCLE_Y_POSITION = self.view.center.y - CIRCLE_HEIGHT / 2
        let CIRCLE_X_POSITION = indicator.bounds.width / 2 - 32
        let CIRCLE_Y_POSITION = indicator.bounds.height / 2 - CIRCLE_HEIGHT
        
        // 점 위치 지정
        circle.frame = CGRect(x: CIRCLE_X_POSITION, y: CIRCLE_Y_POSITION, width: CIRCLE_WIDTH, height: CIRCLE_HEIGHT)
        circle.cornerRadius = circle.frame.width / 2
        // blossom 프로젝트로 이관 시 UIColor Extension으로 변경
        circle.backgroundColor = UIColor(red: 90/255.0, green: 90/255.0, blue: 90/255.0, alpha: 1).cgColor
        // 레이어에 점 객체 추가
        layer.addSublayer(circle)
        // 점 객체 개수
        layer.instanceCount = CIRCLE_COUNT
        // 점간 간격 지정
        layer.instanceTransform = CATransform3DMakeTranslation(CIRCLE_SPACE, 0, 0)
        
        let animation = CABasicAnimation(keyPath: #keyPath(CALayer.opacity))
        animation.fromValue = 1.0
        animation.toValue = 0.2
        animation.duration = 1
        animation.repeatCount = .infinity
        circle.add(animation, forKey: nil)
        // 각 개체간 애니메이션 딜레이 설정
        layer.instanceDelay = animation.duration / Double(layer.instanceCount)
        
        print(self.view.center)
        print(circle.frame.minX)
        
        // view에 레이어를 추가함
        indicator.layer.addSublayer(layer)
        let dotView = UIView()
        dotView.frame = CGRect(origin: self.view.center, size: CGSize(width: 1, height: 1))
        dotView.backgroundColor = .black
        
        self.view.addSubview(indicator)
        self.view.addSubview(dotView)
        
        dismissIndicator()
        // self.view.layer.addSublayer(layer)
    }
    
    func dismissIndicator() {
        UIViewController.indicator.isHidden = true
    }
    
    func showIndicator() {
        UIViewController.indicator.isHidden = false
    }
    
    func showDefaultIndicator() {
        let replicatorLayer = CAReplicatorLayer()
        let animation = CABasicAnimation(keyPath: #keyPath(CALayer.opacity))

        let line = CALayer()
        let lineCount: Int = 12
        let duration: TimeInterval = 1.0
        let lineSize: CGSize = CGSize(width: 20, height: 6)
        let lineColor: UIColor = UIColor.darkGray

        let angle = CGFloat.pi * 2 / CGFloat(lineCount)
        let rotation = CATransform3DMakeRotation(angle, 0, 0, 1.0)

        replicatorLayer.instanceTransform = rotation
        replicatorLayer.instanceCount = lineCount
        replicatorLayer.instanceDelay = duration / TimeInterval(lineCount)

        line.backgroundColor = lineColor.cgColor
        line.frame = CGRect(x: 50, y: 50, width: 20, height: 6)
        line.cornerRadius = lineSize.height / 2

        animation.fromValue = 1.0
        animation.toValue = 0.0
        animation.repeatCount = Float.greatestFiniteMagnitude
        animation.timingFunction = CAMediaTimingFunction(name: .linear)
        animation.duration = duration

        replicatorLayer.addSublayer(line)
        self.view.layer.addSublayer(replicatorLayer)

        // x:
        // y: half the height, changing affects rotation of lines
        line.position = CGPoint(x: 48, y: replicatorLayer.frame.maxX / 2)

        line.add(animation, forKey: nil)
    }
}
