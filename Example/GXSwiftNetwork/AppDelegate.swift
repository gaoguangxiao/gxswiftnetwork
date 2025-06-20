//
//  AppDelegate.swift
//  GXSwiftNetwork
//
//  Created by 小修 on 10/09/2023.
//  Copyright (c) 2023 小修. All rights reserved.
//

import UIKit
import SwiftUI
import GXSwiftNetwork

//@available(iOS 14.0, *)
//@main
//struct Lan: App {
//    var body: some Scene {
//        
//        WindowGroup {
//            SwiftUINetErrorView()
//                .onAppear(perform: {
//                    MSBApiConfig.shared.setApiConfig(apiHost: "https://gateway-test.risekid.cn", commonHeaders: ["token":"Bearer eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiIxIiwidXVpZCI6Ilc5dUNxQmtHIn0.i3k36fWdPvxlQbb2_ZjHRb61x1zlD10tjDJr8zy7DR0MU10EFNc-AIVs2hWfimYwF_mhXFDJxiVYBPn-lJIpCA"], isAddDefaultHeaders: true)
//                    
//                })
//        }
//    }
//}


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
//        let homepageVc = ViewController()
        let homepageVc = UIHostingController(rootView: WordSwiftUIView())
        let nav = UINavigationController(rootViewController: homepageVc)
        self.window?.rootViewController = nav
        self.window?.makeKeyAndVisible()
        
        initConfig()
        
        return true
    }

    func initConfig(){
                var header: [String: String] = [:]
                header["device"] = "app"
                header["os-type"] = "ios"
//                header["version"] = "\(kAppVersion ?? "1.0")"//1.6.3
                header["device-model"] = UIDevice.modelName
                if (UIDevice.isIPad) {
                    header["device-type"] = "iPad"
                }else {
                    header["device-type"] = "iPhone"
                }
//               /* header["token"] = "Bearer eyJhbGciO*/iJIUzUxMiJ9.eyJzdWIiOiIxIiwidXVpZCI6IjRVektyQ29nIn0.sI4QxF8k0IN4ByjHYGPv8D0-iCfUBAMTsg1KC9GvWwxPjvtQETgBcMX95vTMWyxxUPcac1F2nSKJZrG3DwmF5w"
                MSBApiConfig.shared.setApiConfig(apiHost: "https://gateway-test.risekid.cn",
                                                 commonHeaders: header,
                                                 isAddDefaultHeaders: true)
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

