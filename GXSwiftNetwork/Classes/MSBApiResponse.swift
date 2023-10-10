//
//  MSBAPIResponseBasicModel.swift

//  Created by 李响 on 2022/1/10.

//

import Foundation
import HandyJSON


public class MSBResponse<T: Decodable>: Decodable {
    public var code: Int = 0
    public var success: Int = 0
    public var msg: String?
    public var data: T?
    private enum CodingKeys: String, CodingKey {
        case success, code, data, msg
    }
}

public class MSBNull: Decodable {}
