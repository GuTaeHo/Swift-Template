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
        let url = "http://192.168.1.2:3000"
        
        manager = SocketManager(socketURL: URL(string: url)!, config: [
            .log(true),
            .compress
        ])
        socket = manager.defaultSocket

        socket.on(clientEvent: .connect) {data, ack in
            print("socket connected")
            self.socket.emit("msg", "Hello, World")
        }

        socket.on("msg") {data, ack in
            print("@@@ \(data), \(ack)")
        }
        
        socket.connect()
    }
}

