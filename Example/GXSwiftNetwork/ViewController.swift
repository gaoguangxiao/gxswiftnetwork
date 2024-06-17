//
//  ViewController.swift
//  GXSwiftNetwork
//
//  Created by 小修 on 10/09/2023.
//  Copyright (c) 2023 小修. All rights reserved.
//

import UIKit
import GXSwiftNetwork
import GGXSwiftExtension
class ViewController: UIViewController {
    
    /// 请求时间label
    @IBOutlet weak var netRequestLab: UILabel!
    var netRequestTimer: Timer?
    var netRequestCount: CGFloat = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //配置域名
//        MSBApiConfig.shared.setApiConfig(apiHost: "https://gateway-test.risekid.cn", commonHeaders: [:], isAddDefaultHeaders: true)
        
//    https://gw.risekid.cn/wap/api/config/ios
        MSBApiConfig.shared.setApiConfig(apiHost: "https://gateway-test.risekid.cn", commonHeaders: [:], isAddDefaultHeaders: true)
    }
    
    
    @IBAction func 获取验证码(_ sender: Any) {
        
        let js = ["phone": "15737206055","type": 2].toJsonString
        
        self.startTimer()
        
        if let _js = js {
            LoginApiService.VerificationCode(param: _js) { obj in
                print(obj?.msg ?? "")//                obj.msg
                self.endTimer()
                
                print("请求时间")
            }
        }
    }
    
    @IBAction func 获取音频打分(_ sender: Any) {
        
        let filePath = Bundle.main.path(forResource: "20230919093347", ofType: "wav") ?? ""
        
        let operateList = ["scope","oss"]
        let text = "I am Herry"
        let path = "/audiotest/110"
        let resultType = "0"
        
        var dict : [String : Any] = ["operateList":operateList,
                                     "path":path,
                                     "resultType":resultType,
                                     "text":text]
        
        let data = filePath.toFileUrl?.base64FileData
        dict["voiceData"] = data
        let audioJSON = dict.toJsonString ?? ""
        AudioApiService.share.requestVoiceScope(params: audioJSON) { vsModel in
//            print(vsModel?.data?.scope)
//            print(vsModel?.data?.fileUrl)
        }
        //        RSAudioApiService.share.requestVoiceScope(params: audioJSON) { vsModel in
        //            print(vsModel?.code)
        //            print(vsModel?.sdata?.fileUrl)
        //            print(vsModel?.sdata?.scope)
        //        }
    }
    
    @IBAction func 代发请求(_ sender: Any) {
        let url = "https://qa.risekid.cn/buddy/mojing.json"
        
        //图片
        //        let api = MSBApi(url: url,
        //                         path: "",
        //                         method: .get)
        //        api.request { result in
        //            print(result)
        //        } onFailure: { error in
        //            print(error)
        //        }
    }
    
    @IBAction func 配置(_ sender: Any) {
        
        let api = ConfigApi.LaunchApi(paras: [:])
        api.request { (result: RSConfigiOSBaseModel?) in
            print("success: \(result?.success)")
            print("data: \(result?.ydata)")
        } onFailure: { _ in

        }
        
//        let api = MSBApi(path: "/wap/api/config/ios",timeout: 5.0)
//        self.startTimer()
//        api.request { result in
//            print("success: \(result.success)")
//            print("data: \(result.data)")
//            self.endTimer()
//        } onFailure: { error in
//            print(error)
//            self.endTimer()
//        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension ViewController {
    
    func startTimer() {
        
        self.netRequestCount = 0.0
        
        netRequestTimer = Timer.scheduledTimer(withTimeInterval:0.01, repeats: true) { [weak self]t in
            guard let self = self else { return }
            self.netRequestCount += 0.01
            
            self.netRequestLab.text = "请求时间: \(self.netRequestCount)"
        }
        
    }
    
    
    
    func endTimer() {
        //
        netRequestTimer?.invalidate()
        netRequestTimer = nil
        
    }
}
