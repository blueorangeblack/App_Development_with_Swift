//
//  PhotoInfoController.swift
//  SpacePhoto
//
//  Created by Minju Lee on 2021/07/02.
//

import Foundation
//network request

struct PhotoInfoController {

    func fetchPhotoInfo(completion: @escaping (PhotoInfo?) -> Void) {
        //1)https인 경우
        //let baseURL = URL(string: "https://api.nasa.gov/planetary/apod")!
        //2)http인 경우
        let baseURL = URL(string: "http://api.nasa.gov/planetary/apod")!
        let query: [String: String] = [
            "api_key": "DEMO_KEY",
            "date": "2011-07-13"
        ]

        //1)https인 경우
        //let url = baseURL.withQueries(query)!
        //2)http인 경우
        guard let url = baseURL.withQueries(query)!.withHTTPS() else { return }
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            let jsonDecoder = JSONDecoder()
            if let data = data, let photoInfo = try? jsonDecoder.decode(PhotoInfo.self, from: data) {
                completion(photoInfo)
            } else {
                print("Either no data was retured, or data was not properly decoded")
                completion(nil)
            }
        }
        task.resume()
    }
}


