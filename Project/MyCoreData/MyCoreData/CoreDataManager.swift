//
//  CoreDataManager.swift
//  MyCoreData
//
//  Created by 구태호 on 2023/01/20.
//

import CoreData
import Foundation

class CoreDataManager {
    static var shared: CoreDataManager = CoreDataManager()
    
    /// name 에 해당하는 저장소(컨테이너) 생성
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "MyCoreData")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    /// Core Data 내부 저장소에 접근할 수 있는 context
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    /// context 현재 상태 저장 시 사용
    func saveToContext() {
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    /// 만들어둔 엔티티(개체) 에 접근할 때 사용
    var contactEntity: NSEntityDescription? {
        return  NSEntityDescription.entity(forEntityName: "Contact", in: context)
    }
    
    /// CoreData 내부에 저장된 리스트 반환
    func fetchContacts() -> [Contact] {
        do {
            let request = Contact.fetchRequest()
            let results = try context.fetch(request)
            return results
        } catch {
            print(error.localizedDescription)
        }
        return []
    }
    
    // Person 목록 반환
    func getContacts() -> [Person] {
        var persons: [Person] = []
        let fetchResults = fetchContacts()
        for result in fetchResults {
            let person = Person(name: result.name ?? "", phoneNumber: result.phoneNumber ?? "", etc: result.etc ?? "")
            persons.append(person)
        }
        return persons
    }
    
    // Person 데이터 쓰기(저장하기)
    func insertContact(_ person: Person) {
        if let entity = contactEntity {
            let managedObject = NSManagedObject(entity: entity, insertInto: context)
            managedObject.setValue(person.name, forKey: "name")
            managedObject.setValue(person.phoneNumber, forKey: "phoneNumber")
            managedObject.setValue(person.etc, forKey: "etc")
            saveToContext()
        }
    }
    
    // Person 데이터 수정하기
    func updateContact(_ person: Person) {
        let fetchResults = fetchContacts()
        for result in fetchResults {
            if result.name != person.name {
                result.name = person.name
            }
            
            if result.phoneNumber != person.phoneNumber {
                result.phoneNumber = person.phoneNumber
            }
            
            if result.etc != person.etc {
                result.etc = person.etc
            }
        }
        saveToContext()
    }
    
    func deleteContacts(_ person: Person) {
        let fetchResults = fetchContacts()
        let person = fetchResults.filter({ $0.name == person.name })[0]
        context.delete(person)
        saveToContext()
    }
    
    // 연락처에 저장된 모든 데이터 삭제
    func deleteAllContacks() {
        let fetchResults = fetchContacts()
        for result in fetchResults {
            context.delete(result)
        }
        saveToContext()
    }
}
