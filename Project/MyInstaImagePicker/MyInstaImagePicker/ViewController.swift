//
//  ViewController.swift
//  MyInstaImagePicker
//
//  Created by 구태호 on 2022/07/17.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var btMake: UIButton!
    @IBOutlet weak var btCenter: UIButton!
    @IBOutlet weak var btSize: UIButton!
    
    // imageView 들을 담을 배열
    private var imageViews = [UIImageView]()
    
    private let IS_IMAGE_VIEW_LIMIT = 4
    private var imageViewCount = 0
    private let imageNames = ["jar1.jpg", "jar2.jpg", "jar3.jpg", "simple.jpg", "unknown.jpg"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        makeImageView()
        imageViewCount += 1
    }
    
    private func makeImageView() {
        // view 좌표 및 크기 초기화
        let roundImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 128, height: 128))
        // view 가운데 이동
        roundImageView.center = CGPoint(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height / 2)
        roundImageView.image = UIImage(named: "\(imageNames[imageViewCount])")
        roundImageView.contentMode = .scaleAspectFill
        roundImageView.clipsToBounds = true
        roundImageView.layer.borderWidth = 3
        roundImageView.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        roundImageView.layer.cornerRadius = roundImageView.frame.height / 2
        // 블러 효과 적용
        // roundImageView.blur()
        // 드래그 이벤트 인식기 등록
        let panGesture = CocobeanPanGestureRecognizer(target: self, action: #selector(self.drag))
        // 이미지도 함께 저장
        panGesture.imageView = roundImageView
        
        roundImageView.addGestureRecognizer(panGesture)
        // 줌 이벤트 인식기 등록
        roundImageView.enableZoom()
        // 클릭 이벤트 등록 (애니메이션 등록됨)
        roundImageView.enableTap()
        
        view.addSubview(roundImageView)
        
        // 버튼 클릭 이벤트 등록
        let onClickCenterButton = UIAction { _ in
            UIView.animate(withDuration: 0.5)
            {
                roundImageView.center = CGPoint(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height / 2)
            }
        }
        
        btCenter.addAction(onClickCenterButton, for: .touchUpInside)
        
        imageViews.append(roundImageView)
        
        // 버튼 z index 조정
        self.view.bringSubviewToFront(btCenter)
        self.view.bringSubviewToFront(btSize)
    }
    
    
    @IBAction func onClickMakeButton(_ sender: UIButton) {
        if imageViewCount <= IS_IMAGE_VIEW_LIMIT {
            makeImageView()
            imageViewCount += 1
        }
    }
    
    @IBAction func onClickSizeButton(_ sender: UIButton) {
        if sender.isSelected {
            for imageView in imageViews {
                UIView.animate(withDuration: 0.5)
                {
                    // 크기 1.75배 증가
                    imageView.transform = CGAffineTransform(scaleX: 1.75, y: 1.75)
                }
            }
            
            sender.isSelected = false
        } else {
            for imageView in imageViews {
                UIView.animate(withDuration: 0.5)
                {
                    // 크기 원상태로 복구
                    imageView.transform = .identity
                }
            }
            
            sender.isSelected = true
        }
    }
    
    @objc func drag(sender: CocobeanPanGestureRecognizer) {
        // 부모 view 에서 sender(imageView)의 위치 출력
        // print("\(sender.location(in: self.view))")
        
        
        // view 충돌 체크 (화면 밖으로 나가지 않도록)
        // imageView 좌표 출력
        // print("\(roundImageView.frame.origin)")
        
        // imageView 데이터 검사
        guard let roundImageView = sender.imageView else { return }
        
        let x = roundImageView.frame.origin.x
        let y = roundImageView.frame.origin.y
        
        let viewWidthSize = self.view.frame.width
        let viewHeightSize = self.view.frame.height
        
        let endX = x + roundImageView.frame.width
        let endY = y + roundImageView.frame.height
        
        if x < 0 {
            UIView.animate(withDuration: 0.2, animations: {
                roundImageView.frame.origin.x = 5
            }) { _ in
                roundImageView.isUserInteractionEnabled = true
            }
            return
        }
        
        if y < 0 {
            UIView.animate(withDuration: 0.2) {
                roundImageView.frame.origin.y = 5
            }
            return
        }
        
        if endX > viewWidthSize {
            UIView.animate(withDuration: 0.2) {
                roundImageView.frame.origin.x = viewWidthSize - roundImageView.frame.width
            }
            return
        }
        
        if endY > viewHeightSize {
            UIView.animate(withDuration: 0.2) {
                roundImageView.frame.origin.y = viewHeightSize - roundImageView.frame.height
            }
            return
        }
        
        // imageView의 현재 좌표 저장
        let translation = sender.translation(in: self.view) // translation에 움직인 위치를 저장한다.
        
        // sender의 view는 sender가 바라보고 있는 circleView이다. 드래그로 이동한 만큼 circleView를 이동시킨다.
        sender.view!.center = CGPoint(x: sender.view!.center.x + translation.x, y: sender.view!.center.y + translation.y)
        
        // 0으로 움직인 값을 초기화 시켜준다.
        sender.setTranslation(.zero, in: self.view)
    }
}

