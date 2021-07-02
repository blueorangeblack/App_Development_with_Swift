//
//  ViewController.swift
//  SpacePhoto
//
//  Created by Minju Lee on 2021/07/02.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var copyrightLabel: UILabel!
    
    let photoInfoController = PhotoInfoController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        descriptionLabel.text = ""
        copyrightLabel.text = ""
        
        //deprecated in iOS 13.0
        //UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        photoInfoController.fetchPhotoInfo { (photoInfo) in
            guard let photoInfo = photoInfo else { return }
            self.updateUI(with: photoInfo)
        }
    }

    func updateUI(with photoInfo: PhotoInfo) {
        //guard let url = photoInfo.url.withHTTPS() else { return }
        let task = URLSession.shared.dataTask(with: photoInfo.url) {
            (data, response, error) in
            guard let data = data,
                  let image = UIImage(data: data) else { return }
            DispatchQueue.main.async {
                self.title = photoInfo.title
                self.imageView.image = image
                self.descriptionLabel.text = photoInfo.descriptrion
                if let copyright = photoInfo.copyright {
                    self.copyrightLabel.text = "Copyright: \(copyright)"
                } else {
                    self.copyrightLabel.isHidden = true
                }
                //deprecated in iOS 13.0
                //UIApplication.shared.isNetworkActivityIndicatorVisible = false
            }
        }
        task.resume()
    }
}
