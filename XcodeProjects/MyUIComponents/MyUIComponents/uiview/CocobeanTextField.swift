//
//  CocobeanTextField.swift
//  MyUIComponents
//
//  Created by 구태호 on 2022/07/25.
//

import UIKit

// @IBDesignable 이 적용되면 InterfaceBuilder가 즉시 커스텀 뷰를 업데이트하며,
// storyboard 에서 실시간으로 렌더링되는것을 볼 수 있음
@IBDesignable
class CocobeanTextField: UIView {
    @IBOutlet var messageView: UIView!
    @IBOutlet var tfMessage: UITextField!
    @IBOutlet var lbTextCount: UILabel!
    @IBOutlet var deleteButtonView: UIView!
    @IBOutlet var clickableButtonView: UIView!
    @IBOutlet var btClickable: UIButton!
    
    var onButtonClick: (() -> ())?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.loadXib()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.loadXib()
    }
    
    private func loadXib() {
        let bundle = Bundle(for: CocobeanTextField.self)
        let identifier = String(describing: CocobeanTextField.self)
        let view = bundle.loadNibNamed(identifier, owner: self, options: nil)?.first as! UIView
        
        view.frame = bounds
        addSubview(view)
        
        initLayout()
    }
    
    private func initLayout() {
        tfMessage.delegate = self
        // 프로젝트에서 사용시 addAction(for: .editingChanged) { _ in } 로 변경하기
        tfMessage.addTarget(self, action: #selector(onEditingTextView(_:)), for: .editingChanged)
        
        // onButton() 메서드로 버튼의 visibility를 조정할 수 있음
        clickableButtonView.addAction {
            self.onButtonClick?()
        }
        
        deleteButtonView.addAction {
            self.tfMessage.text = ""
            self.lbTextCount.text = "(0/50)"
            self.deleteButtonView.isHidden = true
        }
    }
    
    /// 버튼 활성화 및 기능 정의
    /// - Parameters:
    /// - buttonImage: 버튼 이미지 명 (없을 경우 버튼 표시 X)
    /// - closure: 버튼 클릭 시 호출될 기능(클로저)
    public func setOnButtonClickListener(buttonImage: String?, closure: @escaping () -> ()) {
        if let buttonImage = buttonImage,
            let image = UIImage(named: buttonImage) {
            clickableButtonView.isHidden = false
            self.btClickable.setImage(image, for: .normal)
        } else {
            self.btClickable.isHidden = true
        }
        self.onButtonClick = closure
    }
    
    @objc func onEditingTextView(_ textField: UITextField) {
        guard let count = tfMessage.text?.count else { return }
        
        if count > 50 {
            tfMessage.deleteBackward()
            return
        }
        
        if count > 0 {
            deleteButtonView.isHidden = false
            
        } else {
            deleteButtonView.isHidden = true
        }
        
        lbTextCount.text = "(\(count)/50)"
    }
}

extension CocobeanTextField: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        messageView.layer.borderColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        messageView.layer.borderColor = #colorLiteral(red: 0.3176470588, green: 0.3176470588, blue: 0.3176470588, alpha: 1)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
    }
}
