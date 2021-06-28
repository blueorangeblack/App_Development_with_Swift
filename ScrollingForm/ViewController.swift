//
//  ViewController.swift
//  ScrollingForm
//
//  Created by min on 2021/06/02.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        registerForKeyboardNotifications()
    }

    func registerForKeyboardNotifications() {
        //Observer는 self (내가 감시함)
        //따로 보낼 object는 없으니까 nil
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWasShown(_:)), name: UIResponder.keyboardDidShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillBeHidden(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWasShown(_ notification:NSNotification) {
        //keyboard의 size를 알기위해
        //이벤트에 대한 userInfo를 가지고 오고,,,
        //keyboardFrame이 시작된 UserInfoKey를 받아옴...
        guard let info = notification.userInfo,
              let keyboardFrameValue = info[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue else { return }
        let keyboardFrame = keyboardFrameValue.cgRectValue
        let keyboardSize = keyboardFrame.size
        
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: keyboardSize.height, right: 0.0)
        
        scrollView.contentInset = contentInsets
        //scrollIndicator가 늘어난 Inset만큼 아래쪽에 더 있는 것처럼 표시되면 안되기 때문에,,
        //scrollIndicatorInsets도 변경해서 Indicator와 scroll이 차이나지 않도록하는 거래,,, 무슨 차이인지는 잘..ㅎㅎ
        // ====> 찾아보니까 Deprecated 됐다고 나옴
        scrollView.scrollIndicatorInsets = contentInsets
    }
    
    @objc func keyboardWillBeHidden(_ notification:NSNotification) {
        let contentInsets = UIEdgeInsets.zero
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
    }
}

