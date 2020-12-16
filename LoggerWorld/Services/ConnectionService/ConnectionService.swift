//
//  ConnectionService.swift
//  LoggerWorld
//
//  Created by Anatolii Bogdanov on 15.12.2020.
//

import Foundation

class ConnectionService: SocketManagerDelegate {
    static let shared = ConnectionService()
    var socketConnected: Bool = false
    
    private init() {
        SocketManager.shared.connectionDelegate = self
    }
    
    func socketConnect() {
        print(1)
        SocketManager.shared.registerSocket()
    }
    
    func connected() {
        print("SelectChar socket is connected")
        ConnectionService.shared.socketConnected = true
    }
    
    func disconnected() {
        ConnectionService.shared.socketConnected = false
        User.token = nil
        UI.setRootController(R.storyboard.selectCharToPlay.instantiateInitialViewController())
    }
}
