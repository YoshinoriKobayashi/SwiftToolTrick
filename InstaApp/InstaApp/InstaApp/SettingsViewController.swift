//
//  SettingsViewController.swift
//  InstaApp
//
//  Created by yoshiiikoba on 2020/09/27.
//  Copyright © 2020 Kobayashi Yoshinori. All rights reserved.
//

import UIKit
import Firebase

class SettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func logoutClicked(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            self.performSegue(withIdentifier: "toViewController", sender: nil)
        } catch {
            print("error")
        }
    }


}
