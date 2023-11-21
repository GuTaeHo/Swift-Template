//
//  UIImageView+.swift
//  MyCodeBaseViews
//
//  Created by 구태호 on 11/21/23.
//

import UIKit


extension UIImageView {
    func imageDownload(url: String?, contentMode mode: UIView.ContentMode = .scaleAspectFill, completionHandler: ((UIImage?) -> ())? = nil) {
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
                completionHandler?(nil)
                return
            }
            
            DispatchQueue.main.async() { [weak self] in
                print("Download image success \(url)")
                
                self?.contentMode = mode
                self?.image = image
                completionHandler?(image)
            }
        }.resume()
    }
}
