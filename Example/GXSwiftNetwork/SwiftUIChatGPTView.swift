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


struct SwiftUIChatGPTView: View {
    
    @State var startConfigChatTime = 0.0
    
    @State var timeInterval = 0.0
    
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
                        do {
                            self.startConfigChatTime = CFAbsoluteTimeGetCurrent()
                            let reponseResult = try await CerCozeApi.response()
                            if let token = reponseResult.token {
                                print("token: \(token)")
                                let acquireResultTime = CFAbsoluteTimeGetCurrent()
                                timeInterval = (acquireResultTime - self.startConfigChatTime) * 1000
                                print("timeInterval: \(timeInterval)")
                            }
                        } catch {
                            print("catch-:\(error)")
                        }
                        
                    }
                }, label: {
                    Text("获取Coze配置:\(timeInterval)毫秒")
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
