//
//  CommonLabel.swift
//  MyBible
//
//  Created by 구태호 on 2023/03/14.
//

import UIKit

@IBDesignable
class CommonLabelView: UIView {
    
    @IBOutlet var lbMessage: UILabel!
    
    private var _isUnderline: Bool?
    private var _url: String?
    
    /// 라벨 클릭 시 호출될 클로저
    /// - note: 클로저 파라미터로 라벨 텍스트 반환
    public var labelClickClosure: ((String?) -> ())?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.loadXib()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.loadXib()
    }
    
    @IBInspectable
    var text: String? {
        get {
            return lbMessage.text
        }
        
        set {
            lbMessage.text = newValue
        }
    }
    
    /// 밑줄 긋기
    @IBInspectable
    var underline: Bool {
        get {
            return _isUnderline ?? false
        }
        
        set {
            if newValue {
                _isUnderline = newValue
                lbMessage.underline()
            } else {
                _isUnderline = newValue
                lbMessage.normal()
            }
        }
    }
    
    /// 라벨에 연결된 링크 추가
    @IBInspectable
    var url: String? {
        get {
            return _url
        }
        
        set {
            if let newValue = newValue {
                _url = newValue
                lbMessage.textColor = .systemBlue
            } else {
                _url = newValue
                lbMessage.textColor = UIColor(r: 51, g: 51, b: 51, a: 1)
            }
        }
    }
    
    private func loadXib() {
        let bundle = Bundle(for: CommonLabelView.self)
        let identifier = String(describing: CommonLabelView.self)
        let view = bundle.loadNibNamed(identifier, owner: self, options: nil)?.first as! UIView
        
        view.frame = bounds
        addSubview(view)
        
        initAction()
    }
    
    private func initAction() {
        lbMessage.addAction {
            self.labelClickClosure?(self.lbMessage.text)
        }
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        
    }
}
