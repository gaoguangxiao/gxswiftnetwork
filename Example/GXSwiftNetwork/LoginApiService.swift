//
//  MSBApi.swift
//  MSBUserComponent
//
//  Created by 李响 on 2022/1/18.
//

import UIKit
import GXSwiftNetwork

class LoginApi: MSBApi {
    
    class VerificationCode: LoginApi {
        init(str:String) {
            super.init(path: "/wap/api/verification-code", method: .post,sampleData: str,showErrorMsg: false)
        }
    }
    
    class LoginCodeApi: LoginApi {
        init(str : String) {
            super.init(path: "/wap/api/auth/login", method: .post, sampleData: str)
        }
    }
    
    class GuestLoginApi: LoginApi {
        init(str : String) {
            super.init(path: "/wap/api/auth/guest/login", method: .post, sampleData: str,showHud: false)
        }
    }
}

public class LoginApiService: NSObject {
    
    public static func VerificationCode(param: String,closure: @escaping ((MSBApiModel?) -> ())) {
        let api = LoginApi.VerificationCode(str: param)
        api.request { (result: MSBApiModel?) in
            closure(result)
        } onFailure: { _ in
            closure(nil)
        }
    }
    
    public static func loginVerifyCode(with phoneNumber: String, code: String, closure: @escaping ((RSLoginModel?) -> ())) {
        let str = ["code": code, "phone": phoneNumber].toJsonString ?? ""
        let api = LoginApi.LoginCodeApi(str: str)
        api.request { (result: RSLoginModel?) in
            closure(result)
        } onFailure: { _ in
            closure(nil)
        }
    }
    
    public static func loginGuest(userNo: String, closure: @escaping ((RSLoginModel?) -> ())) {
        let str = ["userNo": userNo].toJsonString ?? ""
        let api = LoginApi.GuestLoginApi(str: str)
        api.request { (result: RSLoginModel?) in
            closure(result)
        } onFailure: { _ in
            closure(nil)
        }
    }
}
