//
//  SpeechBubble.swift
//  MySpeechBubble
//
//  Created by 구태호 on 2022/10/05.
//

import UIKit
import SnapKit

/* UIView 에 CGMutablePath 및 CALayer 를 사용하여 삼각형(말풍선 꼬리)을 만든 다음 해당 UIView 에 추가하는 예제임 */
class SpeechBubble: UIView {
    private var parentView: UIView!
    private var message: String!
    private var width: CGFloat!
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// - Parameter message: 말풍선에 표시될 텍스트
    /// - Parameter color: 말풍선 색상
    /// - Parameter parentView: 말풍선이 표시될 View의 상위 View
    /// - Parameter width: 말풍선 너비
    /// - Parameter tipWidth: 말풍선 꼬리 너비 (default: 20)
    /// - Parameter tipHeight: 말풍선 꼬리 높이 (default: 10)
    init(
        message: String,
        color: UIColor,
        parentView: UIView,
        width: CGFloat,
        tipWidth: CGFloat = 20,
        tipHeight: CGFloat = 10
    ) {
        super.init(frame: .zero)
        self.backgroundColor = color
        
        self.parentView = parentView
        self.message = message
        self.width = width
        
        let path = CGMutablePath()
        
        // path 시작 x 위치 (tip 시작 x 위치)
        let tipStartXPosition = (width / 2) - (tipWidth / 2)
        
        // 삼각형의 세 점의 사이에 선분을 그림
        path.move(to: CGPoint(x: tipStartXPosition, y: 0))
        path.addLine(to: CGPoint(x: width / 2, y: -tipHeight))
        path.addLine(to: CGPoint(x: tipStartXPosition + tipWidth, y: 0))
        path.addLine(to: CGPoint(x: 0, y: 0))
        
        // 설정된 경로(path) 내부에 색상을 칠함
        let shape = CAShapeLayer()
        shape.path = path
        shape.fillColor = color.cgColor
        
        // 현재 뷰에 생성된 삼각형을 추가
        self.layer.insertSublayer(shape, at: 0)
        // UIView를 벗어난 텍스트를 안보이도록 설정 (꼬리 표시)
        self.layer.masksToBounds = false
        // 말풍선 둥글게 표시
        self.layer.cornerRadius = 6
        
        self.addLabel(message: message)
    }
    
    private func addLabel(message: String) {
        let titleLabel = UILabel()
        titleLabel.textColor = .white
        titleLabel.text = message
        titleLabel.numberOfLines = 0
        titleLabel.lineBreakMode = .byCharWrapping // 글자 단위로 줄바꿈 (디폴트는 어절 단위)
        
        self.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(10)
            $0.left.right.equalToSuperview().inset(16)
        }
        
        addView()
    }
    
    private func addView() {
        self.parentView.addSubview(self)
        self.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.equalTo(width)
        }
    }
}
