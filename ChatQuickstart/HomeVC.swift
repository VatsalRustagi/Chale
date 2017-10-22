//
//  HomeVC.swift
//  Chale
//
//  Created by Vishnu on 10/21/17.
//  Copyright © 2017 Vishnu. All rights reserved.
//

import Foundation
import UIKit

class HomeVC: UIViewController, UITableViewDelegate, UITableViewDataSource, BackendDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    let backend = Backend()
    
    var Events: [EventModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        backend.delegate = self
        backend.getJSONData(from: "events/", withParams: [:])
        
//        Events.append(EventModel(eventName: "Boba Run", dateTime: "Oct 21 @ 6 PM", location: "Cha for Tea", description: "Craving some Mango Green Milk Tea and some of that crispy chicken. Anyone who just wants to chill are welcome :)"))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        Events = []
        backend.getJSONData(from: "events/", withParams: [:])
    }
    
    func processData(JSON: Dictionary<String, Any>) {
        if let result = JSON["result"] as? [Dictionary<String, Any>]{
            for event in result{
                let eventModal = EventModel()
                if let location = event["location"] as? String{
                    eventModal.location = location
                }
                if let datetime = event["datetime"] as? String{
                    eventModal.dateTime = datetime
                }
                if let title = event["title"] as? String{
                    eventModal.eventName = title
                }
                if let people = event["people"] as? [String]{
                    eventModal.people = people
                }
                
                Events.append(eventModal)
            }
        }
        
        tableView.alpha = 0.2
        tableView.reloadData()
        
        UIView.animate(withDuration: 0.2, animations: {
            self.tableView.alpha = 1.0
        })
        
    }
    
    // TableView Functions
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "homeCell", for: indexPath) as? HomeCell {
            cell.updateUI(homeCell: Events[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Events.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 175
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "getInfo", sender: Events[indexPath.row])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dest = segue.destination as? MoreInfoVC {
            if let item = sender as? EventModel {
                dest.eventInfo = item
            }
        }
    }
    ///
    
    @IBAction func addEvent(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "makeEvent", sender: nil)
    }
    
    @IBAction func refreshEvents(_ sender: UIBarButtonItem) {
        Events = []
        backend.getJSONData(from: "events/", withParams: [:])
    }
    
    
}


class HomeCell: UITableViewCell {
    
    @IBOutlet weak var planName: UILabel!
    @IBOutlet weak var dateTime: UILabel!
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var numPeople: UILabel!
    
    func updateUI(homeCell: EventModel) {
        planName.text = homeCell.eventName
        dateTime.text = homeCell.dateTime
        location.text = homeCell.location
        numPeople.text = "\(homeCell.people.count) are down!"
    }
    
}
