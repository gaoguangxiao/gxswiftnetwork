//
//  RSAudioApiService.swift
//  RSReading
//
//  Created by 高广校 on 2023/9/19.
//

import UIKit
import GXSwiftNetwork
import HandyJSON
class RSBaseVoiceScopeModel: MSBApiModel {
    var data: RSVoiceScopeModel?

//    解析失败
    init(msg: String, code: Int, success: Bool = false,_ data: RSVoiceScopeModel? = nil) {
        super.init()
        self.msg = msg
        self.code = code
        self.data = data
        self.success = success
    }
    
    required init() {
        super.init()
//        fatalError("init() has not been implemented")
    }
}

class RSVoiceScopeModel: MSBApiModel {
    var fileUrl : String = ""
    var scope : Float = 0.0
}

class RSAudioApi: MSBApi {
    
    class VoiceScopeApi: RSAudioApi {
        init(paras : String) {
            super.init(path: "/cms/api/voice/scope",method: .post,sampleData: paras,showErrorMsg: true,showHud: false)
        }
    }
}

class AudioApiService: NSObject {
    static let share : AudioApiService = {
        return AudioApiService()
    }()
    
    func requestVoiceScope(params:String,closure: @escaping ((RSBaseVoiceScopeModel?) -> ())) {
        let api = RSAudioApi.VoiceScopeApi(paras: params)
        api.request { (result: RSBaseVoiceScopeModel?) in
            closure(result)
        } onFailure: { _ in
            closure(nil)
        }
    }
}
