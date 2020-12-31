//
//  SuccessView.swift
//  FirebaseUISNSLogin
//
//  Created by yoshiiikoba on 2020/09/07.
//  Copyright © 2020 Kobayashi Yoshinori. All rights reserved.
//

import UIKit

class SuccessView: UIViewController {

    var uid:String
    var email:String
    var photoURL:URL!    
    
    @IBOutlet weak var userDiplay: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        userDiplay.text = uid   
        print("uid: \(uid)")
    
        // Do any additional setup after loading the view.
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder:aDecoder)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
