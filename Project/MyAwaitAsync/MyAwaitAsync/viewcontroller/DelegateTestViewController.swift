//
//  DelegateTestViewController.swift
//  MyAwaitAsync
//
//  Created by 구태호 on 7/3/24.
//

import UIKit

class DelegateTestViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let house = House()
    }
}



// 1. 위임될 이벤트를 전달할 델리게이트 선언
protocol RoomCleanDelegate: AnyObject {
    func cleaningStart(worker: Worker, roomType: House.RoomType)
    func cleaningComplete(worker: Worker, roomType: House.RoomType)
}

class House: RoomCleanDelegate {
    enum RoomType: String {
        case livingroom = "거실"
        case mainroom = "안방"
        case kitchen = "주방"
        case bathroom = "화장실"
    }
    
    var olderBrother: OlderBrother
    var youngerBrother: YoungerBrother
    
    init() {
        // 2. 작업자 생성
        olderBrother = OlderBrother(cleanRooms: [.livingroom, .mainroom])
        youngerBrother = YoungerBrother(cleanRooms: [.kitchen, .bathroom])
    }

    // 4. worker 로 부터 이벤트 수신
    func cleaningStart(worker: Worker, roomType: RoomType) {
        print("\(worker.name) \(roomType.rawValue) 청소 시작")
    }
    
    // 4. worker 로 부터 이벤트 수신
    func cleaningComplete(worker: Worker, roomType: RoomType) {
        print("\(worker.name) \(roomType.rawValue) 청소 끝")
    }
}

protocol Worker {
    var name: String { get set }
    var cleanRooms: [House.RoomType] { get set }
}

class OlderBrother: Worker {
    var name: String
    var cleanRooms: [House.RoomType]
    
    weak var delegate: RoomCleanDelegate?

    init(cleanRooms: [House.RoomType]) {
        self.name = "형"
        self.cleanRooms = cleanRooms
//        self.delegate = delegate
        cleaning()
    }

    // 3. 위임자에게 이벤트 송신
    func cleaning() {
        // 작업 시작
        let cleaningRoom = cleanRooms.removeFirst()
        delegate?.cleaningStart(worker: self, roomType: cleaningRoom)
        let cleaningTime = DispatchTimeInterval.seconds(Int.random(in: 3...5))
        DispatchQueue.main.asyncAfter(deadline: .now() + cleaningTime) {
            self.delegate?.cleaningComplete(worker: self, roomType: .livingroom)
        }
    }
}

class YoungerBrother: Worker {
    var name: String
    var cleanRooms: [House.RoomType]
    
    private weak var delegate: RoomCleanDelegate?

    init(cleanRooms: [House.RoomType]) {
        self.name = "동생"
        self.cleanRooms = cleanRooms
//        self.delegate = delegate
        cleaning()
    }

    // 3. 위임자에게 이벤트 송신
    func cleaning() {
        let cleaningRoom = cleanRooms.removeFirst()
        let cleaningTime = DispatchTimeInterval.seconds(Int.random(in: 3...5))
        delegate?.cleaningStart(worker: self, roomType: cleaningRoom)
        DispatchQueue.main.asyncAfter(deadline: .now() + cleaningTime) {
            self.delegate?.cleaningComplete(worker: self, roomType: .livingroom)
        }
    }
}
