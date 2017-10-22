//
//  MoreInfoVC.swift
//  Chale
//
//  Created by Vishnu on 10/21/17.
//  Copyright © 2017 Vishnu. All rights reserved.
//

import Foundation
import UIKit

class MoreInfoVC: UIViewController, BackendDelegate {
    
    @IBOutlet weak var navItem: UINavigationItem!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var placeLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UITextView!
    @IBOutlet weak var chatjoinBtn: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    var eventInfo: EventModel!
    let backend = Backend()
    let pink = UIColor(red: 1.00, green: 0.25, blue: 0.40, alpha: 1.00)
    let green = UIColor(red: 0.00, green: 0.50, blue: 0.00, alpha: 1.00)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backend.delegate = self
        updateUI()
    }
    
    func updateUI() {
        if eventInfo.people.contains(userName){
            chatjoinBtn.backgroundColor = pink
            chatjoinBtn.setTitle("Chat", for: .normal)
        }
        
        navigationItem.title = eventInfo.eventName
        dateLabel.text = eventInfo.dateTime
        placeLabel.text = eventInfo.location
        descriptionLabel.text = eventInfo.description
        
        dateLabel.layer.borderColor = pink.cgColor
        dateLabel.layer.borderWidth = 1
        
        placeLabel.layer.borderColor = pink.cgColor
        placeLabel.layer.borderWidth = 1
        
        descriptionLabel.layer.borderColor = pink.cgColor
        descriptionLabel.layer.borderWidth = 1
    }
    
    @IBAction func chatPressed(_ sender: UIButton) {
        if sender.titleLabel?.text == "Join" {
            backend.postJSONData(to: "join_event/", withParams: ["user_name": userName, "event_title": eventInfo.eventName])
        }
        else {
            performSegue(withIdentifier: "goToChat", sender: nil)
        }
    }
    
    func processData(JSON: Dictionary<String, Any>) {
        eventInfo.people.append(userName)
        tableView.reloadData()
        UIView.animate(withDuration: 0.3, animations: {
            self.chatjoinBtn.backgroundColor = self.pink
            self.chatjoinBtn.setTitle("Chat", for: .normal)
        })
    }
}

extension MoreInfoVC: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "peopleCell", for: indexPath)
        cell.textLabel?.text = eventInfo.people[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventInfo.people.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}
