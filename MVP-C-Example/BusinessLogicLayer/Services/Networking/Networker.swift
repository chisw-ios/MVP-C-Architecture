//
//  Networker.swift
//  MVP-C-Example
//
//  Created by vlad.kosyi on 02.07.2021.
//

import Foundation
import Alamofire

typealias DocumentParameters = [String: DocumentProtocol]
typealias DefaultResult = (Bool, ErrorMessage?)->()

enum StatuCodes {
    static let unknownError = 0
    static let ok = 200
    static let created = 201
    static let unuthorized = 401
    static let server = 500
}

enum TokenErrors: Error {
    case retryLimitReached
    case impossibleToGetNewToken
}

enum Resulter<T> {
    case success(T)
    case failure(ErrorMessage)
}

class Networker {
        
    private let retryLimit = 10
    private var retryCount = 0
    
    var sessionManager: Session = {
        let manager = ServerTrustManager(evaluators: [Configuration.apiBaseUrl: DisabledTrustEvaluator()])
        let configuration = URLSessionConfiguration.af.default

        return Session(configuration: configuration, serverTrustManager: manager)
    }()
    
    // MARK: - Public methods
    
    // default call with status code 200
    func call(type: EndPointType, params: Parameters? = nil, interceptor: RequestInterceptor? = nil, handler: @escaping (()?, _ error: ErrorMessage?)->()) {
        self.sessionManager.request(type.url,
                                    method: type.httpMethod,
                                    parameters: params,
                                    encoding: type.encoding,
                                    headers: type.headers,
                                    interceptor: interceptor ?? self)
                                    .validate()
                                    .responseData { data in
                                        switch data.response?.statusCode {
                                        case StatuCodes.created, StatuCodes.ok:
                                            handler((), nil)
                                        default:
                                            handler(nil, Networker.parseApiError(data: data.data))
                                        }
        }
    }
    
    // call with special return type
    @discardableResult
    func call<T>(type: EndPointType, params: Parameters? = nil, interceptor: RequestInterceptor? = nil, handler: @escaping (Resulter<T>)->()) -> DataRequest where T: Codable {
        let request = self.sessionManager.request(type.url,
                                    method: type.httpMethod,
                                    parameters: params,
                                    encoding: type.encoding,
                                    headers: type.headers,
                                    interceptor: interceptor ?? self)
        request.validate(statusCode: StatuCodes.ok...StatuCodes.created).responseJSON { data in
                                        switch data.result {
                                        case .success(_):
                                            if let jsonData = data.data {
                                                guard let result = Networker.parseObject(T.self,data: jsonData) else {
                                                    handler(Resulter.failure(ErrorMessage.parseError()))
                                                    return
                                                }
                                                handler(Resulter.success(result))
                                            }
                                            break
                                        case .failure(_):
                                            let error = Networker.parseApiError(data: data.data)
                                            print(error.body)
                                            handler(Resulter.failure(error))
                                            break
                                        }
        }
        return request
    }

    // call with multipart
    func callJsonWithMultipart<T>(type: EndPointType, documentParams: [DocumentParameters],  jsonParams: Parameters, jsonKey: String, handler: @escaping (Resulter<T>)->()) where T: Codable  {
        
        AF.upload(multipartFormData: { multipartFormData in
            
            documentParams.forEach { (documentParam) in
                for (key, value) in documentParam {
                    multipartFormData.append(value.docData, withName: key, fileName: value.filename, mimeType: value.contentType)
                }
            }
            
            let jsonData = try? JSONSerialization.data(withJSONObject: jsonParams)
            if let json = jsonData {
                multipartFormData.append(json, withName: jsonKey, mimeType: "application/json")
            }
            
        }, to: type.url, method: type.httpMethod, headers: type.headers) .responseJSON { (resp) in
            
            switch resp.result {
            case .success(_):
                if let jsonData = resp.data {
                    guard let result = Networker.parseObject(T.self,data: jsonData) else {
                        handler(Resulter.failure(ErrorMessage.parseError()))
                        return
                    }
                    handler(Resulter.success(result))
                }
                break
            case .failure(_):
                let error = Networker.parseApiError(data: resp.data)
                print(error.body)
                handler(Resulter.failure(error))
                break
            }
        }
    }
    
    // MARK: - Private methods
    
    static func parseApiError(data: Data?) -> ErrorMessage {
        let defaultError = ErrorMessage.defaultError()
        guard let jsonData = data else { return defaultError }
        print(try? JSONSerialization.jsonObject(with: jsonData, options: .allowFragments))
        
        do {
            let decoder = JSONDecoder()
            let error = try decoder.decode(NetworkError.self, from: jsonData)
            return ErrorMessage(message: error.detail ?? "", code: error.statusCode)
        } catch DecodingError.dataCorrupted(let context) {
            return ErrorMessage(title: GlobalConstants.errorAlertTitle, body: "\(context)")
        } catch DecodingError.keyNotFound(let key, let context) {
            return ErrorMessage(title: GlobalConstants.errorAlertTitle, body: "Key '\(key)' not found: \(context.debugDescription)")
        } catch DecodingError.valueNotFound(let value, let context) {
            return ErrorMessage(title: GlobalConstants.errorAlertTitle, body: "Value '\(value)' not found: \(context.debugDescription)")
        } catch DecodingError.typeMismatch(let type, let context) {
            return ErrorMessage(title: GlobalConstants.errorAlertTitle, body: "Type '\(type)' mismatch: \(context.debugDescription)")
        } catch {
            return defaultError
        }
    }
    
    static func parseObject<T>(_ type: T.Type, data: Data)  -> T? where T: Codable {
                
        do {
            let decoder = JSONDecoder()
            let result = try decoder.decode(T.self, from: data)
            return result
        } catch DecodingError.dataCorrupted(let context) {
            print(context)
        } catch DecodingError.keyNotFound(let key, let context) {
            print("Key '\(key)' not found:", context.debugDescription)
            print("codingPath:", context.codingPath)
        } catch DecodingError.valueNotFound(let value, let context) {
            print("Value '\(value)' not found:", context.debugDescription)
            print("codingPath:", context.codingPath)
        } catch DecodingError.typeMismatch(let type, let context) {
            print("Type '\(type)' mismatch:", context.debugDescription)
            print("codingPath:", context.codingPath)
        } catch {
            print("error: ", error)
        }
        
        return nil
    }
    
    // MARK: - Initialization
    
    init(sessionManager: Session) {
        self.sessionManager = sessionManager
    }
}

// Refresh token
// MARK: - Networker+RequestInterceptor
// https://medium.com/swlh/retry-request-using-alamofire-52c7dcd72175
extension Networker: RequestInterceptor {

    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        var request = urlRequest
        if let token = TokenStorage.fetchAccessToken() {
            let bearerToken = "Bearer \(token)"
            request.setValue(bearerToken, forHTTPHeaderField: "Authorization")
        }
        completion(.success(request))
    }

    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        guard TokenStorage.fetchAccessToken() != nil else { completion(.doNotRetry) ; return }
        self.callWithStatusCode(type: AuthRequestItemsType.authenticated) { [weak self] (statusCode, error)  in
            guard let self = self else { return }
            // if refresh success -> retry previous request, else doNotRetry
            // if retry limit = 3 -> doNotRetry and goTo LoginFlow
            if statusCode == StatuCodes.unuthorized || statusCode == StatuCodes.server {
                guard self.retryCount < self.retryLimit else {
                    // goTo LoginFlow
                    self.sessionManager.cancelAllRequests()
                    NotificationCenter.default.post(name: Notifications.InvalidRefreshTokenKey, object: nil)
                    return }
                self.retryCount = self.retryCount + 1
                self.refreshToken { isSuccess in
                    isSuccess ? completion(.retry) : completion(.doNotRetry)
                }
            } else { completion(.doNotRetry) }
        }
    }

    func refreshToken(completion: @escaping (_ isSuccess: Bool) -> Void) {
         print("refreshToken")
         guard let refreshToken = TokenStorage.fetchRefreshToken() else {
            self.sessionManager.cancelAllRequests()
             NotificationCenter.default.post(name: Notifications.InvalidRefreshTokenKey, object: nil)
             return
         }

         let json : [String: String] = ["refresh_token": refreshToken]
         self.call(type: AuthRequestItemsType.refreshToken, params: json) { (responce: Resulter<AuthResponse>) in
             switch responce {
                 case let .success(data):
                    TokenStorage.clearTokens()
                    TokenStorage.setAccessToken(token: data.access_token)
                    TokenStorage.setRefreshToken(token: data.refresh_token)
                    completion(true)
                 case .failure:
                    completion(false)
            }
         }
     }


    func callWithStatusCode(type: EndPointType, params: Parameters? = nil, interceptor: RequestInterceptor? = nil, handler: @escaping ((Int, _ error: Error?)-> Void)) {
        self.sessionManager.request(type.url,
                                method: type.httpMethod,
                                parameters: params,
                                encoding: type.encoding,
                                headers: type.headers)
                                .validate()
                                .responseData { data in
                                    
                                    guard let response = data.response else { return handler(StatuCodes.unknownError,  data.error) }
                                        switch response.statusCode {
                                        case StatuCodes.unuthorized:  handler(StatuCodes.unuthorized, data.error)
                                        default: handler(StatuCodes.unknownError,  data.error)
                                        }
                                    }
    }
}
