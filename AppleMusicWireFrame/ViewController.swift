//
//  ViewController.swift
//  AppleMusicWireFrame
//
//  Created by Minju Lee on 2021/06/28.
//

import UIKit

class ViewController: UIViewController {
    
    //버튼의 이미지를 default, selected로 나눠서 하는 것도 좋은 방법
    var isPlaying: Bool = false { //강좌에서는 처음에 true로 값을 주는데 처음에 false인 게 나을 거 같음
        didSet {
            if isPlaying{
                playPauseButton.setImage(UIImage(named: "pause")!, for: .normal)
            } else {
                playPauseButton.setImage(UIImage(named: "play")!, for: .normal)
            }
        }
    }
    
    @IBOutlet weak var albumImageView: UIImageView!
    @IBOutlet weak var reverseBackground: UIView!
    @IBOutlet weak var playPauseBackground: UIView!
    @IBOutlet weak var forwardBackground: UIView!
    @IBOutlet weak var reverseButton: UIButton!
    @IBOutlet weak var playPauseButton: UIButton!
    @IBOutlet weak var forwardButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //강좌에는 없는데 처음에 isPlaying이 false이니까 이미지를 작게 하는 게 좋을 거 같음
        albumImageView.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        
        reverseBackground.layer.cornerRadius = 35.0
        reverseBackground.clipsToBounds = true // true여도, false여도, 주석처리해도 결과가 다 같은데,,, 뭐지
        reverseBackground.alpha = 0.0 // 투명
        
        playPauseBackground.layer.cornerRadius = 35.0
        playPauseBackground.clipsToBounds = true
        playPauseBackground.alpha = 0.0
        
        forwardBackground.layer.cornerRadius = 35.0
        forwardBackground.clipsToBounds = true
        forwardBackground.alpha = 0.0
    }

    @IBAction func playPauseButtonTapped(_ sender: Any) {
        if isPlaying {
            UIView.animate(withDuration: 0.5) {
                self.albumImageView.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            }
        } else {
            UIView.animate(withDuration: 0.5) {
                self.albumImageView.transform = CGAffineTransform.identity
            }
        }
        isPlaying.toggle() //toggle은 Boolean이 가지고 있는 함수
    }
    
    // 딱 터치되는 순간
    @IBAction func touchedDown(_ sender: UIButton) {
        let buttonBackground: UIView //let으로 선언하고 딱한번 바꿀 수 있음 (예외적인 상황)
        
        //이렇게 하는 것보다 enum으로 하는 게 더 좋을 것 같다고
        switch sender {
        case reverseButton:
            buttonBackground = reverseBackground
        case playPauseButton:
            buttonBackground = playPauseBackground
        case forwardButton:
            buttonBackground = forwardBackground
        default:
            return
        }
        UIView.animate(withDuration: 0.25) {
            buttonBackground.alpha = 0.3
            sender.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        }
    }
    
    @IBAction func touchedUpInside(_ sender: UIButton) {
        var buttonBackground: UIView
        
        switch sender {
        case reverseButton:
            buttonBackground = reverseBackground
        case playPauseButton:
            buttonBackground = playPauseBackground
        case forwardButton:
            buttonBackground = forwardBackground
        default:
            return
        }
        UIView.animate(withDuration: 0.25, animations: {
            buttonBackground.alpha = 0.0
            buttonBackground.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
            sender.transform = CGAffineTransform.identity
        }) {(_) in
            buttonBackground.transform = CGAffineTransform.identity
        }
    }
}
