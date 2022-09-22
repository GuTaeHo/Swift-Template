//
//  ViewController.swift
//  MyWebSocket
//
//  Created by 구태호 on 2022/07/08.
//

import UIKit
import SocketIO

class ViewController: UIViewController {
    
    var manager: SocketManager!
    var socket: SocketIOClient!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        socketIOConnetion()
    }

    func socketIOConnetion() {
        manager = SocketManager(socketURL: URL(string: "http://192.168.67.204:3000")!, config: [.log(true), .compress])
        socket = manager.defaultSocket

        socket.on(clientEvent: .connect) {data, ack in
            print("socket connected")
            self.socket.emit("msg", "C.O.C.O.B.E.A.N has Connected")
        }

        socket.on("msg") {data, ack in
            print("@@@ \(data), \(ack)")
        }
    }
}

