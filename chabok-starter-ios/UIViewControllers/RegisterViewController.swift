//
//  RegisterViewController.swift
//  ChabokTest
//
//  Created by Parvin Mehrabani on 8/10/1396 AP.
//  Copyright © 1396 Chabok Realtime Solutions. All rights reserved.
//

import UIKit
import AdpPushClient

class RegisterViewController: UIViewController {

    @IBOutlet weak var UserIdTextField: UITextField!
    var manager = PushClientManager.default()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func registerBtnClick(_ sender: UIButton) {
        let userId: String = UserIdTextField.text!
        
        if userId.trimmingCharacters(in: .whitespaces).count == 0 {
            self.showErrorAlert(message: "Please, enter the user id.")
            return
        }
        
        let weakSelf = self
        
        self.manager?.login(userId, handler: { (isRegistered, error) in
            if (isRegistered && error == nil) {
                print("Registered : \(String(describing: userId)) with installationId : \(String(describing: weakSelf.manager?.getInstallationId()))")
                if let starterVC = weakSelf.storyboard?.instantiateViewController(withIdentifier: "starterUIVCID") {
                    weakSelf.present(starterVC, animated: true, completion: nil)
                }
            } else {
                let errorMsg = "Not registered, Error : \(String(describing: error))"
                print(errorMsg)
                weakSelf.showErrorAlert(message: errorMsg)
            }
        })
    }
}
