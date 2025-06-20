//
//  RSConfigAPi.swift
//  GXSwiftNetwork_Example
//
//  Created by 高广校 on 2025/6/17.
//  Copyright © 2025 CocoaPods. All rights reserved.
//

import Foundation
import GXSwiftNetwork
import SmartCodable

public class TData: SmartCodable {
    var name: String?
    var url: String?
    var status: Int?
    var cover: String?
    var type: Int?

    public required init() {}
}

class RSConfigAPi: MSBApi {
    
    init(url: String) {
        super.init(url: url,showHud: false)
    }
    
    static func response(url:String) async throws -> MSBBaseModel<TData> {
        let api = RSConfigAPi(url: url)
        let reponseResult = try await api.dataTask(with:TData.self)
        return reponseResult
    }
}
