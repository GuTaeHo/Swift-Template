//
//  Contact.swift
//  MyContacts
//
//  Created by 구태호 on 2022/11/29.
//

import Foundation

struct Contact: Codable {
    var id: String?
    var firstName: String?
    var givenName: String?
    var phoneNumber: String?
    
    init(id: String? = nil, firstName: String? = nil, givenName: String? = nil, phoneNumber: String? = nil) {
        self.id = id
        self.firstName = firstName
        self.givenName = givenName
        self.phoneNumber = phoneNumber
    }
}
