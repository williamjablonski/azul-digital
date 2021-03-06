//
//  SettingsTableViewController.swift
//  Azul Digital
//
//  Created by Leonardo Tsuda on 7/25/16.
//  Copyright © 2016 Leonardo Tsuda. All rights reserved.
//

import UIKit
import FirebaseAuth

class SettingsTableViewController: UITableViewController {
    
    @IBAction func cancelModification(withSegue segue: UIStoryboardSegue) {
        
    }
    @IBOutlet weak var profileLabel: UILabel!
    @IBOutlet weak var carLabel: UILabel!
    @IBOutlet weak var cardLabel: UILabel!
    @IBOutlet weak var historyLabel: UILabel!
    @IBOutlet weak var aboutLabel: UILabel!
    
    var userID = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        title = Project.Localizable.Common.settings.localized
        navigationController?.navigationBar.barTintColor = UIColor(red: 15/255, green: 127/255, blue: 223/255, alpha: 1)
        guard let current = FIRAuth.auth()?.currentUser else { return }
        userID = current.uid
        profileLabel.text = Project.Localizable.Common.profile_title.localized
        carLabel.text = Project.Localizable.Common.car.localized
        cardLabel.text = Project.Localizable.Common.card.localized
        historyLabel.text = Project.Localizable.Common.history.localized
        aboutLabel.text = Project.Localizable.Common.about.localized
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "CardEditSegue" {
            guard let destination = segue.destination as? CardEditViewController else { return print("failed CardEditViewController")}
            destination.id = userID
        } else if segue.identifier == "CarEditSegue" {
            guard let destination = segue.destination as? CarEditViewController else { return print("failed CarEditViewController")}
            destination.id = userID
        } else if segue.identifier == "ProfileEditSegue" {
            guard let destination = segue.destination as? ProfileEditViewController else { return print("failed ProfileEditViewController")}
            destination.id = userID
        } else if segue.identifier == "HistorySegue" {
            guard let destination = segue.destination as? HistoryTableViewController else { return print("failed HistoryTableViewController")}
            destination.id = userID
        }
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
