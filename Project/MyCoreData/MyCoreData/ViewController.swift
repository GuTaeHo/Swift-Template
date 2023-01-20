//
//  ViewController.swift
//  MyCoreData
//
//  Created by 구태호 on 2023/01/19.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var contactsTableView: UITableView!
    
    @IBOutlet var tfName: UITextField!
    @IBOutlet var tfPhoneNumber: UITextField!
    @IBOutlet var tfEtc: UITextField!
    
    var items = CoreDataManager.shared.getContacts()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tfName.delegate = self
        tfPhoneNumber.delegate = self
        tfEtc.delegate = self
        contactsTableView.delegate = self
        contactsTableView.dataSource = self
        contactsTableView.register(UINib(nibName: "ContactsTableViewCell", bundle: nil), forCellReuseIdentifier: "ContactsTableViewCell")
        contactsTableView.reloadData()
    }
    
    @IBAction func onClickLoad(_ sender: Any) {
        items = CoreDataManager.shared.getContacts()
        contactsTableView.reloadData()
    }
    
    @IBAction func onClickDelete(_ sender: Any) {
        CoreDataManager.shared.deleteAllContacks()
        items = CoreDataManager.shared.getContacts()
        contactsTableView.reloadData()
    }
    
    @IBAction func onClickEnter(_ sender: Any) {
        guard let name = tfName.text?.trimmingCharacters(in: .whitespacesAndNewlines), name.count != 0,
              let phoneNumber = tfPhoneNumber.text?.trimmingCharacters(in: .whitespacesAndNewlines), phoneNumber.count != 0,
              let etc = tfEtc.text?.trimmingCharacters(in: .whitespacesAndNewlines), etc.count != 0
        else {
            return print("전부 입력해주세요")
        }
        
        let person = Person(name: name, phoneNumber: phoneNumber, etc: etc)
        CoreDataManager.shared.insertContact(person)
        // 갱신된 아이템 재조회
        items = CoreDataManager.shared.getContacts()
        contactsTableView.reloadData()
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ContactsTableViewCell", for: indexPath) as? ContactsTableViewCell else {
            return UITableViewCell()
        }
        
        let index = indexPath.row
        
        if index % 2 == 0 {
            cell.contentView.backgroundColor = #colorLiteral(red: 0.8980392157, green: 0.8980392157, blue: 0.9176470588, alpha: 1)
        } else {
            cell.contentView.backgroundColor = #colorLiteral(red: 0.7803921569, green: 0.7803921569, blue: 0.8, alpha: 1)
        }
        
        cell.lbName.text = items[index].name
        cell.lbPhoneNumber.text = items[index].phoneNumber
        cell.lbEtc.text = items[index].etc
        
        return cell
    }
}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        switch textField {
        case tfName:
            tfPhoneNumber.becomeFirstResponder()
            break
        case tfPhoneNumber:
            tfEtc.becomeFirstResponder()
            break
        case tfEtc:
            resignFirstResponder()
            break
        default:
            break
        }
        
        return true
    }
}



