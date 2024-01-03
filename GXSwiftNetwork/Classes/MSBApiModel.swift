//
//  MSBApiModel.swift
//  RSReading
//
//  Created by 高广校 on 2023/9/19.
//

import Foundation
import HandyJSON

open class MSBApiModel: MSBRespApiModel , HandyJSON {
    public required override init() {
        super.init(code: 0, msg: "")
    }
    
//    public override init() { }
//    open var data : T?
    open var success : Bool = false
//    open var msg : String = ""
}


