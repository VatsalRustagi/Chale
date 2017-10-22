//
//  MoreInfoVC.swift
//  Chale
//
//  Created by Vishnu on 10/21/17.
//  Copyright © 2017 Vishnu. All rights reserved.
//

import Foundation
import UIKit

class MoreInfoVC: UIViewController {
    
    @IBOutlet weak var navItem: UINavigationItem!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var placeLabel: UILabel!
    
    let peopleList = ["Disha","Vishnu","Vatsal","James","Aaron","Hodor","Jay","Anshul"]
    
    var eventInfo: EventModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    func updateUI() {
        navigationItem.title = eventInfo.eventName
        dateLabel.text = eventInfo.dateTime
        placeLabel.text = eventInfo.location
        
        dateLabel.layer.borderColor = UIColor(red: 1.00, green: 0.25, blue: 0.40, alpha: 1.00).cgColor
        dateLabel.layer.borderWidth = 1
        
        placeLabel.layer.borderColor = UIColor(red: 1.00, green: 0.25, blue: 0.40, alpha: 1.00).cgColor
        placeLabel.layer.borderWidth = 1
    }
    
    @IBAction func chatPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "goToChat", sender: nil)
    }
}

extension MoreInfoVC: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "peopleCell", for: indexPath)
        cell.textLabel?.text = peopleList[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if eventInfo.people < peopleList.count{
            return eventInfo.people
        }
        return peopleList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}
