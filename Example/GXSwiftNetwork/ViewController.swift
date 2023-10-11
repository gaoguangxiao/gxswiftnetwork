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

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //配置域名
        MSBApiConfig.shared.setApiConfig(apiHost: "http://gateway-test.risekid.cn", commonHeaders: [:], isAddDefaultHeaders: true)
    }

    
    @IBAction func 获取验证码(_ sender: Any) {
    
        let js = ["phone": "15737206055","type": 2].toJsonString
        if let _js = js {
            LoginApiService.requestCaptcha(param: _js) { obj in
                
//                print(obj?.msg ?? "")//                obj.msg
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
            print(vsModel?.data?.scope)
            print(vsModel?.data?.fileUrl)
        }
//        RSAudioApiService.share.requestVoiceScope(params: audioJSON) { vsModel in
//            print(vsModel?.code)
//            print(vsModel?.sdata?.fileUrl)
//            print(vsModel?.sdata?.scope)
//        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

