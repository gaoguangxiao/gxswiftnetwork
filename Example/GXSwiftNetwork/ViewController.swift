//
//  ViewController.swift
//  GXSwiftNetwork
//
//  Created by 小修 on 10/09/2023.
//  Copyright (c) 2023 小修. All rights reserved.
//

import UIKit
import GXSwiftNetwork

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //配置域名
        MSBApiConfig.shared.setApiConfig(apiHost: "http://gateway-test.risekid.cn", commonHeaders: [:], isAddDefaultHeaders: false)
    }

    
    @IBAction func 获取验证码(_ sender: Any) {
        GXLoginViewModel.VerificationCode(param: ["phone":"15737206055",
                                                  "type":2],
                                          "/user/api/verification-code", MSBBaseIntModel.self) { obj in
            
            
        }
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

