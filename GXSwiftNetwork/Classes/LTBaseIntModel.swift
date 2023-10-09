//
//  MSBLoginCodeModel.swift
//  GXSwiftNetwork
//
//  Created by 高广校 on 2023/10/9.
//

import UIKit
import HandyJSON

public class MSBBaseIntModel: NSObject, HandyJSON {
    required public override init () { }
    public var msg: String = ""
    public var code: Int = -1
    public var data: Int = 0
}


public class MSBBaseStringModel: NSObject, HandyJSON {
    required public override init () { }
    public var msg: String = ""
    public var code: Int = -1
    public var data: String = ""
}
