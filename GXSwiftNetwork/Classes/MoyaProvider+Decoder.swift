//
//  MoyaProvider.swift
//  Created by 李响 on 2022/1/10.

//

import Foundation
import Moya
//import SwiftyUserDefaults
import Alamofire
import HandyJSON
import PKHUD

// MARK: - request MoyaProvider
extension MoyaProvider {

    /// 解析成想要的model类
    internal func request<T: MSBApiModel>( _ target: Target,
                                         _ rTarget:MSBApi,
                                        onFailure: @escaping (MSBApiError) -> Void,
                                        onSuccess: @escaping (T?) -> Void,
                                        fullResponse: ((Moya.Response) -> Void)? = nil) {
//        let markedLoginTime = Defaults[.tryToLoginTime]
        if rTarget.requestShowHUD {
            HUD.show(.label("加载中..."))
        }
        self.request(target) { result in
            HUD.hide(animated: true)
            switch result {
            case let .success(response):
                fullResponse?(response)
                do {
                    let response = try response.filterSuccessfulStatusCodes()
                    let jsonObject = try response.mapJSON() as? [String: Any]
                    log("**************response data = \(jsonObject ?? [:])**************")
                    let model = T.deserialize(from: jsonObject, designatedPath: "")
                    
                    //解析具体数据
                    if let isSu = model?.success , isSu == false ,rTarget.requestShowErrorMsg{
                        let msg = model?.msg
                        HUD.flash(.label(msg), delay: 1.5)
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
