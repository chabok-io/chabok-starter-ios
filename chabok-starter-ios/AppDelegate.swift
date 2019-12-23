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
import Firebase
import OneSignal
import Parse

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, PushClientManagerDelegate {

    var window: UIWindow?
    let manager = PushClientManager.default()
    let onesignalInitSettings = [kOSSettingsKeyAutoPrompt: false]

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Chabok initialization
        manager?.addDelegate(self) //Optional
        manager?.logLevel = ChabokLogLevelVerbose //Optional
        manager?.configureEnvironment(.Sandbox)
        
        // Firebase initialization
        FirebaseApp.configure()
        
        // OneSignal initialization
        OneSignal.initWithLaunchOptions(launchOptions,
                                        appId: "9bebc848-343f-47b9-878a-97372c0bb2d1",
                                        handleNotificationAction: nil,
                                        settings: onesignalInitSettings)
        OneSignal.inFocusDisplayType = OSNotificationDisplayType.notification;
        OneSignal.promptForPushNotifications(userResponse: { accepted in
            print("User accepted notifications: \(accepted)")
        })
        
        // Parse initialization
        let configuration = ParseClientConfiguration {
            $0.applicationId = "qy8KAy39wq1j4WaZ8UgTRGN0jsp59bUvUAF7dz0a"
            $0.clientKey = "Dkpj7oQHDwDqAeil9p5YL1jQ8sRY0IG3MBBURms3"
            $0.server = "https://parseapi.back4app.com"
        }
        Parse.initialize(with: configuration)
        saveInstallationObject()
        
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
    
    func saveInstallationObject() {
        if let installation = PFInstallation.current() {
            installation.saveInBackground {
                (success: Bool, error: Error?) in
                if (success) {
                    print("You have successfully connected your app to Back4App!")
                } else {
                    if let myError = error {
                        print(myError.localizedDescription)
                    } else {
                        print("Uknown error")
                    }
                }
            }
        }
    }
}
