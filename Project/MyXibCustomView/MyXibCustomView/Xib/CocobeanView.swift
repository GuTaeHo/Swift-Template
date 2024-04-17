//
//  CocobeanView.swift
//  MyXibCustomView
//
//  Created by 구태호 on 2022/11/09.
//

import UIKit

// loadNibNamed() 메소드는 파일의 init(coder:) 를 호출함
/// - warning: xib 파일의 Custom Class 에 커스텀 클래스 명을 입력한 뒤, 앱을 호출하면 무한 루프가 돌면서 죽게됨

// MARK: 무한 루프를 방지하기 위해 init(coder: NSCoder)나, init(frame: CGRect)와 같은 init 메서드에서 같은 클래스의 xib를 로드하지말 것!
// MARK: custom class 대신, 부모 클래스나 다른 곳에서 xib를 로드할 것!
class CocobeanView: UIView {
    // 소스코드에서 호출 (인스턴스 생성 시)
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        loadView()
    }
    
    // 스토리보드에서 호출될 경우 아래 호출
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadView()
    }
    
    
    // MARK: 커스텀 뷰 에서 Xib 를 인스턴스화 하지 말것!
    func loadView() {
        let view = Bundle.main.loadNibNamed(CocobeanView.className, owner: self, options: nil)?.first as! UIView
        view.frame = bounds
        addSubview(view)
    }
}
