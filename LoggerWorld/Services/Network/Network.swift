//
//  Network.swift
//  LoggerWorld
//
//  Created by Anatolii Bogdanov on 18.11.2020.
//

import Foundation
import Alamofire

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
                             failure: @escaping () -> ()) {
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
        //                    "Authorization": "Bearer eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJBYWh6QnJ1dCIsImlhdCI6MTYwNzc4NTc3OCwiZXhwIjoxNjEwMzc3Nzc4fQ.hxU0Urm3mdn0e9p_qdY0cwtKf9UMNuwqD1A5Rz44DEkTTT3Bm9UUIrrPNCCDBC8tTEw4GxXrRPKhFKEdv82pxA",
        //                    "Postman-Token": "<calculated when request is sent>",
        AF.request((API.baseURL + "api/user/login").url!,
                   method: .post, parameters: parameters,
                   encoding: JSONEncoding.default,
                   headers: headers).responseJSON { response in
                    print(2)
                    guard let status = response.response?.statusCode else { return }
                    print(status)
                    if Array(200...201).contains(status)  {
                        print(3)
                        if let headers = response.response?.allHeaderFields as? [String: String] {
                            let header = headers["Authorization"]
                            guard let authHeader = header else { return }
                            if authHeader.contains("Bearer "){
                                let regex = try! NSRegularExpression(pattern: #"^(.*?)\s*Bearer\s*(.*)$"#, options: .caseInsensitive)
                                if let match = regex.firstMatch(in: authHeader, range: NSRange(authHeader.startIndex..., in: authHeader)) {
                                    let token = authHeader[Range(match.range(at: 2), in: authHeader)!]
                                    User.token = String(token)
                                    completion()
                                } else {
                                    failure()
                                }
                            }
                            
                        } else {
                            failure()
                        }
                    }
                   }
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
                            completion(successStatus.message ?? "")
                        }
                    } else {
                        if let successStatus = try? JSONDecoder().decode(ResponseStatus<String>.self, from: data) {
                            failure(successStatus.message ?? "")
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
                            print(String(data: data, encoding: .utf8) ?? "")
                            let json = try JSONDecoder().decode(ResponseStatus<CharactersMap>.self, from: data)
                            if let players = json.data?.players {
                                completion(players)
                            } else {
                                let players: [CharacterInformation] = []
                                completion(players)
                            }
                        } catch {
                            print("Error")
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
                        completion()
                    case .failure(_):
                        failure()
                    }
                   })
   }
    
    
    /**
     Получение карты мира
     - parameter completion: возвращает при успешном выполнении
     - parameter failure: возвращает сообщение об ошибке
     */
    static func getLocationDict(completion: @escaping([LocationNameAndCoords]) -> Void,
                                failure: @escaping() -> Void) {
        guard let token = User.token else { return }
        let headers: HTTPHeaders = ["Authorization": "Bearer \(token)"]
        
        AF.request((API.baseURL + "api/locations").url!,
                   method: .get,
                   encoding: JSONEncoding.default,
                   headers: headers).responseJSON(completionHandler: { response in
                    switch response.result {
                    case .success:
                        print("World map data received")
                        if let data = response.data {
                            do {
                                let json = try JSONDecoder().decode(ResponseStatus<WorldMap>.self, from: data)
                                print("World map decoded")
                                if let locations = json.data?.locations {
                                    print("World map is full and ready to use")
                                    completion(locations)
                                } else {
                                    print("World map is empty and ready to use")
                                    let locations: [LocationNameAndCoords] = []
                                    completion(locations)
                                }
                            } catch {
                                print("Error")
                            }
                        }
                    case .failure(_):
                        failure()
                    }
                   })
    }
    
    /**
     Получение статов возможных у персонажа
     - parameter completion: возвращает при успешном выполнении
     - parameter failure: возвращает сообщение об ошибке
     */
    static func getStatsDescription(completion: @escaping([StatMap]) -> Void,
                                failure: @escaping(String) -> Void) {
        guard let token = User.token else { return }
        let headers: HTTPHeaders = ["Authorization": "Bearer \(token)"]

        AF.request((API.baseURL + "api/players/stats").url!,
                   method: .get,
                   encoding: JSONEncoding.default,
                   headers: headers).responseJSON(completionHandler: { response in
//                    switch response.result {
//                    case .success:
//                        if let data = response.data {
////                            print(String(data: data, encoding: .utf8) ?? "")
//                        }
//                    case .failure(_):
//                        failure()
//                    }
//                   })
                    
                    switch response.result {
                    case .success:
                        if let data = response.data {
                            do {
//                                dump(String(data: data, encoding: .utf8)!)
                                let json = try JSONDecoder().decode(ResponseStatus<CharStatsMap>.self, from: data)
                                if let stats = json.data?.stats {
                                    completion(stats)
                                } else {
                                    failure("Failed to map data for Available Stats")
                                }
                            } catch {
                                print("Error")
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
//                            print(String(data: data, encoding: .utf8))
                        do {
                            let json = try JSONDecoder().decode(ResponseStatus<Logs>.self, from: data)
                            if let entries = json.data?.entries {
                                completion(entries)
                            } else {
                                let entries: [LogMessage] = []
                                completion(entries)
                            }
                        } catch {
                            print("Error")
                        }
                    }
                case .failure(_):
                    failure()
                }
               })
    }
}

