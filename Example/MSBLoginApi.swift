//
//  MSBApi.swift
//  MSBUserComponent
//
//  Created by 李响 on 2022/1/18.
//



import UIKit
import HandyJSON

class MSBLoginApi: MSBApi {
    
    class VerificationCode: MSBLoginApi {
        init(_ url:String,param:[String : Any]) {
            super.init(path: url, method: .post, parameters: param)
        }
    }
}

public class GXLoginViewModel: NSObject {
    
    public static func VerificationCode<T>(param: [String : Any], _ url:String,_ model:T,closure: @escaping ((HandyJSON?) -> ())) {
        let api = MSBLoginApi.VerificationCode(url, param: param)
        api.request { (result: MSBBaseIntModel?) in
            closure(result)
        } onFailure: { _ in
            closure(nil)
        }
    }
}
