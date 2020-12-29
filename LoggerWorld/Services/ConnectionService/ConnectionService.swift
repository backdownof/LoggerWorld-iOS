//
//  ConnectionService.swift
//  LoggerWorld
//
//  Created by Anatolii Bogdanov on 15.12.2020.
//

import Foundation

class ConnectionService: SocketManagerDelegate, SessionStartedDelegate {
    static let shared = ConnectionService()
    var socketConnected: Bool = false
    
    private init() {
        SocketManager.shared.connectionDelegate = self
        SocketManager.shared.disconnectionDelegate = self
    }
    
    func socketConnect() {
        SocketManager.shared.registerSocket()
    }
    
    func connected() {
        print("SelectChar socket is connected")
        socketConnected = true
    }
    
    func disconnected() {
        socketConnected = false
        User.token = nil
        UI.setRootController(R.storyboard.login.instantiateInitialViewController())
    }
}
