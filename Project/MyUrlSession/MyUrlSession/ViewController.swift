//
//  ViewController.swift
//  MyUrlSession
//
//  Created by 구태호 on 3/6/24.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        Task {
            print(await getPosts().toJson ?? "")
        }
    }

    func getPosts() async -> [Post]? {
        let request = URLRequest(url: .init(string: "https://jsonplaceholder.typicode.com/posts/1/comments")!, timeoutInterval: 20)
        
        guard let (data, response) = try? await URLSession.shared.data(for: request) else {
            return nil
        }
        
        do {
            print("response url: \(response.url?.absoluteString ?? .init())")
            print("response mimeType: \(response.mimeType ?? "")")
            print("response textEncodingName: \(response.textEncodingName ?? "")")
            print("response suggestedFilename: \(response.suggestedFilename ?? "")")
            print("response expectedContentLength: \(response.expectedContentLength)")
            return try JSONDecoder().decode([Post].self, from: data)
        } catch (let error) {
            print("JSON 파싱 에러: \(error.localizedDescription)")
            return nil
        }
    }
}

