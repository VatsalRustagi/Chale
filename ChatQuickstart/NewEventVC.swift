//
//  NewEventVC.swift
//  ChatQuickstart
//
//  Created by Vatsal Rustagi on 10/21/17.
//  Copyright © 2017 Twilio, Inc. All rights reserved.
//

import UIKit

class NewEventVC: UIViewController, UITextViewDelegate, BackendDelegate {

    @IBOutlet weak var eventTitleTF: UITextField!
    @IBOutlet weak var locationTF: UITextField!
    @IBOutlet weak var datePickerView: UIDatePicker!
    @IBOutlet weak var descriptionTV: UITextView!
    
    let backend = Backend()
    
    @IBAction func cancelBtn(_ sender: UIBarButtonItem) {
        _ = navigationController?.popViewController(animated: true)
    }
    
    @IBAction func doneBtn(_ sender: UIBarButtonItem) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd @ hh:mm a"
        
        let event = EventModel(eventName: eventTitleTF.text!, dateTime: dateFormatter.string(from: datePickerView.date), location: locationTF.text!, description: descriptionTV.text)
        
        let params : [String: Any] = [
            "title" : event.eventName,
            "location" : event.location,
            "datetime" : event.dateTime,
            "people" : [userName]
        ]
        backend.postJSONData(to: "add_event/", withParams: params)
    }
    
    func processData(JSON: Dictionary<String, Any>) {
        _ = navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        descriptionTV.delegate = self
        backend.delegate = self
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
