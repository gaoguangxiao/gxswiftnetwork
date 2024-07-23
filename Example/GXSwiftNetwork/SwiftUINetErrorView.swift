//
//  SwiftUINetErrorView.swift
//  GXSwiftNetwork_Example
//
//  Created by 高广校 on 2024/7/23.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import SwiftUI
import PKHUD
import SmartCodable
import GXSwiftNetwork

struct RSCodeModel: SmartCodable {
    var code: Int?
}

struct SwiftUINetErrorView: View {
    
    let js = """
"{\"code\":101,\"data\":\"\",\"message\":\"稍后重试\",\"success\":false}"
"""
    var body: some View {
        Form {
            
            Button {
                Task {
                    let model = MSBBaseModel<RSCodeModel>.deserialize(from: js)
                    if let msg = model?.msg, msg.count > 0 {
                        await MainActor.run { HUD.flash(.label(msg), delay: 2.5) }
                    }
                }
            } label: {
                Text("解析错误")
            }

            
        }
    }
}

#Preview {
    SwiftUINetErrorView()
}
