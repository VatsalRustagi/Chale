//
//  MainVC.swift
//  ChatQuickstart
//
//  Created by Vatsal Rustagi on 10/21/17.
//  Copyright © 2017 Twilio, Inc. All rights reserved.
//

import UIKit

var userName = ""
var Events: [EventModel] = []

class MainVC: UIViewController {

    @IBOutlet weak var enterButton: UIButton!
    @IBOutlet weak var userTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func pressedEnter(_ sender: UIButton) {
        userName = userTextField.text!
        performSegue(withIdentifier: "goToHome", sender: nil)
    }

}
