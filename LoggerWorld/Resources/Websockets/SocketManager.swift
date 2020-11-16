//
//  SocketManager.swift
//  LoggerWorld
//
//  Created by Anatolii Bogdanov on 02.11.2020.
//

import Foundation
import Starscream

protocol SocketManagerDelegate {
    func dataReceived(data: String)
}

class SocketManager: WebSocketDelegate {
    static let shared = SocketManager()
    var socket: WebSocket!
    var isConnected = false
    let server = WebSocketServer()
    
    var delegate: SocketManagerDelegate?
    
    private init() {
        var request = URLRequest(url: URL(string: Constants.socketBaseUrl)!)
        let pinner = FoundationSecurity(allowSelfSigned: true)

        request.timeoutInterval = 5
        socket = WebSocket(request: request, certPinner: pinner)
        socket.delegate = self
        socket.connect()
    }
    
    func didReceive(event: WebSocketEvent, client: WebSocket) {
        print("Received info")
        print(event)
        switch event {
        case .connected(let headers):
            isConnected = true
            print("websocket is connected: \(headers)")
        case .disconnected(let reason, let code):
            isConnected = false
            print("websocket is disconnected: \(reason) with code: \(code)")
        case .text(let string):
            print("Received text: \(string)")
            dataReceived(data: string)
        case .binary(let data):
            print("Received data: \(data.count)")
//            dataReceived(data: data)
        case .ping(_):
            break
        case .pong(_):
            break
        case .viabilityChanged(_):
            break
        case .reconnectSuggested(_):
            break
        case .cancelled:
            isConnected = false
        case .error(let error):
            isConnected = false
            handleError(error)
        }
    }
    
    func handleError(_ error: Error?) {
        if let e = error as? WSError {
            print("websocket encountered an error: \(e.message)")
        } else if let e = error {
            print("websocket encountered an error: \(e.localizedDescription)")
        } else {
            print("websocket encountered an error")
        }
    }
    
    func dataReceived(data: String) {
        delegate?.dataReceived(data: data)
    }

}
