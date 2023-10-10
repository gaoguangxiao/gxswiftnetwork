//
//  MSBError.swift
//  MSBAlamofire
//
//  Created by 李响 on 2022/1/12.
//

import UIKit
import Alamofire
import Moya

public struct MSBApiError: CustomStringConvertible {
    public var status: Int
    public var msg: String?
    public var alreadyDecoedObj: Any?

    public init(status: Int, msg: String?, alreadyDecoedObj: Any? = nil) {
        self.status = status
        self.msg = msg
        self.alreadyDecoedObj = alreadyDecoedObj
    }
    
    public var description: String {
        return "[MSBApiError] \(status): \(msg ?? "")"
    }
}

extension AFError {
   
    public var originalError: String? {
        switch self {
        case let .sessionTaskFailed(error):
            return error.localizedDescription
        default:
            return nil
        }
    }
}

extension MoyaError {
 
    public var msbDes: String? {
        switch self {
        case .underlying(let error, _):
            return (error as? AFError)?.originalError
        default:
            return nil
        }
    }
}
