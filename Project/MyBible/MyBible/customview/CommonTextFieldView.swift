//
//  CommonTextFieldView.swift
//  MyRegex
//
//  Created by 구태호 on 2023/03/09.
//

import UIKit


@IBDesignable
class CommonTextFieldView: UIView {
    @IBOutlet var messageView: UIView!
    @IBOutlet var tfMessage: UITextField!
    @IBOutlet var textCountView: UIView!
    @IBOutlet var lbTextCount: UILabel!
    @IBOutlet var deleteButtonView: UIView!
    @IBOutlet var clickableButtonView: UIView!
    @IBOutlet var ivClickable: UIImageView!
    
    /// 특정 이벤트 발생 시 추가적으로 동작시키고 싶은 코드를 외부에서 작성해서 클로저에 전달하면 됩니다.
    // ex) CommonTextFieldInstance.onClickDeleteButtonClosure = { do something }
    public var onClickClickableButtonClosure: (() -> ())?
    public var onClickDeleteButtonClosure: (() -> ())?
    public var onClickKeyboardReturn: (() -> ())?   // 키보드의 Return 키를 누를 경우 발생할 이벤트 정의
    public var textFieldEditingChangedClosure: (() -> ())?
    public var textFieldDidBeginEditingClosure: ((CommonTextFieldView) -> ())?
    public var textFieldDidEndEditingClosure: (() -> ())?
    
    private var _textMaxCount = 0
    // 버튼 이미지 (사용자 이미지 or 시스템에 있는 이미지)
    private var _buttonImageString: String?
    private var _systemButtonImageString: String?
    // 힌트
    private var _textPlaceholder: String = ""
    // 뷰 라운드 여부
    private var _isRound = false
    // 키보드 입력 숫자패드 여부
    private var _isKeyPad = false
    
    /// CocobeanTextField 의 Text 변경 시 해당 프로퍼티 사용
    public var text: String? {
        get {
            return tfMessage.text
        }
        
        set {
            if let newValue = newValue, newValue.count > 0 {
                deleteButtonView.display(isAnimate: true)
            } else {
                deleteButtonView.hidden(isAnimate: true)
            }
            tfMessage.text = newValue
        }
    }
    
    /// 키보드 리턴 버튼 타입 지정
    public var keyboardReturnType: UIReturnKeyType? {
        willSet {
            self.tfMessage.returnKeyType = newValue ?? UIReturnKeyType.default
        }
    }
    
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
    var isRound: Bool {
        get {
            return _isRound
        }
        
        set {
            if newValue {
                messageView.layer.cornerRadius = messageView.frame.height / 2
                _isRound = newValue
            }
        }
    }
    
    @IBInspectable
    var textPlaceholder: String {
        get {
            return self._textPlaceholder
        }
        
        set {
            let plachHolderColor = UIColor.gray
            _textPlaceholder = newValue
            tfMessage.attributedPlaceholder = NSAttributedString(string: newValue, attributes: [NSAttributedString.Key.foregroundColor: plachHolderColor])
        }
    }
    
    @IBInspectable
    var textMaxCount: Int {
        get {
            if _textMaxCount <= 0 {
                return .max
            }
            
            return _textMaxCount
        }
        
        set {
            _textMaxCount = newValue
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
    /// 이미지 지정 (사용자 Import)
    var buttonImage: String {
        get {
            return self._buttonImageString ?? ""
        }
        
        set {
            if let image = UIImage(named: newValue) {
                self._buttonImageString = newValue
                self.ivClickable.image = image
            }
        }
    }
    
    @IBInspectable
    /// 시스템 이미지 지정
    var systemButtonImage: String {
        get {
            return self._systemButtonImageString ?? ""
        }
        
        set {
            if let image = UIImage(systemName: newValue) {
                self._systemButtonImageString = newValue
                self.ivClickable.image = image
            }
        }
    }
    
    @IBInspectable
    /// 클릭 가능 버튼 숨김 여부
    var imageHidden: Bool {
        get {
            return clickableButtonView.isHidden
        }
        
        set {
            self.clickableButtonView.isHidden = newValue
        }
    }
    
    @IBInspectable
    /// 입력 방식 설정 (디폴트 or 키패드)
    var isKeyPad: Bool {
        get {
            return _isKeyPad
        }
        
        set {
            if newValue {
                self.tfMessage.keyboardType = .numberPad
            } else {
                self.tfMessage.keyboardType = .default
            }
            self._isKeyPad = newValue
        }
    }
    
    
    private func loadXib() {
        let bundle = Bundle(for: CommonTextFieldView.self)
        let identifier = String(describing: CommonTextFieldView.self)
        let view = bundle.loadNibNamed(identifier, owner: self, options: nil)?.first as! UIView
        
        view.frame = bounds
        addSubview(view)
        
        initLayout()
    }
    
    /// 유저 상호작용 여부
    public func isUserInteraction(isEnable: Bool) {
        if isEnable {
            tfMessage.isUserInteractionEnabled = true
            tfMessage.textColor = .black
            deleteButtonView.isHidden = false
        } else {
            tfMessage.isUserInteractionEnabled = false
            tfMessage.textColor = .gray
            deleteButtonView.isHidden = true
        }
    }
    
    /// 텍스트 필드 Responder 해제
    /// - note : @discardableResult 어노테이션 사용 시 메소드 반환 값 미 사용 경고가 표시되지않음
    @discardableResult
    public override func resignFirstResponder() -> Bool {
        tfMessage.resignFirstResponder()
    }
    
    private func initLayout() {
        tfMessage.delegate = self
        
        // 모서리 둥글게 표시
        messageView.layer.cornerRadius = 6
        
        tfMessage.addAction(for: .editingChanged) { _ in
            guard let count = self.tfMessage.text?.count else { return }
            
            if count > self.textMaxCount {
                self.tfMessage.deleteBackward()
                return
            }
            
            if count > 0 {
                self.deleteButtonView.display(isAnimate: true)
            } else {
                self.deleteButtonView.hidden(isAnimate: true)
            }
            
            self.lbTextCount.text = "(\(count)/\(self.textMaxCount))"
            self.textFieldEditingChangedClosure?()
        }
        
        clickableButtonView.addAction {
            self.onClickClickableButtonClosure?()
        }
        
        deleteButtonView.addAction {
            self.tfMessage.text = ""
            self.lbTextCount.text = "(0/\(self.textMaxCount))"
            self.deleteButtonView.hidden(isAnimate: true)
            self.tfMessage.becomeFirstResponder()
            self.onClickDeleteButtonClosure?()
        }
    }
}

extension CommonTextFieldView: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        messageView.layer.borderColor = UIColor.systemPink.cgColor
        textFieldDidBeginEditingClosure?(self)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        messageView.layer.borderColor = UIColor.gray.cgColor
        textFieldDidEndEditingClosure?()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        onClickKeyboardReturn?()
        return true
    }
}

