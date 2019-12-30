//
//  AppDelegate.swift
//  ChabokTest
//
//  Created by Parvin Mehrabani on 8/9/1396 AP.
//  Copyright © 1396 Chabok Realtime Solutions. All rights reserved.
//

import UIKit
import AdpPushClient
import CoreData
import AudioToolbox

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, PushClientManagerDelegate {

    var window: UIWindow?
    var manager = PushClientManager.default()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // Chabok initialization
        manager?.addDelegate(self) //Optional
        manager?.logLevel = ChabokLogLevelVerbose //Optional
        
        manager?.configureEnvironment(.Sandbox)
        
        return true
    }
    
    //MARK : Register User
    
    func pushClientManagerDidRegisterUser(_ registration: Bool) {
        print(registration)
    }
    
    func pushClientManagerDidFailRegisterUser(_ error: Error!) {
        print("It was not successful! Please try again")
    }
    
    //MARK : PushClientMessage

    func pushClientManagerDidReceivedMessage(_ message: PushClientMessage!) {
        // Called When PushClientManager has been received new message from server
        print("Got message \(String(describing: message.toDict()))")
    }
    
    //MARK : Push Notification

    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        print("‌User was tap on notification or click on action \(response.actionIdentifier)")
        
        completionHandler()
    }
    
    func pushClientManagerDidChangedServerConnectionState () {
        let connectionState : PushClientServerConnectionState = (self.manager?.connectionState)!
        
        switch (connectionState) {
        case .connectingStartState:
            print("Init")
        case .connectingState:
            print("Connecting")
        case .connectedState:
            print("Connected")
        case .disconnectedState:
            print("Disconnected")
        case .disconnectedErrorState:
            print("Error")
        default:
            print("Unknown")
        }
    }
}
