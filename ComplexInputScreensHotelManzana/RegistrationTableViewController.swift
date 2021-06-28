//
//  RegistrationTableViewController.swift
//  ComplexInputScreensHotelManzana
//
//  Created by Minju Lee on 2021/06/26.
//

import UIKit

class RegistrationTableViewController: UITableViewController {

    var registrations: [Registration] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func unwindFromAddRegistration (_ unwindSegue: UIStoryboardSegue) {
        guard let addRegistrationTableViewController = unwindSegue.source as? AddRegistrationTableViewController, let registration = addRegistrationTableViewController.registration else { return }
        registrations.append(registration)
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return registrations.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RegistrationCell", for: indexPath)

        let registration = registrations[indexPath.row]
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        
        cell.textLabel?.text = registration.firtsName + " " + registration.lastName
        cell.detailTextLabel?.text = dateFormatter.string(from: registration.checkInDate) + "-" + dateFormatter.string(from: registration.checkOutDate) + " : " + registration.rommType.name

        return cell
    }
}
