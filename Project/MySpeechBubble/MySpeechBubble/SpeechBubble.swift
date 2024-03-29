//
//  SpeechBubble.swift
//  MySpeechBubble
//
//  Created by 구태호 on 2022/10/05.
//

import UIKit
import SnapKit

/* 말풍선 꼬리 방향 (상, 우, 하, 좌) */
enum TipCenterDirection: Int {
    case TOP = 0
    case RIGHT = 1
    case BOTTOM = 2
    case LEFT = 3
}

/* 말풍선 꼬리 위치 (중, 우, 좌) */
enum TipEdgeDirection: Int {
    case CENTER = 0
    case RIGHT = 1
    case LEFT = 2
}

/* UIView 에 CGMutablePath 및 CALayer 를 사용하여 삼각형(말풍선 꼬리)을 만든 다음 해당 UIView 에 추가하는 예제임 */
class SpeechBubble: UIView {
    private var message: String!
    private var color: UIColor!
    private var parentView: UIView!
    private var centerDirection: TipCenterDirection!
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
    /// - Parameter centerDirection: 말풍선 꼬리 방향 (상, 하, 좌, 우)
    /// - Parameter tipWidth: 말풍선 꼬리 너비 (default: 20)
    /// - Parameter tipHeight: 말풍선 꼬리 높이 (default: 10)
    init(
        message: String,
        color: UIColor,
        parentView: UIView,
        centerDirection: TipCenterDirection,
        tipWidth: CGFloat = 20,
        tipHeight: CGFloat = 10
    ) {
        super.init(frame: .zero)
        self.message = message
        self.color = color
        self.centerDirection = centerDirection
        self.parentView = parentView
        self.tipWidth = tipWidth
        self.tipHeight = tipHeight
        
        addView()
    }
    
    /* 말풍선 View 에 추가 */
    private func addView() {
        self.parentView.addSubview(self)
        
        let titleLabel = UILabel()
        titleLabel.textColor = .white
        titleLabel.text = message
        titleLabel.numberOfLines = 0
        titleLabel.lineBreakMode = .byCharWrapping // 글자 단위로 줄바꿈 (디폴트는 어절 단위)
        
        let bubbleViewPadding: CGFloat = 24
        width = titleLabel.intrinsicContentSize.width + bubbleViewPadding
        height = titleLabel.intrinsicContentSize.height + bubbleViewPadding
        
        self.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(12)
        }
        
        self.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.centerX.equalToSuperview()
            $0.width.equalTo(width)
        }
        
        // Constraints 를 적용한 뒤 드로잉 사이클을 초기화 하여 View 를 미리 그림.
        // UILabel 이 그려졌기 때문에 View 의 사이즈를 특정할 수 있음
        self.layoutIfNeeded()
        
        addTail()
    }
    
    /* 말풍선 꼬리 추가 */
    private func addTail() {
        self.backgroundColor = color
        var path = CGMutablePath()
        // 삼각형의 세 점의 사이에 선분을 그림
        path = edgeDirectionCenterLayout()
        
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
    
    private func edgeDirectionCenterLayout() -> CGMutablePath {
        let path = CGMutablePath()
        
        switch centerDirection {
        case .TOP:
            // path 시작 x 위치 (tip 시작 x 위치)
            let tipStartXPosition = (width / 2) - (tipWidth / 2)
            path.move(to: CGPoint(x: tipStartXPosition, y: 0))
            path.addLine(to: CGPoint(x: width / 2, y: -tipHeight))
            path.addLine(to: CGPoint(x: tipStartXPosition + tipWidth, y: 0))
            path.addLine(to: CGPoint(x: 0, y: 0))
            break
            
        case .RIGHT:
            let tipStartYPosition = (height / 2) - (tipWidth / 2)
            path.move(to: CGPoint(x: width, y: tipStartYPosition))
            path.addLine(to: CGPoint(x: width + tipHeight, y: height / 2))
            path.addLine(to: CGPoint(x: width, y: (height / 2) + (tipWidth / 2)))
            path.addLine(to: CGPoint(x: width, y: tipStartYPosition))
            break
            
        case .BOTTOM:
            let tipStartXPosition = (width / 2) - (tipWidth / 2)
            path.move(to: CGPoint(x: tipStartXPosition, y: height))
            path.addLine(to: CGPoint(x: width / 2, y: height + tipHeight))
            path.addLine(to: CGPoint(x: tipStartXPosition + tipWidth, y: height))
            path.addLine(to: CGPoint(x: tipStartXPosition, y: height))
            break
            
        case .LEFT:
            let tipStartYPosition = (height / 2) - (tipWidth / 2)
            path.move(to: CGPoint(x: 0, y: tipStartYPosition))
            path.addLine(to: CGPoint(x: -tipHeight, y: height / 2))
            path.addLine(to: CGPoint(x: 0, y: (height / 2) + (tipWidth / 2)))
            path.addLine(to: CGPoint(x: 0, y: tipStartYPosition))
            break
            
        default:
            break
        }
        
        return path
    }
}
