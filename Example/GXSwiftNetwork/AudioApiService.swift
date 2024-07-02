//
//  RSAudioApiService.swift
//  RSReading
//
//  Created by 高广校 on 2023/9/19.
//

import UIKit
import GXSwiftNetwork
class RSBaseVoiceScopeModel: MSBApiModel {
    //    var data: SmartAny?
    
    //    解析失败
    //    init(msg: String, code: Int, success: Bool = false,_ data: SmartAny? = nil) {
    //        super.init()
    //        self.msg = msg
    //        self.code = code
    //        self.data = data
    //        self.success = success
    //    }
    //
    //    required init() {
    //        super.init()
    ////        fatalError("init() has not been implemented")
    //    }
    
    //    required init(from decoder: any Decoder) throws {
    //        fatalError("init(from:) has not been implemented")
    //    }
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
    
    class ChatGPTApi: RSAudioApi {
        init(paras : Dictionary<String, Any>) {
            super.init(url: "https://api.coze.com/open_api/v2/chat",
                       path: "",
                       method: .post,
                       headers: ["Authorization":"Bearer pat_OeGaGw1cAqmTuZduE5JoJVSJvSxJcBbOEY7DgtQApGFIJe2j2TYveqJspZxlm0wt"], 
                       parameters:paras)
        }
    }
}

class AudioApiService: NSObject {
    static let share : AudioApiService = {
        return AudioApiService()
    }()
    
    func requestVoiceScope(params:String,closure: @escaping ((RSBaseVoiceScopeModel?) -> ())) {
        //        let api = RSAudioApi.VoiceScopeApi(paras: params)
        //        api.request { (result: RSBaseVoiceScopeModel?) in
        //            closure(result)
        //        } onFailure: { _ in
        //            closure(nil)
        //        }
    }
    
    func requestTextReply(dataRaw: Dictionary<String, Any>,closure: @escaping ((RSBaseVoiceScopeModel?) -> ())) {
        
        let api = RSAudioApi.ChatGPTApi(paras: dataRaw)
        api.request { (result: RSBaseVoiceScopeModel?) in
            closure(result)
        } onFailure: { _ in
            closure(nil)
        }
    }
}
