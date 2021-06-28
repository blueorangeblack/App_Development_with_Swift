//
//  ViewController.swift
//  ControlsInAction
//
//  Created by min on 2021/05/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var toggle: UISwitch!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //target은 저 버튼이 눌러졌을 때 실행할 함수가 있는 오브젝트(self)
        button.addTarget(self, action: #selector(buttonTapped(_:)), for: UIControl.Event.touchUpInside)
        //self가 가지고 있는 buttonTapped라는 함수를 touchUpInside이벤트에 연결
    }

    //스토리보드 이벤트 연결안되어있음
    //!!!! @objc가 아니어도 @IBAction도 #selector에서 불러올 수 있다!!!!
    @IBAction func buttonTapped(_ sender: Any) {
        //print("Button was tapped!!")
        if toggle.isOn {
            print ("Switch On!")
        } else {
            print("Switch Off!")
        }
        print(slider.value)
    }
    
    //Value Changed 이벤트
    @IBAction func switchToggled(_ sender: UISwitch) {
        if sender.isOn {
            print ("Switch is On!")
        } else {
            print("Switch is Off!")
        }
    }
    
    //Primary Action Triggered가장 흔히 쓰이는, 가장 중요한 액션과 함수를 연결하는 것
    @IBAction func keboardReturnKeyTapped(_ sender: UITextField) {
        if let text = sender.text {
            print(text)
        }
        //리턴키누르면 FirstResponder해제되어 키보드 내려감
        sender.resignFirstResponder()
    }

    //Editing Changed 이벤트
    @IBAction func textChanged(_ sender: UITextField) {
        if let text = sender.text {
            print(text)
        }
    }
    
    //Value Changed 이벤트
    @IBAction func sliderValueChanged(_ sender: UISlider) {
        print(sender.value)
    }
    
    @IBAction func tapGesture(_ sender: UITapGestureRecognizer) {
        let location = sender.location(in: view)
        print(location)
    }
}


