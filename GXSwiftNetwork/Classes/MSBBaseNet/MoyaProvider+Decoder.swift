//
//  MoyaProvider.swift
//  Created by 李响 on 2022/1/10.

//

import Foundation
import Moya
import Alamofire
import HandyJSON

// MARK: - request MoyaProvider
extension MoyaProvider {

    /// 请求封装
    /// 解析成想要的model类
//    internal func request<T: Decodable>(_ target: Target, onFailure: @escaping (MSBApiError) -> Void, onSuccess: @escaping (T) -> Void, atKeyPath: String? = nil, fullResponse: ((Moya.Response) -> Void)? = nil) {
//        func check401Fail(_ error: MSBApiError) {
//            if error.status == 401 || error.status == 1022 || error.status == 403 ||
//                error.status == 40001 || error.status == 40003 {
//                MSBApiConfig.shared.tokenInvalidateCallBack?()
//            }
//            onFailure(error)
//        }
//        
//        self.request(target) {result in
//            switch result {
//            case let .success(response):
////                let token = response.response?.allHeaderFields["token"] as? String
////                let tmpToken = response.response?.allHeaderFields["tmpToken"] as? String
////                let tokenTime = response.response?.allHeaderFields["t-c-t"] as? String
////                MSBApi.setToken(token: token, tmpToken: tmpToken, tokenTime: tokenTime, markedloginTime: markedLoginTime)
//                
//                fullResponse?(response)
//                do {
//                    let filteredResponse = try response.filterSuccessfulStatusCodes()
//                        let successObj = try filteredResponse.map(MSBResponse<T>.self, atKeyPath: atKeyPath)
//                        // 解析成功
//                        if successObj.code == 0 {
//                            if let data = successObj.payload {
//                                // Request and json parsing succeeded.
//                                onSuccess(data)
//                            } else {
//                                // Deal with MSBNull
//                                if let nullObj = MSBNull() as? T {
//                                    onSuccess(nullObj)
//                                } else {
//                                    check401Fail(MSBApiError(status: successObj.code, msg: successObj.errors ?? "Can not parse data of null.", alreadyDecoedObj: successObj))
//                                }
//                            }
//                        } else {
//                            // Server response code != 0
//                            check401Fail(MSBApiError(status: successObj.code, msg: successObj.errors ?? "", alreadyDecoedObj: successObj))
//                        }
//                } catch let error {
//                    // HTTP statuc code error or json parsing error.
//                    var errorMessage = ""
//                    switch response.statusCode {
//                    case 401:
//                        errorMessage = "登录已失效,请重新登录"
//                    case 300...399:
//                        errorMessage = "Redirection"
//                    case 400...499:
//                        errorMessage = "Client Errors"
//                    case 500...599:
//                        errorMessage = "Server Errors"
//                    default:
//                        errorMessage = error.localizedDescription
//                    }
//                    log(error)
//                    check401Fail(MSBApiError(status: response.statusCode, msg: errorMessage))
//                }
//            case let .failure(moyaError):
//                // Moya request error, possibly due to unreachable network.
//                let nsError = moyaError as NSError
//                let msg = moyaError.msbDes != nil ? moyaError.msbDes : nsError.localizedDescription
//                onFailure(MSBApiError(status: nsError.code, msg: msg))
//            }
//        }
//    }
//    
//    /// 请求封装
//    /// 设置正确、错误2种Data格式
//    internal func requestWithCustomError<T: Decodable,ErrorDataType: Decodable>(_ target: Target, onSuccess: @escaping (T) -> Void, onFailure: @escaping (MSBApiError) -> Void,  onCustomErrorCallBack: @escaping (ErrorDataType) -> Void, fullResponse: ((Moya.Response) -> Void)? = nil) {
//        func check401Fail(_ error: MSBApiError) {
//            if error.status == 401 || error.status == 1022 ||
//                error.status == 40001 || error.status == 40003  {
//                MSBApiConfig.shared.tokenInvalidateCallBack?()
//            }
//            onFailure(error)
//        }
////        let markedLoginTime = Defaults[.tryToLoginTime]
//        self.request(target) { result in
//            switch result {
//            case let .success(response):
////                let token = response.response?.allHeaderFields["token"] as? String
////                let tmpToken = response.response?.allHeaderFields["tmpToken"] as? String
////                let tokenTime = response.response?.allHeaderFields["t-c-t"] as? String
////                MSBApi.setToken(token: token, tmpToken: tmpToken, tokenTime: tokenTime, markedloginTime: markedLoginTime)
//                
//                fullResponse?(response)
//                do {
//                    let filteredResponse = try response.filterSuccessfulStatusCodes()
//                    if let successObj = try? filteredResponse.map(MSBResponse<T>.self) {
//                        // 解析成功
//                        if successObj.code == 0 {
//                            if let data = successObj.payload {
//                                // Request and json parsing succeeded.
//                                onSuccess(data)
//                            } else {
//                                // Deal with MSBNull
//                                if let nullObj = MSBNull() as? T {
//                                    onSuccess(nullObj)
//                                } else {
//                                    check401Fail(MSBApiError(status: successObj.code, msg: successObj.errors ?? "Can not parse data of null.", alreadyDecoedObj: successObj))
//                                }
//                            }
//                        } else {
//                            // Server response code != 0
//                            check401Fail(MSBApiError(status: successObj.code, msg: successObj.errors ?? "", alreadyDecoedObj: successObj))
//                        }
//                    } else if let failObj = try? filteredResponse.map(MSBResponse<MSBNull>.self) {
//                        check401Fail(MSBApiError(status: failObj.code, msg: "数据格式错误"))
//                        if let cusFailObj = (try? filteredResponse.map(MSBResponse<ErrorDataType>.self))?.payload {
//                            onCustomErrorCallBack(cusFailObj)
//                        }
//                    }
//                    
//                } catch let error {
//                    // HTTP statuc code error or json parsing error.
//                    var errorMessage = ""
//                    switch response.statusCode {
//                    case 401:
//                        errorMessage = "登录已失效,请重新登录"
//                    case 300...399:
//                        errorMessage = "Redirection"
//                    case 400...499:
//                        errorMessage = "Client Errors"
//                    case 500...599:
//                        errorMessage = "Server Errors"
//                    default:
//                        errorMessage = error.localizedDescription
//                    }
//                    log(error)
//                    check401Fail(MSBApiError(status: response.statusCode, msg: errorMessage))
//                }
//            case let .failure(moyaError):
//                // Moya request error, possibly due to unreachable network.
//                let nsError = moyaError as NSError
//                let msg = moyaError.msbDes != nil ? moyaError.msbDes : nsError.localizedDescription
//                check401Fail(MSBApiError(status: nsError.code, msg: msg))
//            }
//        }
//   }
    
    /// 解析成想要的model类
    internal func request<T: HandyJSON>(_ target: Target, onFailure: @escaping (MSBApiError) -> Void, onSuccess: @escaping (T?) -> Void, fullResponse: ((Moya.Response) -> Void)? = nil) {
//        let markedLoginTime = Defaults[.tryToLoginTime]
        self.request(target) { result in
            switch result {
            case let .success(response):
                
                fullResponse?(response)
                do {
                    let response = try response.filterSuccessfulStatusCodes()
                    let jsonObject = try response.mapJSON() as? [String: Any]
                    log("**************response data = \(jsonObject ?? [:])**************")
                    let model = T.deserialize(from: jsonObject, designatedPath: "")
                    let code = jsonObject?["code"] as? Int
                    if code == 0 {
                        //请求成功
                    } else {
                        //
//                        let msg = jsonObject?["msg"] as? String
//                        MSBHUDManager.showHUD(info: msg ?? "")
                    }
                    onSuccess(model)
                } catch let error {
                    // HTTP statuc code error or json parsing error.
                    var errorMessage = ""
                    switch response.statusCode {
                    case 300...399:
                        errorMessage = "Redirection"
                    case 400...499:
                        errorMessage = "Client Errors"
                    case 500...599:
                        errorMessage = "Server Errors"
                    default:
                        errorMessage = error.localizedDescription
                    }
                    onFailure(MSBApiError(status: response.statusCode, msg: errorMessage))
                }
            case let .failure(moyaError):
                // Moya request error, possibly due to unreachable network.
                let nsError = moyaError as NSError
                let msg = moyaError.msbDes != nil ? moyaError.msbDes : nsError.localizedDescription
                onFailure(MSBApiError(status: nsError.code, msg: msg))
            }
        }
    }
}
