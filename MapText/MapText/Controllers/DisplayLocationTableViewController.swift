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
    
    @IBAction func unwindWithSegue(_ segue:UIStoryboardSegue) {
        if segue.identifier=="save" {
            print("saving edit")
        }
        else if segue.identifier=="cancel" {
            print("cancel edit")
        }
    }
    
    override func tableView(_ tableView:UITableView, numberOfRowsInSection section:Int)-> Int {
        return 10
    }
    
    override func tableView(_ tableView:UITableView, cellForRowAt indexPath: IndexPath)->UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "locationTableViewCell", for: indexPath) as! DisplayLocationTableViewCell
        cell.locationName?.text = "\(indexPath.row)"
        
        return cell
    }
}
