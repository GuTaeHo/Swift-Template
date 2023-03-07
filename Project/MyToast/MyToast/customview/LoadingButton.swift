//
//  LoadingButton.swift
//  MyToast
//
//  Created by 구태호 on 2023/03/07.
//

import UIKit

class LoadingButton: UIButton {
    var originalButtonText: String?
    var activityIndicator: UIActivityIndicatorView!
    
    /// 뷰가 완전히 언아카이빙(nib파일 -> 객체 형태 변환) 아웃렛이 완전히 연결된 후 호출됨
    override func awakeFromNib() {
        super.awakeFromNib()
        
        if activityIndicator == nil {
            activityIndicator = createActivityIndicator()
        }
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
    }
    
    /// 로딩 표시
    func showLoading() {
        originalButtonText = self.titleLabel?.text
        self.setTitle("", for: .normal)
        
        showSpinning()
    }
    
    /// 로딩 숨김
    func hideLoading() {
        self.setTitle(originalButtonText, for: .normal)
        activityIndicator.stopAnimating()
        activityIndicator.removeFromSuperview()
    }
    
    private func createActivityIndicator() -> UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = UIColor.white
        return activityIndicator
    }
    
    private func showSpinning() {
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(activityIndicator)
        centerActivityIndicatorInButton()
        activityIndicator.startAnimating()
    }
    
    private func centerActivityIndicatorInButton() {
        let xCenterConstraint = NSLayoutConstraint(item: self, attribute: .centerX, relatedBy: .equal, toItem: activityIndicator, attribute: .centerX, multiplier: 1, constant: 0)
        self.addConstraint(xCenterConstraint)
        
        let yCenterConstraint = NSLayoutConstraint(item: self, attribute: .centerY, relatedBy: .equal, toItem: activityIndicator, attribute: .centerY, multiplier: 1, constant: 0)
        self.addConstraint(yCenterConstraint)
    }
}
