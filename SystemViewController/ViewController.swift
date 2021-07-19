//
//  ViewController.swift
//  SystemViewController
//
//  Created by Minju Lee on 2021/07/19.
//

import UIKit
import SafariServices
import MessageUI

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, MFMailComposeViewControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

//    ActivityViewController는 공유를 위한 뷰 컨트롤러
//    사진이나 콘텐츠 (문자열, pdf 등)
//    UIActivityViewController(activityItems: [Any], applicationActivities: [UIActivity]?)
//    UIActivity instance를 만들고 매개변수로 Any 타입의 activityItems array를 넘겨줌
//    applicationActivities라는 매개변수도 넘기는데, 이건 custom서비스를 위한 것
//    예를 들어 소셜미디어에 사용자의 계정을 받아서 바로 포스팅해야 할 때 UIActivity를 subclass해서 함
    @IBAction func shareButtonTapped(_ sender: UIButton) {
        guard let image = imageView.image else { return }
        let activityController = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        //이 코드는 아이패드에서만 실행됨 (popover의 화살표 시작점이 어디냐를 나타내는 것)
        activityController.popoverPresentationController?.sourceView = sender
        present(activityController, animated: true, completion: nil)
    }
    
    //SFSafariViewController 이 앱을 벗어나지않고 잠깐 사파리를 보여주기 위한 컨트롤러
    //주소를 입력해놓은 상태라서 읽기 전용
    //3D Touch가 가능함. peek and pop 기능
    //import SafariServices 해야 함
    //Safari View Controller를 만들어서 쓰기 위해서 해야 할 것
    //1)문자열로 부터 URL을 만들어야 함
    //2)SFSafariViewController를 만들어서 그 URL을 넘겨주어야 함
    //3)SafariViewContoller를 사용자에게 present함
    @IBAction func safariButtonTapped(_ sender: UIButton) {
        if let url = URL(string: "https://apple.com") {
            let safariViewController = SFSafariViewController(url: url)
            present(safariViewController, animated: true, completion: nil)
        }
    }
    
    //사용자의 camera나 photo library에 접근하려면 UIImagePickerController를 사용해야 하는데
    //두 가지 프로토콜을 준수해야 함
    //UIImagePickerControllerDelegate(선택한 이미지의 정보를 앱으로 다시 전송하기 위한 것),
    //UINavigationControllerDelegate(ImagePickerView를 닫기 위한 것)
    @IBAction func cameraButtonTapped(_ sender: UIButton) {
        let alertController = UIAlertController(title: "Choose Image Source", message: nil, preferredStyle: .actionSheet)
        
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        //카메라가 가능한 디바이스에서만 나오도록 함
        //카메라 사용이 가능하다면 (시뮬레이터에서는 카메라가 안되기때문에 이 코드를 안넣으면 크래쉬날 수 있어서 씀)
        //카메라 액션 버튼이 나오도록
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let cameraAction = UIAlertAction(title: "Camera", style: .default) { action in
                imagePicker.sourceType = .camera
                self.present(imagePicker, animated: true, completion: nil)
            }
            alertController.addAction(cameraAction)
        }
        
        //photoLibrary 사용이 가능하다면
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let photoLibraryAction = UIAlertAction(title: "PhotoLibrary", style: .default) { action in
                imagePicker.sourceType = .photoLibrary
                self.present(imagePicker, animated: true, completion: nil)
            }
            alertController.addAction(photoLibraryAction)
        }
        
        //popover는 아이패드만 해당
        alertController.popoverPresentationController?.sourceView = sender
        present(alertController, animated: true, completion: nil)
    }
    
    //info Dictionary에는 UIImagePickerController.InfoKey에 해당하는 여러 값들이 있는데
    //그 중에서 .originalImage로 가지고 옴
    //그리고 이 originalImage는 UIImage타입이 아닐거라서 UIImage로 타입 캐스팅해주어야 함
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[.originalImage] as? UIImage else { return }
        imageView.image = selectedImage
        dismiss(animated: true, completion: nil)
    }
    
    //import MessageUI 해야 함
    //canSendMail()로 메일을 보낼 수 있는 상황인지 먼저 확인
    //못보내는 상황은 예를 들면 사용자의 계정이 아직 설정되어있지 않은 상황
    //mailComposeDelegate
    //message body가 HTML인지 아닌지를 확인해서 일반 텍스트로 보낼지, HTML로 보낼지 결정하게 됨
    @IBAction func emailButtonTapped(_ sender: UIButton) {
        if !MFMailComposeViewController.canSendMail() {
            print("Can't send mail")
            return
        }
        
        let mailComposer = MFMailComposeViewController()
        mailComposer.delegate = self
        
        mailComposer.setToRecipients(["TimCook@apple.com"])
        mailComposer.setSubject("Good News")
        mailComposer.setMessageBody("Hi Tim", isHTML: false)
        
        present(mailComposer, animated: true, completion: nil)
    }
    
    //메일이 보내졌을 때 Delegate 메소드
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        dismiss(animated: true, completion: nil) //(+근데 안사라짐.. 뭔가 문제있음)
    }
}
