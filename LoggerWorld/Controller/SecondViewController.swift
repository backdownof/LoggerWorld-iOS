//
//  SecondViewController.swift
//  LoggerWorld
//
//  Created by Anatolii Bogdanov on 04.11.2020.
//

import UIKit
import Starscream

class SecondViewController: UIViewController, WebSocketDelegate {
    
//    let shared = SocketManager()
    var socket: WebSocket!
    var isConnected = false
    let server = WebSocketServer()
    
//    var delegate: SocketManagerDelegate?
//
//    func dataReceived(data: Data) {
//        print(data)
//    }
    
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    let socketManager = SocketManager.shared.socket!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var request = URLRequest(url: URL(string: Constants.socketBaseUrl)!)
        let pinner = FoundationSecurity(allowSelfSigned: true)

        request.timeoutInterval = 5
        socket = WebSocket(request: request, certPinner: pinner)
        socket.delegate = self
        socket.connect()
    }
    
    @IBAction func loginButtonPressed(_ sender: Any) {
        guard let email = emailTextField.text, let password = passwordTextField.text else { return }
        if emailTextField.text != "" &&
            email.contains("@") &&
            email.contains(".") &&
            password != "" &&
            password.count > 5 &&
            password.count < 17
        {
            let credentials = Credentials(email: email, password: password)
            let playerLogin = PlayerLogin(command: "login", args: credentials)
            
            let encoder = JSONEncoder()
            let data = try! encoder.encode(playerLogin)
            
            socketManager.write(data: data)
            
            
        } else {
            print("error: некорректный email или password")
        }
    }
    
    func didReceive(event: WebSocketEvent, client: WebSocket) {
        print("Received info")
        switch event {
        case .connected(let headers):
            isConnected = true
            print("websocket is connected: \(headers)")
        case .disconnected(let reason, let code):
            isConnected = false
            print("websocket is disconnected: \(reason) with code: \(code)")
        case .text(let string):
            print("Received text: \(string)")
//            dataReceived(data: string)
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
}
