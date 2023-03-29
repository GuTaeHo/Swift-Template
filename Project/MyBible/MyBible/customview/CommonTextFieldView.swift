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
    // ex) CommonTextFieldInstance.deleteButtonClosure = { do something }
    public var clickableButtonClosure: (() -> ())?
    /// 삭제 클릭 시 호출될 클로저 작성
    public var deleteButtonClosure: (() -> ())?
    /// 키보드 리턴 클릭 시 호출될 클로저 작성
    public var textFieldShouldReturnClosure: (() -> ())?
    /// 입력 시작 시 호출될 클로저 작성
    /// - note: 클로저 파라미터 CommonTextFieldVIew (자기 자신)
    public var textFieldEditingChangedClosure: (() -> ())?
    /// 입력 중 호출될 클로저 작성
    public var textFieldDidBeginEditingClosure: ((CommonTextFieldView) -> ())?
    /// 입력 종료 시 호출될 클로저 작성
    public var textFieldDidEndEditingClosure: (() -> ())?
    
    private var _textMaxCount = 0
    /// 버튼 이미지
    private var _clickableButtonImage: UIImage?
    /// 힌트
    private var _textPlaceholder: String = ""
    
    /// text 변경 시 해당 프로퍼티 사용
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
    
    /// 키보드 리턴 타입 지정
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
                _textMaxCount = 0
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
    /// 클릭 버튼 이미지
    /// - note: 지정된 버튼 없을 경우, 기본 시스템 이미지 적용
    var clickableButtonImage: UIImage {
        get {
            return _clickableButtonImage ?? UIImage(systemName: "arrow.right.circle")!
        }
        
        set {
            _clickableButtonImage = newValue
            ivClickable.image = _clickableButtonImage
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
        
        tfMessage.addAction(for: .editingChanged) {  [weak self] _ in
            guard let count = self?.tfMessage.text?.count else { return }
            
            if count > (self?.textMaxCount ?? -1) {
                self?.tfMessage.deleteBackward()
                return
            }
            
            if count > 0 {
                self?.deleteButtonView.display(isAnimate: true)
            } else {
                self?.deleteButtonView.hidden(isAnimate: true)
            }
            
            self?.lbTextCount.text = "(\(count)/\(self?.textMaxCount ?? -1))"
            self?.textFieldEditingChangedClosure?()
        }
        
        clickableButtonView.addAction { [weak self] in
            self?.clickableButtonClosure?()
        }
        
        deleteButtonView.addAction { [weak self] in
            self?.tfMessage.text = ""
            self?.lbTextCount.text = "(0/\(self?.textMaxCount ?? -1))"
            self?.deleteButtonView.hidden(isAnimate: true)
            self?.tfMessage.becomeFirstResponder()
            self?.deleteButtonClosure?()
        }
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        // 모서리 둥글게 표시
        messageView.layer.cornerRadius = 6
        
        if _textMaxCount == 0 {
            textCountView.hidden()
        }
        deleteButtonView.hidden()
    }
}

extension CommonTextFieldView: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        messageView.layer.borderColor = UIColor.colorPink?.cgColor
        textFieldDidBeginEditingClosure?(self)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        messageView.layer.borderColor = UIColor.gray.cgColor
        textFieldDidEndEditingClosure?()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textFieldShouldReturnClosure?()
        return true
    }
}

