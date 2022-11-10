//
//  SpeechBubbleForGuildLink.swift
//  MySpeechBubble
//
//  Created by 구태호 on 2022/11/10.
//

import UIKit
import SnapKit

class SpeechBubbleForGuildLink: UIView {
    private var message: String!
    private var color: UIColor!
    private var parentView: UIView!
    private var width: CGFloat!
    private var height: CGFloat!
    private var tipWidth: CGFloat!
    private var tipHeight: CGFloat!
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// - Parameter message: 말풍선에 표시될 텍스트
    /// - Parameter color: 말풍선 색상
    /// - Parameter parentView: 말풍선이 표시될 View의 상위 View
    /// - Parameter width: 말풍선 너비
    init(
        message: String,
        color: UIColor,
        parentView: UIView,
        width: CGFloat
    ) {
        super.init(frame: .zero)
        self.message = message
        self.color = color
        self.parentView = parentView
        self.width = width
        self.tipWidth = 20
        self.tipHeight = 10
        
        addView()
    }
    
    /* 말풍선 View에 추가 */
    private func addView() {
        self.parentView.addSubview(self)
        self.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.equalTo(width)
        }
        
        addLabel()
    }
    
    /* 말풍선 라벨 추가 */
    private func addLabel() {
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
        
        // Constraints 를 적용한 뒤 드로잉 사이클을 초기화 하여 View 를 미리 그림.
        // UILabel 이 그려졌기 때문에 View 의 사이즈를 특정할 수 있음
        self.layoutIfNeeded()
        
        height = self.frame.height
        
        addTail()
    }
    
    /* 말풍선 꼬리 추가 */
    private func addTail() {
        self.backgroundColor = color
        
        let path = CGMutablePath()
        // 삼각형의 세 점의 사이에 선분을 그림
        
        // path 시작 x 위치 (tip 시작 x 위치)
        let tipStartXPosition = width - (width / 20)
        path.move(to: CGPoint(x: tipStartXPosition, y: height))
        path.addLine(to: CGPoint(x: tipStartXPosition - (tipWidth / 2), y: height + tipHeight))
        path.addLine(to: CGPoint(x: tipStartXPosition - tipWidth, y: height))
        path.addLine(to: CGPoint(x: tipStartXPosition, y: height))
        
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
    }
}
