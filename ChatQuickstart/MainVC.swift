//
//  MainVC.swift
//  ChatQuickstart
//
//  Created by Vatsal Rustagi on 10/21/17.
//  Copyright © 2017 Twilio, Inc. All rights reserved.
//

import UIKit

var userName = ""

class MainVC: UIViewController, BackendDelegate {

    @IBOutlet weak var enterButton: UIButton!
    @IBOutlet weak var userTextField: UITextField!
    
    let backend = Backend()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backend.delegate = self
        
    }
    
    @IBAction func pressedEnter(_ sender: UIButton) {
        userName = userTextField.text!
        backend.postJSONData(to: "add_user/", withParams: ["username": userName])
    }
    
    func processData(JSON: Dictionary<String, Any>) {
        performSegue(withIdentifier: "goToHome", sender: nil)
    }

}
