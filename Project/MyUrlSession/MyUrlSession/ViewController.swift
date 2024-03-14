//
//  ViewController.swift
//  MyUrlSession
//
//  Created by 구태호 on 3/6/24.
//

import UIKit

class ViewController: UIViewController {
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: PostTableViewCell.identifier)
        return tableView
    }()
    
    private var items: [Post]?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        Task {
            items = await getPosts()
            tableView.reloadData()
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

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PostTableViewCell.identifier, for: indexPath) as! PostTableViewCell
        
        cell.configuration(items![indexPath.row])
        return cell
    }
}

