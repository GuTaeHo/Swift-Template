//
//  UIImageView+.swift
//  MyUIViewShadow
//
//  Created by 구태호 on 2023/08/31.
//

import UIKit


extension UIImageView {
    func imageDownload(url: String?, contentMode mode: UIView.ContentMode = .scaleAspectFill) {
        guard let url = url else { return }
        guard let tempUrl = URL(string: url) else { return }
        
        var request = URLRequest(url: tempUrl)
        request.httpMethod = "GET"

        URLSession.shared.dataTask(with: request) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else {
                    print("Download image fail : \(url)")
                    return
            }

            DispatchQueue.main.async() { [weak self] in
                print("Download image success \(url)")

                self?.contentMode = mode
                self?.image = image
            }
        }.resume()
    }
}
