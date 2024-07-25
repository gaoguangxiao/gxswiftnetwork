//
//  CerCozeApi.swift
//  RSReading
//
//  Created by 高广校 on 2024/7/24.
//

import Foundation
import GXSwiftNetwork
import SmartCodable

struct CozeResponseModel: SmartCodable {
    var botId: String?
    var token: String?
    var url: String?
}

//MARK: - ChatError
enum AiCozeError:Int, CustomNSError {
    case getConfigError
    case getTokenError
    case getBotIDError
    case rsaDecryptTokenError
    case rsaDecryptBotIDError
    
    ///描述ai聊天的
    static var errorDomain: String {
        return "cozeai"
    }
    
    var errorUserInfo: [String : Any] {
        switch self {
        case .getTokenError: ["msg": "获取临时token失败"]
        case .rsaDecryptTokenError: ["msg": "RSA解密Token失败"]
        case .getBotIDError:
            ["msg": "获取临时botID失败"]
        case .rsaDecryptBotIDError:
            ["msg": "RSA解密BotID失败"]
        case .getConfigError:
            ["msg": "获取配置失败"]
        }
    }
}

extension AiCozeError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .getTokenError: "获取临时token失败"
        case .rsaDecryptTokenError: "RSA解密Token失败"
        case .getBotIDError: "获取临时botID失败"
        case .rsaDecryptBotIDError: "RSA解密BotID失败"
        case .getConfigError:
            "获取配置失败"
        }
    }
}

class CerCozeApi: MSBApi, MSBDataResponse {
    
    typealias Model = CozeResponseModel
    
    init() {
        super.init(path: "/wap/api/certificate/coze",showHud: false)
    }
    
    static func response() async throws -> CozeResponseModel {
        
        let api = CerCozeApi()
        let reponseResult = try await api.dataTask(with:CozeResponseModel.self)
        
//        guard let token = reponseResult.data?.token else { throw AiCozeError.getTokenError }
//        guard let botID = reponseResult.data?.botId else { throw AiCozeError.getBotIDError }
//
//        //2、获取到token
//        var result = CozeResponseModel()
//        result.url = reponseResult.data?.url
//        
//        let rawToken = GGXRSA.decryptByPrivate(str: token)
//        guard let rawToken else { throw AiCozeError.rsaDecryptTokenError }
//        
//        let rawBotID = GGXRSA.decryptByPrivate(str: botID)
//        guard let rawBotID else { throw AiCozeError.rsaDecryptBotIDError }
//        
//        result.token = rawToken
//        result.botId = rawBotID
        
        //对coze接口信息进行缓存
        return reponseResult.data!
    }
}
