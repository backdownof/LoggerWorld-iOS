//
//  SocketManager.swift
//  LoggerWorld
//
//  Created by Anatolii Bogdanov on 02.11.2020.
//

import Foundation
import StompClientLib

protocol SocketManagerDelegate {
    func connected()
    func success()
    func listOfCharactersToSelect(chars: [CharListToLogin])
    func charLoggedIn()
    func updatedLocationInfo(info: LocationInfo)
}

extension SocketManagerDelegate {
    func connected() {}
    func success() {}
    func listOfCharactersToSelect(chars: [CharListToLogin]) {}
    func charLoggedIn() {}
    func updatedLocationInfo(info: LocationInfo) {}
}

class SocketManager: StompClientLibDelegate {
    
    static let shared = SocketManager()
    let stomp = StompClientLib()
    let topicMessages = "/topic/messages"
    let playerMessages = "/user/players/messages"
    let classesMessages = "/user/players/classes/messages"
    
    var delegate: SocketManagerDelegate?
    
    func stompClient(client: StompClientLib!, didReceiveMessageWithJSONBody jsonBody: AnyObject?, akaStringBody stringBody: String?, withHeader header: [String : String]?, withDestination destination: String) {
        print("SOME DATA???")
        print("DESTIONATION : \(destination)")
        print("JSON BODY : \(String(describing: jsonBody))")
        print("STRING BODY : \(stringBody ?? "nil")")
        
        guard let stringData = stringBody else { print("fuck"); return }
        
        if let data = try? JSONDecoder().decode(LocationInfo.self, from: Data(stringData.utf8)) {
            delegate?.updatedLocationInfo(info: data)
        } else {
            print("fucked parsing json")
        }
//            let playersList = try JSONDecoder().decode(Players.self, from:Data(stringData.utf8))
//            if let listOfChars = playersList.players {
//                delegate?.listOfCharactersToSelect(chars: listOfChars)
//            } else {
//                delegate?.listOfCharactersToSelect(chars: [])
//            }
        
        delegate?.success()
    }
    
    func stompClientDidDisconnect(client: StompClientLib!) {
        print("Socket is Disconnected")
    }
    
    func stompClientDidConnect(client: StompClientLib!) {
        subscribeForTopics()
        print("Socket is Connected")
        delegate?.connected()
    }
    
    func serverDidSendReceipt(client: StompClientLib!, withReceiptId receiptId: String) {
        print("Receipt : \(receiptId)")
    }
    
    func serverDidSendError(client: StompClientLib!, withErrorMessage description: String, detailedErrorMessage message: String?) {
        print("Error : \(String(describing: message))")
    }
    
    func serverDidSendPing() {
        print("Server Ping")
    }
    
    private init() {
    }
    
    func connectToWS() {
        registerSocket()
    }
    
    func subscribeForTopics() {
        stomp.subscribe(destination: topicMessages)
        print("Subscribed for :\(topicMessages)")
        stomp.subscribe(destination: playerMessages)
        print("Subscribed for :\(playerMessages)")
        stomp.subscribe(destination: classesMessages)
        print("Subscribed for :\(classesMessages)")
        stomp.subscribe(destination: "/user/queue")
        print("Subscribed for :/user/queue")
    }
    
    func registerSocket() {
        let completedWSURL = "ws://localhost:8080/ws"
        
        let url = NSURL(string: completedWSURL)!
        stomp.openSocketWithURLRequest(request: NSURLRequest(url: url as URL), delegate: self as StompClientLibDelegate, connectionHeaders: ["Authorization": "Bearer \(String(describing: User.token!))"])
    }
    
    func loadPlayerChars() {
        stomp.sendMessage(message: "", toDestination: "/app/players", withHeaders: ["Authorization": "Bearer \(String(describing: User.token!))"], withReceipt: nil)
    }
    
    func createCharacter(nickname: String, className: String) {
        let dict = ["name": nickname, "playerClass": className] as NSDictionary
        stomp.sendJSONForDict(dict: dict, toDestination: "/app/players/add")
    }
    
    func loginCharacter(playerId: Int) {
        let dict = ["playerId": playerId] as NSDictionary
        stomp.sendJSONForDict(dict: dict, toDestination: "/app/players/start")
        delegate?.charLoggedIn()
    }
}
