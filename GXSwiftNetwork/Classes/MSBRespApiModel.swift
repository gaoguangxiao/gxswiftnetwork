//
//  MSBRespApiModel.swift
//  GXSwiftNetwork
//
//  Created by 高广校 on 2023/12/28.
//

import Foundation

open class MSBRespApiModel: NSObject {
    open var respAllHeaderFields: [AnyHashable : Any]?
    open var respData: Data?
    
    open var code : Int = 0
    open var msg : String = ""
    
    public override init() {
        
    }
    
    init(respAllHeaderFields: [AnyHashable : Any]? = nil, respData: Data? = nil, code: Int, msg: String) {
        self.respAllHeaderFields = respAllHeaderFields
        self.respData = respData
        self.code = code
        self.msg = msg
    }
}
