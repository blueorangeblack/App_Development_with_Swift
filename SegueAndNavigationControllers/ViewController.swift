//
//  ViewController.swift
//  SegueAndNavigationControllers
//
//  Created by min on 2021/05/27.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var segueSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func unwindToRed(_ unwindSegue: UIStoryboardSegue) {
        let sourceViewController = unwindSegue.source
        // Use data from the view controller which initiated the unwind segue
    }
 
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        segue.destination.navigationItem.title = textField.text
    }
    
    @IBAction func toPurple(_ sender: UIButton) {
        if segueSwitch.isOn {
            performSegue(withIdentifier: "Purple", sender: self) //sender는 nil넣어도 되고 self넣어도 됨
        }
    }
}


