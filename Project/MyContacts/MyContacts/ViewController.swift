//
//  ViewController.swift
//  MyContacts
//
//  Created by 구태호 on 2022/11/29.
//

import UIKit
// 주소록을 읽기 위한 프레임워크
import Contacts
// 주소록을 표시 하기 위한 프레임워크
import ContactsUI

class ViewController: UIViewController {
    @IBOutlet var lbName: UILabel!
    @IBOutlet var lbPhoneNumber: UILabel!
    
    // MARK: [전화번호 주소록에 저장된 데이터 확인 메소드]
    let store = CNContactStore() // 전화번호 주소록 접근 객체
    // 저장할 주소록 배열
    var contacts: [Contact] = []
    // 주소 선택 뷰 컨트롤러 생성
    private let contactPicker = CNContactPickerViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func onClickPhoneNumber(_ sender: Any) {
        // getContacts()
        openContacts()
        print(contacts)
    }
    
    /// 주소록의 모든 정보를 리스트로 가져오는 메소드
    func getContacts() {
        let store = CNContactStore()
        
        // 연락처에 요청할 항목
        let keys = [CNContactGivenNameKey, CNContactFamilyNameKey, CNContactPhoneNumbersKey] as [CNKeyDescriptor]
        // Request 생성
        let request = CNContactFetchRequest(keysToFetch: keys)
        request.sortOrder = CNContactSortOrder.userDefault
        
        // 권한체크
        store.requestAccess(for: .contacts) { granted, error in
            guard granted else { return }
            do {
                // 연락처 데이터 획득
                try store.enumerateContacts(with: request) { (contact, stop) in
                    guard let phoneNumber = contact.phoneNumbers.first?.value.stringValue else { return }
                    let id = contact.identifier
                    let givenName = contact.givenName
                    let familyName = contact.familyName
                    
                    let contactToAdd = Contact(id: id, firstName: familyName, givenName: givenName, phoneNumber: phoneNumber)
                    self.contacts.append(contactToAdd)
                }
            } catch let error {
                print(error.localizedDescription)
            }
        }
    }
    
    /// 주소록 뷰컨트롤러를 띄우는 메소드
    func openContacts() {
        contactPicker.delegate = self
        contactPicker.modalPresentationStyle = .fullScreen
        self.present(contactPicker, animated: true, completion: nil)
    }
}

extension ViewController: CNContactPickerDelegate {
    // 연락처 눌리면 호출
    func contactPicker(_ picker: CNContactPickerViewController, didSelect contact: CNContact) {
        guard let phoneNumber = contact.phoneNumbers.first?.value.stringValue else { return print("전화번호 획득 실패...")}
        var selectedContact = Contact()
        selectedContact.id = contact.identifier
        selectedContact.firstName = contact.familyName
        selectedContact.givenName = contact.givenName
        selectedContact.phoneNumber = phoneNumber
        
        // 이름 및 전화번호 레이아웃 업데이트
        setTextData(contact: selectedContact)
    }

    func setTextData(contact: Contact){
        lbName.text = "이름 : \(contact.givenName ?? "error")"
        lbPhoneNumber.text = "전화번호 : \(contact.phoneNumber ?? "erro")"
    }

    func contactPickerDidCancel(_ picker: CNContactPickerViewController) {
        print("Contact Picker 취소됨")
    }
}
