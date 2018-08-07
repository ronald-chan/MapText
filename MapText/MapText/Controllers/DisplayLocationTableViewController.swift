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
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier=segue.identifier else { return }
        switch identifier
        {
        case "modify":
            guard let indexPath=tableView.indexPathForSelectedRow else {return}
            let loc=NotificationLocation(loc:locs[indexPath.row])
            let destination=segue.destination as! EditLocationDetailsViewController
            destination.loc=loc
            destination.orig=locs[indexPath.row]
        case "add":
            let loc=NotificationLocation(lat:0, long:0, name:"")
            let destination=segue.destination as! EditLocationDetailsViewController
            destination.loc=loc
        default:
            print("unexpected segue identifier")
        }
    }
    @IBAction func unwindToHome(_ segue:UIStoryboardSegue) {
    }
    
    override func tableView(_ tableView:UITableView, numberOfRowsInSection section:Int)-> Int {
        return locs.count
    }
    
    override func tableView(_ tableView:UITableView, cellForRowAt indexPath: IndexPath)->UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "locationTableViewCell", for: indexPath) as! DisplayLocationTableViewCell
        let loc=locs[indexPath.row]
        cell.loc=loc
        cell.locationName.text = loc.name
        cell.locationCoordinates.text = "\(loc.city), \(loc.state)"
        cell.locationActive.setOn(loc.locationActive, animated: false)
        
        return cell
    }
    
    override func tableView(_ tableView:UITableView, commit editingStyle:UITableViewCellEditingStyle, forRowAt indexPath:IndexPath)
    {
        if editingStyle == .delete
        {
            let locToDelete=locs[indexPath.row]
            locs.remove(at: indexPath.row)
            LocationService.removeLocation(key: locToDelete.key!)
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        UserService.locs(for: User.current) { (locs) in
            self.locs = locs
            self.tableView.reloadData()
        }
    }
}
