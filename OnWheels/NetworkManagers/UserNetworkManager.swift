//
//  UserNetworkManager.swift
//  OnWheels
//
//  Created by Veronika on 24.12.2022.
//

import Foundation

let defaults = UserDefaults.standard

enum AuthStatus {
    case authorized(accessToken: String)
    case nonAuthorized(error: String)
}

enum RegisterStatus {
    case authorized(accessToken: String)
    case nonAuthorized(error: String)
}

protocol UserNetworkManager {
    func login(email: String, password: String, completion: @escaping (AuthStatus) -> ())
    func logout(completion: @escaping () -> ())
    func deleteUser(completion: @escaping () -> ())
    func register(surname: String,
                  name: String,
                  email: String,
                  password: String,
                  city: String,
                  birthday: String,
                  sex: Int, completion: @escaping (RegisterStatus) -> ())
    func currentUserInfo(completion: @escaping (_ user: CurrentUser?, _ error: String?) -> ())
    func getUserInfo(id: String, completion: @escaping (_ user: UserInfo?, _ error: String?) -> ())
}

final class UserNetworkManagerImpl: NetworkManager, UserNetworkManager {
    private let router: Router<UserEndPoint>
    
    init(router: Router<UserEndPoint>) {
        self.router = router
    }

    private func storeCookieForExtendedTime(_ cookie: HTTPCookie) {
        var properties = cookie.properties!
        properties[.expires] = Date.init(timeIntervalSinceNow: 2_592_000) as NSDate
        properties[.discard] = nil
        if let newCookie = HTTPCookie(properties: properties) {
            HTTPCookieStorage.shared.setCookie(newCookie)
        } else {
            print("Couldn't change the cookie!")
        }
    }

    func currentUserInfo(completion: @escaping (CurrentUser?, String?) -> ()) {
        router.request(.currentUser) { data, response, error in
            if error != nil {
                completion(nil, "Check network connection")
            }
            if let response = response as? HTTPURLResponse {
                let result = self.handleNetworkResponse(response)
                switch result {
                case .success:
                    guard let responseData = data else {
                        completion(nil, NetworkResponse.noData.rawValue)
                        return
                    }
                    do {
                        let apiResponse = try JSONDecoder().decode(CurrentUser.self, from: responseData)
                        completion(apiResponse.self, nil)
                    } catch {
                        completion(nil, NetworkResponse.unableToDecode.rawValue)
                    }
                case .failure(let failure):
                    completion(nil, failure)
                }
            }
        }
    }
    
    func getUserInfo(id: String, completion: @escaping (UserInfo?, String?) -> ()) {
        router.request(.userInfo(id: id)) { data, response, error in
            if error != nil {
                completion(nil, "Check network connection")
            }
            
            if let response = response as? HTTPURLResponse {
                let result = self.handleNetworkResponse(response)
                switch result {
                case .success:
                    guard let responseData = data else {
                        completion(nil, NetworkResponse.noData.rawValue)
                        return
                    }
                    do {
                        let apiResponse = try JSONDecoder().decode(UserInfo.self, from: responseData)
                        completion(apiResponse.self, nil)
                    } catch {
                        completion(nil, NetworkResponse.unableToDecode.rawValue)
                    }
                case .failure(let failure):
                    completion(nil, failure)
                }
            }
        }
    }
    
    func register(surname: String,
                  name: String,
                  email: String,
                  password: String,
                  city: String,
                  birthday: String,
                  sex: Int,
                  completion: @escaping (RegisterStatus) -> ()) {
        router.request(.register(surname: surname,
                                 name: name,
                                 email: email,
                                 password: password,
                                 city: city,
                                 birthday: birthday,
                                 sex: sex)) { data, response, error in
            if error != nil {
                completion(.nonAuthorized(error: "Check your connection"))
            }
            
            if let response = response as? HTTPURLResponse {
                let result = self.handleNetworkResponse(response)
                switch result {
                case .success:
                    guard let responseData = data else {
                        completion(.nonAuthorized(error: NetworkResponse.noData.rawValue))
                        return
                    }
                    do {
                        DispatchQueue.main.async {
                            let cookies = HTTPCookieStorage.shared.cookies?.first(where: { cookie in
                                return cookie.name == ".AspNetCore.Session"
                            })
                            self.storeCookieForExtendedTime(cookies!)
                            completion(.authorized(accessToken: cookies?.value ?? ""))
                            defaults.set(cookies, forKey: "cookie")
                        }
                    } catch {
                        completion(.nonAuthorized(error: NetworkResponse.unableToDecode.rawValue))
                    }
                    break
                case .failure(let reason):
                    completion(.nonAuthorized(error: reason))
                }
            }
        }
    }
    
    func login(email: String, password: String, completion: @escaping (AuthStatus) -> ()) {
        router.request(.login(email: email, password: password)) { data, response, error in
            if error != nil {
                completion(.nonAuthorized(error: "Check your connection"))
            }
            
            if let response = response as? HTTPURLResponse {
                let result = self.handleNetworkResponse(response)
                switch result {
                case .success:
                    guard let responseData = data else {
                        completion(.nonAuthorized(error: NetworkResponse.noData.rawValue))
                        return
                    }
                    do {
                        DispatchQueue.main.async {
                            var cookies = HTTPCookieStorage.shared.cookies?.first(where: { cookie in
                                return cookie.name == ".AspNetCore.Session"
                            })
                            self.storeCookieForExtendedTime(cookies!)
                            completion(.authorized(accessToken: cookies?.value ?? ""))
                            defaults.set(cookies, forKey: "cookie")
                        }
                    } catch {
                        completion(.nonAuthorized(error: NetworkResponse.unableToDecode.rawValue))
                    }
                case let .failure(reason):
                    completion(.nonAuthorized(error: reason))
                }
            }
        }
    }

    func logout(completion: @escaping () -> ()) {
        completion()
    }

    func deleteUser(completion: @escaping () -> ()) {
        completion()
    }
}
