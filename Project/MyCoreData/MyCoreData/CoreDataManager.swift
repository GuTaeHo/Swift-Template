//
//  CoreDataManager.swift
//  MyCoreData
//
//  Created by 구태호 on 2023/01/20.
//

import CoreData
import Foundation

/**
 코어 데이터(Core Data)의 핵심은 Core Data Stack 이며, Core Data Stack 으로 모델을 관리 및 유지함
 Core Data Stack 은 NSManagedObjectModel, NSManagedObjectContext, NSPersistentStoreCoordinator, NSPersistentContainer 로 이루어져 있음
 1. NSManagedObjectModel >> Entity[테이블]를 설명하는 데이터베이스 스키마(모델의 구조 및 테이블 간 관계를 정의하는 느낌?) 임
 2. NSPersistentStoreCoordinator >> persistent storage (영구 저장소) 와 managed object model 을 연결해주는 중계자 역할을 함
 3. NSManagedObjectContext >> 트랜잭션. 특정 오브젝트를 생성 및 저장, 가져오는 작업을 제공
 4. NSPersistentContainer >> 위 1, 2, 3 을 모두 포함한 컨테이너
 
 영구적인 저장소로 Core Data를 사용하려면...
 1. NSPersistentContainer(name:) 를 통해 컨테이너 획득
 2. 컨테이너에서 트랜잭션(NSManagedObjectContext.viewContext) 획득
 3. 트랜잭션에서 Entity(NSEntityDescription.entity()) 획득
 4. NSManagedObject 생성 하고 값을 씀
 5. 값을 저장
 
 - note: 코어데이터 관련 내용 참조
 https://sihyungyou.github.io/iOS-coredata-multithreaded/
 https://zeddios.tistory.com/987
 */
class CoreDataManager {
    static var shared: CoreDataManager = CoreDataManager()
    
    /// 저장소 생성 및 반환
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "MyCoreData")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    /// - note: CoreData 프레임워크는 컨테이너(NSPersistentContainer)의 컨텍스트(NSManagedObjectContext)를 통해 CRUD 연산이 가능함
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
    
    /// 연락처 엔티티(테이블) 반환
    var contactEntity: NSEntityDescription? {
        return NSEntityDescription.entity(forEntityName: "Contact", in: context)
    }
    
    /// 연락처 목록 반환
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
            let person = Person(name: result.name ?? "", phoneNumber: result.phoneNumber ?? "", address: result.address ?? "")
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
            managedObject.setValue(person.address, forKey: "address")
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
            
            if result.address != person.address {
                result.address = person.address
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
