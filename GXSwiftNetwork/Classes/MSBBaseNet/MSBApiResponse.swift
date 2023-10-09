//
//  MSBAPIResponseBasicModel.swift

//  Created by 李响 on 2022/1/10.

//

import Foundation
import HandyJSON

/// 注意⚠️ 适配老接口，及将废弃
@available(*, deprecated, message: "注意⚠️ 将要废弃")
public class MSBResponse<T: Decodable>: Decodable {
    public var code: Int = 0
    public var status: String?
    public var errors: String?
    public var payload: T?
    private enum CodingKeys: String, CodingKey {
        case status, code, payload, errors
    }
}

public class MSBNull: Decodable {}
