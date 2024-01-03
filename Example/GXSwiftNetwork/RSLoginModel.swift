//
//  RSLoginModel.swift
//  RSReading
//
//  Created by 高广校 on 2023/10/20.
//

import Foundation
import GXSwiftNetwork

public class RSBridgeLoginModel: MSBApiModel {
    var disableGuest: Bool = false //是否禁用游客模式，true不提供游客登录
}


public class RSLoginModel: MSBApiModel {
    var data: String?
}
