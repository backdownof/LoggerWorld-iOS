//
//  SocketManager.swift
//  LoggerWorld
//
//  Created by Anatolii Bogdanov on 02.11.2020.
//

import Foundation
import StompClientLib
import OSLog

protocol SocketManagerDelegate {
    func disconnected()
    func success()
    func listOfCharactersToSelect(chars: [CharacterInformation])
    func charLoggedIn()
    func updatedLocationInfo(info: LocationInfo)
    func playerMovedToAnotherLocation()
}

protocol InventoryDelegate {
    func inventoryReceived(items: InventoryMap)
}

protocol SessionStartedDelegate {
    func connected()
}

protocol LogsDelegate {
    func messageReceived(log: LogMessage)
}

protocol EquipmentDelegate {
    func equipmentReceived(items: EquipmentMap)
}

extension SocketManagerDelegate {
    func disconnected() {}
    func success() {}
    func listOfCharactersToSelect(chars: [CharacterInformation]) {}
    func charLoggedIn() {}
    func updatedLocationInfo(info: LocationInfo) {}
    func playerMovedToAnotherLocation() {}
}

class SocketManager: StompClientLibDelegate {
    
    static let shared = SocketManager()
    let stomp = StompClientLib()
    let topicMessages = "/topic/messages"
    let playerMessages = "/user/players/messages"
    let classesMessages = "/user/players/classes/messages"
    let locationMessages = "/user/queue/location"
    let wrongCommandMessages = "/user/queue/wrong-command"
    let logMessages = "/user/queue/log"
    let inventoryChange = "/user/queue/inventory"
    let equipmentChange = "/user/queue/equipment"
    
    
//    var delegate: SocketManagerDelegate?
    var locationDelegate: SocketManagerDelegate?
    var messageDelegate: LogsDelegate?
    var connectionDelegate: SessionStartedDelegate?
    var disconnectionDelegate: SocketManagerDelegate?
    var loggingDelegate: SocketManagerDelegate?
    var movedDelegate: SocketManagerDelegate?
    var inventoryDelegate: InventoryDelegate?
    var equipmentDelegate: EquipmentDelegate?
    
    func stompClient(client: StompClientLib!, didReceiveMessageWithJSONBody jsonBody: AnyObject?, akaStringBody stringBody: String?, withHeader header: [String : String]?, withDestination destination: String) {
//        print("SOME DATA???")
//        print("DESTIONATION : \(destination)")
//        print("JSON BODY : \(String(describing: jsonBody))")
//        print("STRING BODY : \(stringBody ?? "nil")")
        
        guard let stringData = stringBody else { print("fuck"); return }
        
        if let data = try? JSONDecoder().decode(LocationInfo.self, from: Data(stringData.utf8)) {
            Logger.stompRecieved.info("Received location info: \(String(describing: data))")
            locationDelegate?.updatedLocationInfo(info: data)
        } else if let data = try? JSONDecoder().decode(LogMessage.self, from: Data(stringData.utf8)) {
            if data.logType == "LOGIN" {
                loggingDelegate?.charLoggedIn()
            }
            Logger.stompRecieved.info("Received log message: \(String(describing: data))")
            messageDelegate?.messageReceived(log: data)
        } else if let data = try? JSONDecoder().decode(InventoryMap.self, from: Data(stringData.utf8)) {
            Logger.stompRecieved.info("Inventory recieved")
            inventoryDelegate?.inventoryReceived(items: data)
        } else if let data = try? JSONDecoder().decode(EquipmentMap.self, from: Data(stringData.utf8)) {
            Logger.stompRecieved.info("Equipment recieved")
            equipmentDelegate?.equipmentReceived(items: data)
        } else {
            print("fucked parsing json")
        }
    }
    
    func stompClientDidDisconnect(client: StompClientLib!) {
        disconnectionDelegate?.disconnected()
    }
    
    func stompClientDidConnect(client: StompClientLib!) {
        subscribeForTopics()
        print("Socket is Connected")
        connectionDelegate?.connected()
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
    
    func subscribeForTopics() {
        stomp.subscribe(destination: topicMessages)
        Logger.stompSent.info("Subscribed for :\(self.topicMessages)")
        stomp.subscribe(destination: playerMessages)
        Logger.stompSent.info("Subscribed for :\(self.playerMessages)")
        stomp.subscribe(destination: classesMessages)
        Logger.stompSent.info("Subscribed for :\(self.classesMessages)")
        stomp.subscribe(destination: "/user/queue")
        Logger.stompSent.info("Subscribed for :/user/queue")
        stomp.subscribe(destination: locationMessages)
        Logger.stompSent.info("Subscribed for :/user/queue/location")
        stomp.subscribe(destination: wrongCommandMessages)
        Logger.stompSent.info("Subscribed for :/user/queue/wrong-command")
        stomp.subscribe(destination: logMessages)
        Logger.stompSent.info("Subscribed for :/user/queue/log")
        stomp.subscribe(destination: inventoryChange)
        Logger.stompSent.info("Subscribed for :\(self.inventoryChange)")
        stomp.subscribe(destination: equipmentChange)
        Logger.stompSent.info("Subscribed for :\(self.equipmentChange)")
    }
    
    func registerSocket() {
        let completedWSURL = API.baseWS
        
        let url = NSURL(string: completedWSURL)!
        guard let token = User.token else {
            return
        }
        stomp.openSocketWithURLRequest(request: NSURLRequest(url: url as URL), delegate: self as StompClientLibDelegate, connectionHeaders: ["Authorization": "Bearer \(String(describing: token))"])
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
    }
    
    func playerMoveToAnotherLocation(locationId: Int) {
        let dict = ["locationId": locationId] as NSDictionary
        stomp.sendJSONForDict(dict: dict, toDestination: "/app/players/move")
        Logger.stompSent.info("Send Move to location: \(locationId)")
        movedDelegate?.playerMovedToAnotherLocation()
    }
    
    func kickNest(nestId: Int) {
        let dict = ["nestId": nestId] as NSDictionary
        stomp.sendJSONForDict(dict: dict, toDestination: "/app/players/kick-nest")
        Logger.stompSent.info("Send nest with id: \(nestId) is kicked")
    }
    
    func loadInventory() {
        let dict = ["": nil] as NSDictionary
        stomp.sendJSONForDict(dict: dict, toDestination: "/app/players/request/inventory")
        Logger.stompSent.info("Sent request to load inventory")
    }
    
    func loadEquiped() {
        let dict = ["": nil] as NSDictionary
        stomp.sendJSONForDict(dict: dict, toDestination: "/app/players/request/equipment")
        Logger.stompSent.info("Sent request to load equiped")
    }
    
    func equipItem(itemId: Int, slotId: Int) {
        let dict = ["itemId": itemId, "slotType": slotId] as NSDictionary
        stomp.sendJSONForDict(dict: dict, toDestination: "/app/players/equip-item")
        Logger.stompSent.info("Sent request to equip item \(itemId) at slot \(slotId)")
    }
}
