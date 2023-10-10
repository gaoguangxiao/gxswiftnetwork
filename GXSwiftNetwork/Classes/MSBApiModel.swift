//
//  MSBApiModel.swift
//  RSReading
//
//  Created by 高广校 on 2023/9/19.
//

import Foundation
import HandyJSON

public class MSBApiModel<T>: NSObject , HandyJSON {
    required public override init() { }
    public var data : T?
    public var success : Bool = false
    public var msg : String = ""
    public var code : Int8 = 0
}