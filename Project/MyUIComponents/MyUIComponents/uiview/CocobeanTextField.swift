//
//  CocobeanTextField.swift
//  MyUIComponents
//
//  Created by 구태호 on 2022/07/25.
//

import UIKit


@IBDesignable
class CocobeanTextField: UIView {
    @IBOutlet var messageView: UIView!
    @IBOutlet var tfMessage: UITextField!
    @IBOutlet var textCountView: UIView!
    @IBOutlet var lbTextCount: UILabel!
    @IBOutlet var deleteButtonView: UIView!
    @IBOutlet var clickableButtonView: UIView!
    @IBOutlet var ivClickable: UIImageView!
    
    // 특정 이벤트 발생 시 추가적으로 동작시키고 싶은 코드를 외부에서 작성해서 클로저에 전달하면 됩니다.
    // ex) CommonTextFieldInstance.onClickDeleteButtonClosure = { do something }
    public var onClickListener: (() -> ())?
    public var onClickDeleteButtonClosure: (() -> ())?
    public var textFieldEditingChangedClosure: (() -> ())?
    public var textFieldDidBeginEditingClosure: (() -> ())?
    public var textFieldDidEndEditingClosure: (() -> ())?
    
    private var _textCount = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.loadXib()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.loadXib()
    }
    
    // MARK: Interface Builder(storyboard) 의 Attribute Inspector 에서
    // MARK: 값을 수정할 경우, 컴파일 시 아래 설정된 값이 반영됨
    @IBInspectable
    var textPlaceholder: String {
        get {
            return self.textPlaceholder
        }
        
        set {
            tfMessage.placeholder = newValue
        }
    }
    
    @IBInspectable
    var textMaxCount: Int {
        get {
            return _textCount
        }
        
        set {
            _textCount = newValue
            lbTextCount.text = "(0/\(newValue))"
        }
    }
    
    @IBInspectable
    var countHidden: Bool {
        get {
            textCountView.isHidden
        }
        
        set {
            textCountView.isHidden = newValue
        }
    }
    
    @IBInspectable
    var buttonImage: String {
        get {
            return self.buttonImage
        }
        
        set {
            if let image = UIImage(named: newValue) {
                self.ivClickable.image = image
            }
        }
    }
    
    @IBInspectable
    var imageHidden: Bool {
        get {
            return clickableButtonView.isHidden
        }
        
        set {
            self.clickableButtonView.isHidden = newValue
        }
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
        
        tfMessage.addAction(for: .editingChanged) { _ in
            guard let count = self.tfMessage.text?.count else { return }
            
            if count > self.textMaxCount {
                self.tfMessage.deleteBackward()
                return
            }
            
            if count > 0 {
                self.deleteButtonView.isHidden = false
            } else {
                self.deleteButtonView.isHidden = true
            }
            
            self.lbTextCount.text = "(\(count)/\(self.textMaxCount))"
            self.textFieldEditingChangedClosure?()
        }
        
        clickableButtonView.addAction {
            self.onClickListener?()
        }
        
        deleteButtonView.addAction {
            self.tfMessage.text = ""
            self.lbTextCount.text = "(0/\(self.textMaxCount))"
            self.deleteButtonView.isHidden = true
            self.tfMessage.becomeFirstResponder()
            self.onClickDeleteButtonClosure?()
        }
    }
}

extension CocobeanTextField: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        messageView.layer.borderColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        textFieldDidBeginEditingClosure?()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        messageView.layer.borderColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        textFieldDidEndEditingClosure?()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
    }
}

