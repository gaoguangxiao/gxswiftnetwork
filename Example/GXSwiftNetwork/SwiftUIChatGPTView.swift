//
//  SwiftUIChatGPTView.swift
//  GXSwiftNetwork_Example
//
//  Created by 高广校 on 2024/6/25.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import SwiftUI

struct SwiftUIChatGPTView: View {
    var body: some View {
        
        Button(action: {
            
            let dataRaw = [
                "query":"今红楼梦的作者",
                "conversation_id":"10",
                "user":"纳威",
                "stream":1,
                "bot_id":"7384378802530746385"
            ]
            
            AudioApiService.share.requestTextReply(dataRaw: dataRaw) { data in
                
            }
        }, label: {
            Text("问答")
        })
    }
}

#Preview {
    SwiftUIChatGPTView()
}
