//
//  EditLocationDetailsViewController.swift
//  MapText
//
//  Created by Ronald Chan on 8/1/18.
//  Copyright © 2018 Ronald Chan. All rights reserved.
//

import Foundation
import UIKit
class EditLocationDetailsViewController:UIViewController {
    
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var notesTextView: UITextView!
    var loc:NotificationLocation?
    var orig:NotificationLocation?
    override func viewWillAppear(_ animated: Bool) {
        if let loc=loc {
            notesTextView.layer.cornerRadius=8
            locationTextField.text=loc.name
            notesTextView.text=loc.notes
            locationTextField.autocapitalizationType=UITextAutocapitalizationType.words
            locationTextField.becomeFirstResponder()
            
            notesTextView.autocapitalizationType=UITextAutocapitalizationType.sentences
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier=="toLocation" {
            if let loc=loc {
                loc.name=locationTextField.text ?? ""
                loc.notes=notesTextView.text ?? ""
            }
            let destination=segue.destination as! EditLocationViewController
            destination.loc=loc
            destination.orig=orig
        }
    }
    @IBAction func unwindWithSegue(_ segue:UIStoryboardSegue) {
    }
}
