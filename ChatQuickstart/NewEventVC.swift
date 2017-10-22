//
//  NewEventVC.swift
//  ChatQuickstart
//
//  Created by Vatsal Rustagi on 10/21/17.
//  Copyright © 2017 Twilio, Inc. All rights reserved.
//

import UIKit

class NewEventVC: UIViewController, UITextViewDelegate {

    @IBOutlet weak var eventTitleTF: UITextField!
    @IBOutlet weak var locationTF: UITextField!
    @IBOutlet weak var datePickerView: UIDatePicker!
    @IBOutlet weak var descriptionTV: UITextView!
    
    @IBAction func cancelBtn(_ sender: UIBarButtonItem) {
        _ = navigationController?.popViewController(animated: true)
    }
    
    @IBAction func doneBtn(_ sender: UIBarButtonItem) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd @ hh:mm a"
        
        let event = EventModel(eventName: eventTitleTF.text!, dateTime: dateFormatter.string(from: datePickerView.date), location: locationTF.text!, description: descriptionTV.text)
        Events.append(event)
        _ = navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        descriptionTV.delegate = self
        
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if descriptionTV.textColor == UIColor.lightGray {
            descriptionTV.textColor = UIColor.black
            descriptionTV.text = ""
        }
    }
    
    func setupTextView() {
        descriptionTV.layer.borderColor = UIColor.lightGray.cgColor
        descriptionTV.layer.borderWidth = 1
        descriptionTV.text = "Description of the event"
        descriptionTV.textColor = UIColor.lightGray
    }
}
