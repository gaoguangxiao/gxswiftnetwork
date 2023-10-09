//
//
//  Created by 李响 on 2022/1/10.

//

import Foundation
import Moya
import HandyJSON
import Alamofire
import UIKit

/* 使用方法：
 - 定义
 class exampleApi: BearShowApi {
 init(id: String) {
 super.init(path: "/xxx/xxx/xxxx", method: .post, parameters: ["worksId" : id])
 }
 
 struct resultModel: Codable {
 var checkResult: String
 }
 }
 
 - 调用
 exampleApi(id: "\(workID)").request(success: { (response: exampleApi.resultModel) in
 log("成功结果: \(response.checkResult)")
 })
 - 或
 exampleApi(id: "\(workID)").request(success: { (response: exampleApi.resultModel) in
 log("成功结果: \(response.checkResult)")
 }, failure: { error in
 // 自己处理Fail
 })
 
 */

open class MSBApi: Moya.TargetType {
    
    open var mock: Bool { false }
    open var verbose: Bool { false }
    open var requestPath: String
    open var requestMethod: Moya.Method
    open var requestSampleData: String
    open var requestParameters: [String: Any]
    
    public init(path: String, method: Moya.Method = .get, parameters: [String: Any] = [:],
                sampleData: String = "") {
        requestPath = path
        requestMethod = method
        requestParameters = parameters
        requestSampleData = sampleData
        
        log("**************Request data = \(parameters)**************")
    }
    
    /// 获取自定义json model数据
    open func request<T: HandyJSON>(onSuccess: @escaping (T?) -> Void, onFailure: @escaping (MSBApiError) -> Void, provider: MoyaProvider<MSBApi>? = nil, fullResponse: ((Moya.Response) -> Void)? = nil) {
        var useProvider = self.provider
        if let paramProvider = provider {
            useProvider = paramProvider
        }
        let logPosition = requestPath
        useProvider.request(self, onFailure: { msbError in
            if self.reportError(error: msbError) {
                MSBApiConfig.shared.reportBuglyAbility?(msbError.status, ["网络错误":msbError.msg ?? "未知错误"])
                log("❌ 【API】status:\(msbError.status) msg:\(msbError.msg ?? "") path: \(logPosition)")
            }
            onFailure(msbError)
        }, onSuccess: onSuccess)
    }
    
}

// MARK: =================== TargetType
extension MSBApi {
    public var baseURL: URL {
        guard let apiHost = MSBApiConfig.shared.getApiHost?(), let url = URL(string: apiHost) else {
            fatalError("BaseURL could not be configured.")
        }
        return url
    }
    
    public var headers: [String: String]? {
        print("********request headers=\(MSBApiConfig.shared.headers ?? [:])***********")
        return MSBApiConfig.shared.headers
    }
    
    public var path: String { requestPath }
    public var method: Moya.Method { requestMethod }
    public var sampleData: Data { requestSampleData.data(using: String.Encoding.utf8) ?? Data() }
    
    public var task: Task {
        if !requestParameters.keys.isEmpty {
            if (method == .post) {
//                if requestParameters["file"] != nil {
//
//                    if let image = requestParameters["file"] as? UIImage , let imageData : Data = image.jpegData(compressionQuality: 0.9){
//                        
//                        //根据当前时间设置图片上传时候的名字
//                        let date:Date = Date()
//                        let formatter = DateFormatter()
//                        formatter.dateFormat = "yyyy-MM-dd-HH:mm:ss"
//                        var dateStr:String = formatter.string(from: date as Date)
//                        
//                        let formData = MultipartFormData(provider: .data(imageData), name: "file", fileName: dateStr, mimeType: "image/jpeg")
////                        formDataAry?.add(formData)
//                        return .uploadMultipart([formData])
//
//                    } else {
//                        return .requestParameters(parameters: requestParameters, encoding: URLEncoding.default)
//                    }
//
//                } else {
                    return .requestParameters(parameters: requestParameters, encoding: URLEncoding.default)
//                }
            } else {
                return .requestParameters(parameters: requestParameters, encoding: URLEncoding.default)
            }
            
            //
        } else {
            return .requestPlain
        }
    }
}

// MARK: =================== providers
extension MSBApi {
    
    static let silenceProvider = MoyaProvider<MSBApi>(plugins: [])
    static let providerLogPlugin = NetworkLoggerPlugin()
    static let verboseProvider = MoyaProvider<MSBApi>(plugins: [providerLogPlugin])
    static let mockProvider = MoyaProvider<MSBApi>(stubClosure: MoyaProvider.immediatelyStub)
    
    var provider: MoyaProvider<MSBApi> {
        if MSBApiConfig.shared.getIsDebug?() != true {
            return MSBApi.silenceProvider
        } else if mock {
            return MSBApi.mockProvider
        } else if verbose {
            return MSBApi.verboseProvider
        } else {
            return MSBApi.silenceProvider
        }
    }
}

// MARK: =================== 内部函数调用
extension MSBApi {
    
    public static let defaultFailureHandle: ((MSBApiError) -> Void) = { err in
        MSBApiConfig.shared.dismissHUDAbility?()
        showApiError(err)
    }
    
    open class func showApiError(_ error: MSBApiError) {
        MSBApiConfig.shared.showHUDAbility?(error)
    }
    
    /// show toast and log error
    public class func handleError(_ err: MSBApiError) {
        MSBApi.defaultFailureHandle(err)
    }
    
    open func reportError(error: MSBApiError) -> Bool { true }
    
}

/// 扩展moya 支持 array参数
struct JSONArrayEncoding: ParameterEncoding {
    static let `default` = JSONArrayEncoding()
    
    func encode(_ urlRequest: URLRequestConvertible, with parameters: Parameters?) throws -> URLRequest {
        
        var request = try urlRequest.asURLRequest()
        guard let json = parameters else { return request }
        let data = try JSONSerialization.data(withJSONObject: json, options: [])
        if request.value(forHTTPHeaderField: "Content-Type") == nil {
            request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        }
        request.httpBody = data
        return request
    }
}
