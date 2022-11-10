//
//  ViewController.swift
//  MyUILabelSizeWithUIView
//
//  Created by 구태호 on 2022/11/10.
//

import UIKit
import SnapKit

// 소스코드로 뷰를 생성할 때, UIView내부에 UILabel이 있는 경우,
// UILabel의 text 사이즈만큼 UIView를 생성할 수 있는지 확인하기위한 예제임.
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let bubbleView = UIView()
        bubbleView.backgroundColor = .black
        view.addSubview(bubbleView)
        
        let lbBubbleText = UILabel()
        lbBubbleText.text = "가나다라마바사"
        lbBubbleText.textAlignment = .center
        lbBubbleText.textColor = .white
        lbBubbleText.sizeToFit()
        print("@@@ 버블 텍스트 뷰 고유 사이즈 -> \(lbBubbleText.intrinsicContentSize)")
        bubbleView.addSubview(lbBubbleText)
        
        let bubbleViewPadding: CGFloat = 36
        let labelWidth = lbBubbleText.intrinsicContentSize.width + bubbleViewPadding
        
        lbBubbleText.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(12)
        }
        
        bubbleView.snp.makeConstraints {
            $0.width.equalTo(labelWidth)
            $0.bottom.trailing.equalToSuperview().inset(18)
        }
        
        view.layoutIfNeeded()
        
        bubbleView.layer.cornerRadius = bubbleView.frame.height / 2
    }
}

