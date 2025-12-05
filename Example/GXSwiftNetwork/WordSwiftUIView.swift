//
//  WordSwiftUIView.swift
//  GXSwiftNetwork_Example
//
//  Created by 高广校 on 2024/11/7.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import SwiftUI
import GXSwiftNetwork
import SmartCodable
public class SensitiveWordApi: MSBApi, MSBDataResponse {
    
    public typealias Model = MSBApiModel
    
    init(_ parameters: [String: Any]) {
        super.init(path: "/wap/api/sensitive-word/hide",method: .post,sampleData: parameters.toJsonString ?? "",showHud: false)
    }
    
//    public func response(parameters: [String : Any]) async throws {
//         try await requestV2(MSBApiModel.self)
//    }
}




struct WordSwiftUIView: View {
    
//    let api = SensitiveWordApi(["content":"李鹏可以的"])
    
    var body: some View {
        Button(action: {
            Task {
//                do {
//                    try await api.response(parameters:["content":"李鹏可以的"])
//                } catch let nsError as NSError {
//                    print(nsError.localizedDescription)
//                }
                
                let api = try await RSConfigAPi.response(url: "https://gateway-test.risekid.cn/assessment/api/material/video?code=K7fR2sLq9A")
                print(api.data?.cover)
//                let api = MSBApi(url: "https://gateway-test.risekid.cn/assessment/api/material/video?code=K7fR2sLq9A")
//                api.request { (result:TBData) in
                print(api.data?.cover)
//                } onFailure: { error in
//                    print(error)
//                }
            }
        }, label: {
            Text("关键词过滤")
        })
    }
}

#Preview {
    WordSwiftUIView()
}
