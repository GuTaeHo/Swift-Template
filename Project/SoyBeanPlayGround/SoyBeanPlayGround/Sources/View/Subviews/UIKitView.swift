//
//  UIKitView.swift
//  SoyBeanPlayGround
//
//  Created by 구태호 on 6/11/25.
//

import SwiftUI
import UIKit
import SoyBeanUI


struct UIKitView: UIViewRepresentable {
    @Binding var text: String
    
    func makeUIView(context: Context) -> some UIView {
        let view = UIView()
        let textField = UITextField()
        textField.placeholder = "UIKit 뷰를 SwiftUI 뷰에 올리는 방법"
        textField.delegate = context.coordinator
        textField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubviews(textField)
        
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: view.topAnchor, constant: 12),
            textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 18),
            textField.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -12),
            textField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -18)
        ])
        
        return view
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    /// UIKit 의 Delegate 를 구현하기 위해 별도의 클래스 구현
    class Coordinator: NSObject, UITextFieldDelegate {
        var parent: UIKitView
        
        init(_ parent: UIKitView) {
            self.parent = parent
        }
        
        /// Delegate 메소드 처리
        func textFieldDidChangeSelection(_ textField: UITextField) {
            parent.text = textField.text ?? ""
        }
    }
}
