//
//  ViewController.swift
//  MyPreview
//
//  Created by 구태호 on 11/5/23.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
}

// MARK: Xcode 15 부터 지원하는 Preview 기능은 iOS 17 이상부터 지원되는듯하다.
/// 기존의 플랫폼을 지원해야하는 레거시 프로젝트에서는 `@available` 어노테이션을 사용하면 미리보기가 효과적으로 동작한다.
@available(iOS 17, *)

/// 프리뷰를 구분할 수 있는 이름을 지을 수 있다.
#Preview("UIButton 프리뷰 테스트") {
    let button = UIButton(configuration: .filled())
    button.configuration?.title = "미리보기 버튼"
    return button
}

/// 프리뷰 표시 방법도 설정할 수 있다.
/// 특성 종류:
/// - fixedLayout(width: CGFloat, height: CGFloat) 또는 sizeTahtFitsLayout
/// - portrait 또는 portraitUpsideDown
/// - landscapeLeft 또는 landscapeRight
@available(iOS 17, *)
#Preview("UIViewController 프리뷰 테스트", traits: .landscapeRight) {
    UIViewController()
}
