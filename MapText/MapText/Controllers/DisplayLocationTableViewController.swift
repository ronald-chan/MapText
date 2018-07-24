//
//  DisplayLocationTableView.swift
//  MapText
//
//  Created by Ronald Chan on 7/23/18.
//  Copyright © 2018 Ronald Chan. All rights reserved.
//

import Foundation
import UIKit
class DislayLocationTableViewController:UITableViewController {
    
    var locs=[NotificationLocation]() {
        didSet {
            tableView.reloadData()
        }
    }
    @IBAction func locationActiveSwitchFlipped(_ sender: Any) {
        //let cell=sender as! DisplayLocationTableViewCell
        //locs[cell.index!].locationActive=sender.
    
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier=segue.identifier else { return }
        switch identifier
        {
        case "modify":
            guard let indexPath=tableView.indexPathForSelectedRow else {return}
            let loc=locs[indexPath.row]
            let destination=segue.destination as! ModifyLocationViewController
            destination.loc=loc
            
            print()
        case "add":
            print()
        default:
            print("unexpected segue identifier")
        }
    }
    @IBAction func unwindWithSegue(_ segue:UIStoryboardSegue) {
        locs=CoreDataHelper.retrieveLocations()
    }
    
    override func tableView(_ tableView:UITableView, numberOfRowsInSection section:Int)-> Int {
        return locs.count
    }
    
    override func tableView(_ tableView:UITableView, cellForRowAt indexPath: IndexPath)->UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "locationTableViewCell", for: indexPath) as! DisplayLocationTableViewCell
        let loc=locs[indexPath.row]
        cell.locationName.text = loc.name
        cell.locationCoordinates.text = "\(loc.latitude)º N, \(loc.longitude)º W"
        cell.index=indexPath.row
        
        return cell
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        locs=CoreDataHelper.retrieveLocations()
    }
}
