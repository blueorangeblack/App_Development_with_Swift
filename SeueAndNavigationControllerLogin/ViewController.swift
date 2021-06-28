//
//  ViewController.swift
//  SeueAndNavigationControllerLogin
//
//  Created by min on 2021/05/27.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tfUserName: UITextField!
    @IBOutlet weak var forgotUserNameButton: UIButton!
    @IBOutlet weak var forgotPasswordButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func forgotUserName(_ sender: Any) {
        performSegue(withIdentifier: "ForgotUserNameOrForgotPassword", sender: forgotUserNameButton)
    }
    
    @IBAction func forgotPassword(_ sender: Any) {
        performSegue(withIdentifier: "ForgotUserNameOrForgotPassword", sender: forgotPasswordButton)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let sender = sender as? UIButton else {return}
        if segue.identifier == "ForgotUserNameOrForgotPassword" {
            if sender == forgotUserNameButton {
                segue.destination.title = forgotPasswordButton.titleLabel?.text
                //segue.destination.title = "forgot Username" //강의 - 직접 타이틀 설정
            } else if sender == forgotPasswordButton {
                segue.destination.title = forgotPasswordButton.titleLabel?.text
                //segue.destination.title = "forgot Password" //강의
            }
        } else { //Login버튼 눌렀을 때
            segue.destination.title = tfUserName.text
        }
    }
}

