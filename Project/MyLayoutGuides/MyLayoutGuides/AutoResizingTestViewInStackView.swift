//
//  AutoResizingTestViewInStackView.swift
//  MyLayoutGuides
//
//  Created by 구태호 on 2023/08/14.
//

import UIKit


struct SubViewModel {
    var minusClosure: ((SubViewModel?) -> ())?
    var plusClosure: ((SubViewModel?) -> ())?
    var deleteClosure: ((SubViewModel?) -> ())?
    var content: String?
    var count: Int?
}


class AutoResizingTestViewInStackView: UIView {
    @IBOutlet var btDelete: UIButton!
    @IBOutlet var lbContent: UILabel!
    @IBOutlet var btMinus: UIButton!
    @IBOutlet var lbCount: UILabel!
    @IBOutlet var btPlus: UIButton!
    
    public var item: SubViewModel? {
        didSet {
            configuration()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        unarchiveXib()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        unarchiveXib()
    }
    
    func unarchiveXib() {
        if let view = Bundle.main.loadNibNamed("AutoResizingTestViewInStackView", owner: self, options: nil)?.first as? UIView {
            view.frame = self.bounds
            addSubview(view)
            
            view.layer.cornerRadius = 12
            
            configuration()
        }
    }
    
    private func configuration() {
        /// 최소 카운트 지정
        if let count = item?.count, count > 0 {
            lbCount.text = "\(count)"
            btMinus.isEnabled = true
        } else {
            lbCount.text = "0"
            btMinus.isEnabled = false
        }
        
        /// 최대 카운트 지정
        if let count = item?.count, count < 15 {
            lbCount.text = "\(count)"
            btPlus.isEnabled = true
        } else {
            btPlus.isEnabled = false
        }
        
        
        lbContent.text = item?.content
        
        btMinus.addTarget(self, action: #selector(minusClick), for: .touchDown)
        btPlus.addTarget(self, action: #selector(plusClick), for: .touchDown)
        btDelete.addTarget(self, action: #selector(deleteClick), for: .touchDown)
    }
    
    @objc func deleteClick(_ sender: UIButton) {
        item?.deleteClosure?(item)
        self.removeFromSuperview()
    }
    
    @objc func plusClick(_ sender: UIButton) {
        if var count = item?.count, count < 15 {
            count += 1
            item?.count = count
            item?.plusClosure?(item)
        }
    }
    
    @objc func minusClick(_ sender: UIButton) {
        if var count = item?.count, count > 0 {
            count -= 1
            item?.count = count
            item?.minusClosure?(item)
        }
    }
    
    deinit {
        print("removed AutoResizingTestViewInStackView")
    }
}
