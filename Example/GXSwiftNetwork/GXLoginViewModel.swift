//
//  MSBApi.swift
//  MSBUserComponent
//
//  Created by 李响 on 2022/1/18.
//

import UIKit
import HandyJSON
import GXSwiftNetwork

class MSBLoginApi: MSBApi {
    
    class VerificationCode: MSBLoginApi {
        init(str:String) {
            super.init(path: "/user/api/verification-code",
                       method: .post,sampleData: str,showErrorMsg: true)
        }
    }
}

public class GXLoginViewModel: NSObject {
    
    public static func VerificationCode(param: String,closure: @escaping ((MSBApiModel<Any>?) -> ())) {
        let api = MSBLoginApi.VerificationCode(str: param)
        api.request { (result: MSBApiModel?) in
            closure(result)
        } onFailure: { _ in
            closure(nil)
        }
    }
}
