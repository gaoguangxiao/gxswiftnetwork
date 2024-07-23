//
//  SwiftUIChatGPTView.swift
//  GXSwiftNetwork_Example
//
//  Created by 高广校 on 2024/6/25.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import SwiftUI
import GXSwiftNetwork
import SmartCodable

//class CozeBaseModel: MSBApiModel {
    
//    var code
//}
struct CozeResponseModel: SmartCodable {
    var botId: String?
    var token: String?
    var url: String?
}


class certificateCoze: MSBApi {
    
    init() {
        super.init(path: "/wap/api/certificate/coze")
    }
}

struct SwiftUIChatGPTView: View {
    var body: some View {
                
        Form {
            
            Button(action: {
                
                let dataRaw = [
                    "query":"今红楼梦的作者",
                    "conversation_id":"10",
                    "user":"纳威",
                    "stream":1,
                    "bot_id":"7383946252129927176"
                ]
                
                ChatApiService.share.requestTextReply(dataRaw: dataRaw) { data in
                    
                }
            }, label: {
                Text("问答")
            })
            
            Section {
                Button(action: {
                    Task {
                        //获取coze
                        let api = certificateCoze()
                        do {
                            
                            let reponseResult = try await api.dataTask(with:CozeResponseModel.self)
                            if let token = reponseResult.data?.token {
                                print("token: \(token)")
                            }
                            
                        } catch {
                            print("catch-:\(error)")
                        }
                        
                    }
                }, label: {
                    Text("获取Coze配置")
                })
            }
        }
        .onAppear(perform: {
            MSBApiConfig.shared.setApiConfig(apiHost: "https://gateway-test.risekid.cn", commonHeaders: ["token":"Bearer eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiIxIiwidXVpZCI6Ilc5dUNxQmtHIn0.i3k36fWdPvxlQbb2_ZjHRb61x1zlD10tjDJr8zy7DR0MU10EFNc-AIVs2hWfimYwF_mhXFDJxiVYBPn-lJIpCA"], isAddDefaultHeaders: true)
            
        })
        
    }
}

#Preview {
    SwiftUIChatGPTView()
}
