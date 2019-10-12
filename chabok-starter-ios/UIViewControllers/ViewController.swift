//
//  ViewController.swift
//  ChabokTest
//
//  Created by Parvin Mehrabani on 8/9/1396 AP.
//  Copyright © 1396 Chabok Realtime Solutions. All rights reserved.
//

import UIKit
import AdpPushClient

class ViewController: UIViewController {

    @IBOutlet weak var connectionLabel: UILabel!
    @IBOutlet weak var connectionImage: UIImageView!
    
    var image = UIImage()
    var manager = PushClientManager.default()

    override func viewDidLoad() {
        super.viewDidLoad()

        // online or offline observer
        NotificationCenter.default.addObserver(self, selector: #selector(self.pushClientServerConnectionStateHandler), name: NSNotification.Name.pushClientDidChangeServerConnectionState, object: nil)
        NotificationCenter.default.post(name: NSNotification.Name.pushClientDidChangeServerConnectionState, object: nil)
    }

    @objc func pushClientServerConnectionStateHandler(_ notification: Notification) {
        if manager?.connectionState == .connectedState {
            image = UIImage(named: "online")!
            connectionLabel.text = "آنلاین"
        } else if manager?.connectionState == .disconnectedState || manager?.connectionState == .disconnectedErrorState {
            image = UIImage(named: "offline")!
            connectionLabel.text = "آفلاین"
        }
        connectionImage.image = image
    }
}

