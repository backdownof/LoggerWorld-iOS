//
//  Network.swift
//  LoggerWorld
//
//  Created by Anatolii Bogdanov on 18.11.2020.
//

import Foundation
import Alamofire
import OSLog

class Network: NSObject {
    
    static var isAvailableInternetConnection: Bool {
        return shared.reachabilityManager?.isReachable ?? false
    }
    
    private static let shared = Network()
    private let reachabilityManager = NetworkReachabilityManager()
    
    
    /**
     Авторизация пользователя.
     - parameter completion: возвращает при успешном выполнении
     - parameter failure: возвращает сообщение об ошибке
     */
    static func requestLogin(userName: String,
                             password: String,
                             completion: @escaping () -> Void,
                             failure: @escaping (String) -> ()) {
        let parameters: [String: Any] = [
            "userName" : userName,
            "password": password
        ]
        
        let headers: HTTPHeaders = [
                                "Content-Type": "application/json",
                                "Accept": "*/*",
                                "Accept-Encoding": "gzip,deflate,br",
                                "Connection": "keep-alive"
                               ]
        AF.request((API.baseURL + "api/user/login").url!,
                   method: .post, parameters: parameters,
                   encoding: JSONEncoding.default,
                   headers: headers).validate(statusCode: 200..<300).response(completionHandler: { response in
                    switch response.result {
                    case .success:
                        if let headers = response.response?.allHeaderFields as? [String: String] {
                            let header = headers["Authorization"]
                            guard let authHeader = header else { return }
                            do {
                                let token = try authHeader.groups(for: #"^Bearer\s(.*)$"#)[0][1]
                                User.token = String(token)
                                Logger.apiRequest.info("Token saved")
                                completion()
                            } catch {
                                Logger.apiRequest.error("Error parsing Token")
                                failure("Ошибка обработки токена. Обратитесь в поддержку!")
                            }
                        } else {
                            failure("Ошибка получения токена. Обратитесь в поддержку!")
                        }
                    case .failure:
                        Logger.apiRequest.error("Bad response from server while loging")
                        failure("Неправильный логин или пароль. Повторите")
                    }
                   })
    }
    
    /**
     Регистрация пользователя.
     - parameter completion: возвращает при успешном выполнении
     - parameter failure: возвращает сообщение об ошибке
     */
    static func requestRegister(userName: String,
                                password: String,
                                language: String = "RU",
                                displayName: String? = nil,
                                email: String,
                                completion: @escaping (String) -> Void,
                                failure: @escaping(String) -> Void) {
        AF.request((API.baseURL + "api/user/sign-up").url!,
                   method: .post,
                   parameters: [
                    "userName": userName,
                    "password": password,
                    "language": language,
                    "displayName": userName,
                    "email": email
                   ],
                   encoding: JSONEncoding.default).responseJSON(completionHandler: { response in
                    guard let status = response.response?.statusCode else { failure("Failed connect to the server"); return }
                    guard let data = response.data else { failure("Failed to process data from server"); return }
                    if Array(200...201).contains(status)  {
                        if let successStatus = try? JSONDecoder().decode(ResponseStatus<String>.self, from: data) {
                            Logger.apiRequest.info("Successfully registered user")
                            completion(successStatus.message ?? "")
                        }
                    } else {
                        if let successStatus = try? JSONDecoder().decode(ResponseStatus<String>.self, from: data) {
                            failure(successStatus.message ?? "")
                            Logger.apiRequest.error("Error registering user")
                        }
                    }
                    
                   })
    }
    
    /**
     Запрос списка персонажей
     - parameter completion: возвращает при успешном выполнении
     - parameter failure: возвращает сообщение об ошибке
     */
    static func requestCharacters(completion: @escaping ([CharacterInformation]) -> Void,
                                  failure: @escaping(String) -> Void) {
        guard let token = User.token else { return }
        let headers: HTTPHeaders = ["Authorization": "Bearer \(token)"]
        
        
        AF.request((API.baseURL + "api/players").url!,
                   method: .get,
                   encoding: JSONEncoding.default,
                   headers: headers).responseJSON(completionHandler: { response in
                    if let data = response.data {
                        do {
                            let json = try JSONDecoder().decode(ResponseStatus<CharactersMap>.self, from: data)
                            Logger.apiRequest.info("Requested player's characters are mapped correctly")
                            if let players = json.data?.players {
                                completion(players)
                            } else {
                                let players: [CharacterInformation] = []
                                Logger.apiRequest.info("No characters are created yet")
                                completion(players)
                            }
                        } catch {
                            Logger.apiRequest.error("Error mapping player's characters")
                        }
                    }
                   })
    }
    
    /**
     Создание нового персонажа
     - parameter completion: возвращает при успешном выполнении
     - parameter failure: возвращает сообщение об ошибке
     */
    static func createChar(nickname: String,
                           playerClass: String,
                           completion: @escaping() -> Void,
                           failure: @escaping() -> Void) {
        guard let token = User.token else { return }
        let headers: HTTPHeaders = ["Authorization": "Bearer \(token)"]
        
        
        AF.request((API.baseURL + "api/players").url!,
                   method: .post,
                   parameters: [
                    "name": nickname,
                    "playerClass": playerClass
                   ],
                   encoding: JSONEncoding.default,
                   headers: headers).responseJSON(completionHandler: { response in
                    switch response.result {
                    case .success:
                        Logger.apiRequest.info("New charater is created")
                        completion()
                    case .failure(_):
                        Logger.apiRequest.error("Failed creating charater")
                        failure()
                    }
                   })
   }
    
    
    /**
     Получение карты мира
     - parameter completion: возвращает при успешном выполнении
     - parameter failure: возвращает сообщение об ошибке
     */
    static func getLocationDict(completion: @escaping([LocationMapData]) -> Void,
                                failure: @escaping() -> Void) {
        guard let token = User.token else { return }
        let headers: HTTPHeaders = ["Authorization": "Bearer \(token)"]
        
        AF.request((API.baseURL + "api/locations").url!,
                   method: .get,
                   encoding: JSONEncoding.default,
                   headers: headers).responseJSON(completionHandler: { response in
                    guard let status = response.response?.statusCode else { failure(); return }
                    if Array(200...201).contains(status)  {
                        Logger.apiRequest.info("World map data received")
                        if let data = response.data {
                            do {
                                let json = try JSONDecoder().decode(ResponseStatus<WorldMap>.self, from: data)
                                Logger.apiRequest.info("World map is mapped correctly")
                                if let locations = json.data?.locations {
                                    completion(locations)
                                } else {
                                    Logger.apiRequest.fault("World map is empty")
                                    let locations: [LocationMapData] = []
                                    completion(locations)
                                }
                            } catch {
                                Logger.apiRequest.error("Not able mapping the world map")
                            }
                        }
                    } else {
                        Logger.apiRequest.error("Error getting the world map")
                        failure()
                    }
                   })
    }
    
    /**
     Получение статов возможных у персонажа
     - parameter completion: возвращает при успешном выполнении
     - parameter failure: возвращает сообщение об ошибке
     */
    static func getStatsMap(completion: @escaping([StatMap]) -> Void,
                                failure: @escaping(String) -> Void) {
        guard let token = User.token else { return }
        let headers: HTTPHeaders = ["Authorization": "Bearer \(token)"]

        AF.request((API.baseURL + "api/players/stats").url!,
                   method: .get,
                   encoding: JSONEncoding.default,
                   headers: headers).responseJSON(completionHandler: { response in
                    switch response.result {
                    case .success:
                        if let data = response.data {
                            do {
                                let json = try JSONDecoder().decode(ResponseStatus<CharStatsMap>.self, from: data)
                                Logger.apiRequest.info("Stats map is mapped correctly")
                                if let stats = json.data?.stats {
                                    completion(stats)
                                } else {
                                    failure("Failed to map data for Available Stats")
                                }
                            } catch {
                                Logger.apiRequest.error("Error mapping stats map")
                            }
                        }
                    case .failure(_):
                        failure("Wrong request to the server")
                    }
                   })
    }
    
    /**
     Получение логов игрока
     - parameter completion: возвращает при успешном выполнении
     - parameter failure: возвращает сообщение об ошибке
     */
    static func getUserLogs(completion: @escaping([LogMessage]) -> Void,
                                failure: @escaping() -> Void) {
        guard let token = User.token else { return }
        let headers: HTTPHeaders = ["Authorization": "Bearer \(token)"]
        
        AF.request((API.baseURL + "api/players/logs").url!,
               method: .get,
               encoding: JSONEncoding.default,
               headers: headers).responseJSON(completionHandler: { response in
                switch response.result {
                case .success:
                    if let data = response.data {
                        do {
                            let json = try JSONDecoder().decode(ResponseStatus<Logs>.self, from: data)
                            if let entries = json.data?.entries {
                                Logger.apiRequest.info("Logs are mapped correctly")
                                completion(entries)
                            } else {
                                Logger.apiRequest.info("Logs are empty")
                                let entries: [LogMessage] = []
                                completion(entries)
                            }
                        } catch {
                            Logger.apiRequest.error("Failed to map logs")
                        }
                    }
                case .failure(_):
                    failure()
                }
               })
    }
    
    static func getItemCategoriesMap(completion: @escaping([ItemCategoryData]) -> Void,
                                failure: @escaping() -> Void) {
        guard let token = User.token else { return }
        let headers: HTTPHeaders = ["Authorization": "Bearer \(token)"]
        
        AF.request((API.baseURL + "api/items/categories").url!,
               method: .get,
               encoding: JSONEncoding.default,
               headers: headers).responseJSON(completionHandler: { response in
                switch response.result {
                case .success:
                    if let data = response.data {
                        do {
                            let json = try JSONDecoder().decode(ResponseStatus<ItemCategoriesData>.self, from: data)
                            if let itemCategories = json.data?.itemCategories {
                                Logger.apiRequest.info("Succeed mapping Item categories")
                                completion(itemCategories)
                            } else {
                                Logger.apiRequest.info("Item categories map is empty")
                                let itemCategories: [ItemCategoryData] = []
                                completion(itemCategories)
                            }
                        } catch {
                            Logger.apiRequest.error("Failed to map Item categories")
                        }
                    }
                case .failure(_):
                    failure()
                }
               })
    }
    
    static func getEquipmentSlotsMap(completion: @escaping([EquipmentSlot]) -> Void,
                                failure: @escaping() -> Void) {
        guard let token = User.token else { return }
        let headers: HTTPHeaders = ["Authorization": "Bearer \(token)"]
        
        AF.request((API.baseURL + "api/items/equipment-slots").url!,
               method: .get,
               encoding: JSONEncoding.default,
               headers: headers).responseJSON(completionHandler: { response in
                switch response.result {
                case .success:
                    if let data = response.data {
                        do {
                            let json = try JSONDecoder().decode(ResponseStatus<EquipmentSlotsData>.self, from: data)
                            
                            if let equipmentSlots = json.data?.equipmentSlots {
                                Logger.apiRequest.info("Succeed mapping Equipment slots map")
                                completion(equipmentSlots)
                            } else {
                                Logger.apiRequest.info("Equipment slots map is empty")
                                let equipmentSlots: [EquipmentSlot] = []
                                completion(equipmentSlots)
                            }
                        } catch {
                            Logger.apiRequest.error("Failed to map Equipment slots map")
                        }
                    }
                case .failure(_):
                    failure()
                }
               })
    }
    
    static func getItemQualitiesMap(completion: @escaping([ItemQuality]) -> Void,
                                failure: @escaping() -> Void) {
        guard let token = User.token else { return }
        let headers: HTTPHeaders = ["Authorization": "Bearer \(token)"]
        
        AF.request((API.baseURL + "api/items/qualities").url!,
               method: .get,
               encoding: JSONEncoding.default,
               headers: headers).responseJSON(completionHandler: { response in
                switch response.result {
                case .success:
                    if let data = response.data {
                        do {
                            let json = try JSONDecoder().decode(ResponseStatus<ItemQualitiesData>.self, from: data)
                            if let itemQualities = json.data?.itemQualities {
                                Logger.apiRequest.info("Succeed mapping Item Qualities Map")
                                completion(itemQualities)
                            } else {
                                Logger.apiRequest.info("Item Qualities Map is empty")
                                let itemQualities: [ItemQuality] = []
                                completion(itemQualities)
                            }
                        } catch {
                            Logger.apiRequest.error("Failed to map Item Qualities Map")
                        }
                    }
                case .failure(_):
                    failure()
                }
               })
    }
    
    static func getItemStatsMap(completion: @escaping([ItemStat]) -> Void,
                                failure: @escaping() -> Void) {
        guard let token = User.token else { return }
        let headers: HTTPHeaders = ["Authorization": "Bearer \(token)"]
        
        AF.request((API.baseURL + "api/items/stats").url!,
               method: .get,
               encoding: JSONEncoding.default,
               headers: headers).responseJSON(completionHandler: { response in
                switch response.result {
                case .success:
                    if let data = response.data {
                        do {
                            let json = try JSONDecoder().decode(ResponseStatus<ItemStatsData>.self, from: data)
                            if let itemStats = json.data?.itemStats {
                                Logger.apiRequest.info("Succeed mapping Item Stats Map")
                                completion(itemStats)
                            } else {
                                Logger.apiRequest.info("Item Stats Map is empty")
                                let itemStats: [ItemStat] = []
                                completion(itemStats)
                            }
                        } catch {
                            Logger.apiRequest.error("Failed to map Item Stats Map")
                        }
                    }
                case .failure(_):
                    failure()
                }
               })
    }
}
