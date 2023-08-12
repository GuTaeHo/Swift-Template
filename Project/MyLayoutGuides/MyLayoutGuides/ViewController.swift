//
//  ViewController.swift
//  MyLayoutGuides
//
//  Created by 구태호 on 2023/08/06.
//

import UIKit

class ViewController: UIViewController {
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = .white
        scrollView.showsVerticalScrollIndicator = false
        scrollView.contentInset.top = 12
        
        return scrollView
    }()
    
    lazy var addViewInStackViewButton: UIButton = {
        let button = UIButton()
        button.configuration = .filled()
        button.configuration?.baseBackgroundColor = .darkGray
        button.configuration?.baseForegroundColor = .white
        button.configuration?.title = "추가하기"
        button.configuration?.subtitle = "스택 뷰 내부에 뷰 추가"
        button.configuration?.image = UIImage(systemName: "plus")
        button.configuration?.cornerStyle = .capsule
        button.configuration?.titlePadding = 6
        button.configuration?.imagePadding = 6
        button.translatesAutoresizingMaskIntoConstraints = false
        
        // MARK: 버튼 상태가 변할 때 호출되는 클로저를 지원함
        button.configurationUpdateHandler = { button in
            switch button.state {
            case .normal:
                button.configuration?.showsActivityIndicator = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    button.configuration?.showsActivityIndicator = false
                    let view = self.makeView()
                    
                    self.layoutMarginsTestStackView.addArrangedSubview(view)
                    view.heightAnchor.constraint(equalToConstant: 80).isActive = true
                    // 뷰에 제스쳐 등록
                    view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.clickedViewInStackview(_:))))
                }
                break
                
            default :
                break
            }
        }
        
        return button
    }()
    
    lazy var layoutMarginsTestView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemIndigo
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layoutMargins = .init(top: 6, left: 12, bottom: 6, right: 12)
       
        return view
    }()
    
    lazy var layoutMarginsTestLabel: UILabel = {
        let label = UILabel()
        label.text = "layoutMargins 테스트 중..."
        label.backgroundColor = .orange
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var layoutMarginsTestStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.backgroundColor = .lightGray
        stackView.axis = .vertical
        stackView.layer.cornerRadius = 12
        stackView.layoutMargins = UIEdgeInsets(top: 6, left: 12, bottom: 6, right: 12)
        // MARK: 스택뷰의 레이아웃 마진 활성화
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 12
        
        return stackView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addMarginTestView()
        addScrollView()
        addButton()
    }
    
    func addMarginTestView() {
        // MARK: 스크롤 뷰의 contentInset 처럼 UIView 는 layoutMargins 속성이 존재
        // MARK: 해당 속성을 통해 뷰와 콘텐츠 사이에 패딩을 넣어줄 수 있다.
        layoutMarginsTestView.addSubview(layoutMarginsTestLabel)
        NSLayoutConstraint.activate([
            layoutMarginsTestLabel.topAnchor.constraint(equalTo: layoutMarginsTestView.layoutMarginsGuide.topAnchor),
            layoutMarginsTestLabel.bottomAnchor.constraint(equalTo: layoutMarginsTestView.layoutMarginsGuide.bottomAnchor),
            layoutMarginsTestLabel.leadingAnchor.constraint(equalTo: layoutMarginsTestView.layoutMarginsGuide.leadingAnchor),
            layoutMarginsTestLabel.trailingAnchor.constraint(equalTo: layoutMarginsTestView.layoutMarginsGuide.trailingAnchor)
        ])
        
        view.addSubview(layoutMarginsTestView)
        NSLayoutConstraint.activate([
            layoutMarginsTestView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            layoutMarginsTestView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            layoutMarginsTestView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    func addScrollView() {
        view.addSubview(scrollView)
        scrollView.addSubview(layoutMarginsTestStackView)
        
        // 스크롤 뷰 제약 활성화
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: self.layoutMarginsTestView.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
        ])
        
        layoutMarginsTestStackView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        layoutMarginsTestStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        layoutMarginsTestStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        layoutMarginsTestStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        
        // 세로 방향의 스크롤을 위한 너비 맞춤
        layoutMarginsTestStackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        
        for _ in 0...5 {
            let view = makeView()
            
            layoutMarginsTestStackView.addArrangedSubview(view)
            view.heightAnchor.constraint(equalToConstant: 80).isActive = true
            // 뷰에 제스쳐 등록
            view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(clickedViewInStackview(_:))))
        }
    }
    
    func addButton() {
        view.addSubview(addViewInStackViewButton)
        addViewInStackViewButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -18).isActive = true
        addViewInStackViewButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -12).isActive = true
    }
    
    /// 뷰 생성
    func makeView() -> UIView {
        let view = UIView()
        view.layer.cornerRadius = 12
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layoutMargins = .init(top: 6, left: 12, bottom: 6, right: 12)
        view.backgroundColor = UIColor(red: .random(in: 0..<1), green: .random(in: 0..<1), blue: .random(in: 0..<1), alpha: 1.0)
       
        return view
    }
    
    /// 스택 뷰에서 제거
    @objc func clickedViewInStackview(_ sender: UITapGestureRecognizer) {
        guard let view = sender.view else { return }
        layoutMarginsTestStackView.removeFromStackView(view: view)
        // layoutMarginsTestStackView.removeAllViewsInStackView()
    }
}

