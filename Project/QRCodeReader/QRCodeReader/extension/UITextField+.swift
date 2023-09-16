//
//  UITextField.swift
//  QRCodeReader
//
//  Created by 구태호 on 2023/09/10.
//

import UIKit


/*
 extension UITextField {
 // (인자로 받을) 액션 클로저 형태 지정
 public typealias UITextFieldActionClosure = (UITextField) -> ()
 
 private struct AssociatedKeys {
 static var beginEditing = "beginEditing"
 static var changeSelection = "changeSelection"
 static var endEditing = "endEditing"
 static var shouldReturn = "shouldReturn"
 }
 
 // MARK: NSObject 필수 채택!
 class UITextFieldBeginEditingClosureWrapper: NSObject {
 let beginEditing: UITextFieldActionClosure
 
 init(beginEditing: @escaping UITextFieldActionClosure) {
 self.beginEditing = beginEditing
 }
 }
 
 class UITextFieldChangeSelectionClosureWrapper: NSObject {
 let changeSelection: UITextFieldActionClosure
 
 init(changeSelection: @escaping UITextFieldActionClosure) {
 self.changeSelection = changeSelection
 }
 }
 
 class UITextFieldEndEditingClosureWrapper: NSObject {
 let endEditing: UITextFieldActionClosure
 
 init(endEditing: @escaping UITextFieldActionClosure) {
 self.endEditing = endEditing
 }
 }
 
 class UITextFieldShouldReturnClosureWrapper: NSObject {
 let shouldReturn: UITextFieldActionClosure
 
 init(shouldReturn: @escaping UITextFieldActionClosure) {
 self.shouldReturn = shouldReturn
 }
 }
 
 // MARK: editingChanged 이벤트는 UIControl+.swift 참고
 
 var beginEditing: ((UITextField) -> ())? {
 get {
 // 객체 획득 시
 if let closure = objc_getAssociatedObject(self, &AssociatedKeys.beginEditing) as? UITextFieldBeginEditingClosureWrapper {
 return closure.beginEditing
 }
 return nil
 }
 set {
 // 객체 저장 시
 
 /**
  OBJC_ASSOCIATION_ASSIGN                // 추가된 객체와 약한 참조
  OBJC_ASSOCIATION_RETAIN_NONATOMIC    // 추가된 객체와 강력 참조 및 nonatomatic으로 설정
  OBJC_ASSOCIATION_COPY_NONATOMIC        // 추가된 객체를 복사 및 nonatomatic으로 설정
  OBJC_ASSOCIATION_RETAIN             // 추가된 객체와 강력 참조 및 atomatic으로 설정
  OBJC_ASSOCIATION_COPY                 // 추가된 객체를 복사 및 atomatic으로 설정
  */
 guard let newValue = newValue else { return }
 self.delegate = self
 objc_setAssociatedObject(self, &AssociatedKeys.beginEditing, UITextFieldBeginEditingClosureWrapper(beginEditing: newValue), .OBJC_ASSOCIATION_COPY_NONATOMIC)
 }
 }
 
 var changeSelection: ((UITextField) -> ())? {
 get {
 if let closure = objc_getAssociatedObject(self, &AssociatedKeys.changeSelection) as? UITextFieldChangeSelectionClosureWrapper {
 return closure.changeSelection
 }
 return nil
 }
 set {
 guard let newValue = newValue else { return }
 self.delegate = self
 objc_setAssociatedObject(self, &AssociatedKeys.changeSelection, UITextFieldChangeSelectionClosureWrapper(changeSelection: newValue), .OBJC_ASSOCIATION_COPY_NONATOMIC)
 }
 }
 
 var endEditing: ((UITextField) -> ())? {
 get {
 if let closure = objc_getAssociatedObject(self, &AssociatedKeys.endEditing) as? UITextFieldEndEditingClosureWrapper {
 return closure.endEditing
 }
 return nil
 }
 set {
 guard let newValue = newValue else { return }
 self.delegate = self
 objc_setAssociatedObject(self, &AssociatedKeys.endEditing, UITextFieldEndEditingClosureWrapper(endEditing: newValue), .OBJC_ASSOCIATION_COPY_NONATOMIC)
 }
 }
 
 var shouldReturn: ((UITextField) -> ())? {
 get {
 if let closure = objc_getAssociatedObject(self, &AssociatedKeys.shouldReturn) as? UITextFieldShouldReturnClosureWrapper {
 return closure.shouldReturn
 }
 return nil
 }
 set {
 guard let newValue = newValue else { return }
 self.delegate = self
 objc_setAssociatedObject(self, &AssociatedKeys.shouldReturn, UITextFieldShouldReturnClosureWrapper(shouldReturn: newValue), .OBJC_ASSOCIATION_COPY_NONATOMIC)
 }
 }
 }
 
 extension UITextField: UITextFieldDelegate {
 public func textFieldDidBeginEditing(_ textField: UITextField) {
 beginEditing?(textField)
 }
 
 public func textFieldDidChangeSelection(_ textField: UITextField) {
 changeSelection?(textField)
 }
 
 public func textFieldDidEndEditing(_ textField: UITextField) {
 endEditing?(textField)
 }
 
 public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
 shouldReturn?(textField)
 return true
 }
 }
 */
