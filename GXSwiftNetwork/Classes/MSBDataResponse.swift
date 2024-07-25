//
//  MSBDataResponse.swift
//  GXSwiftNetwork
//
//  Created by 高广校 on 2024/7/24.
//

import Foundation

@available(iOS 13.0.0, *)
public protocol MSBDataResponse {
 
    //要解析的`Model`
    associatedtype Model
    
    //调用方对每个接口做出响应，抛出错误
    static func response() async throws -> Model
}
