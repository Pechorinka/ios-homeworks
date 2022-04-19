//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Tatyana Sidoryuk on 17.02.2022.
//

import UIKit

var controller = UIViewController()

class ViewController: UIViewController {
    
     override func loadView() {
        controller = self
     }
}

final class ProfileViewController: UIViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true 
    }
    
    private lazy var jsonDecoder: JSONDecoder = {
        return JSONDecoder()
    }()
    
    private var dataSource: [News.Post] = []
    
    lazy var profileHeader: ProfileHeaderView = {
        let view = ProfileHeaderView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    } ()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.navigationController?.navigationBar.isHidden = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        self.fetchPosts { [weak self] posts in
            self?.dataSource = posts
            self?.tableView.reloadData()
        }
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    
    lazy var tableView: UITableView = {
         let tableView = UITableView()
         tableView.dataSource = self
         tableView.translatesAutoresizingMaskIntoConstraints = false
         tableView.register(UITableViewCell.self, forCellReuseIdentifier: "DefaultCell")
         tableView.register(PhotosTableViewCell.self, forCellReuseIdentifier: "PhotoCell")
         tableView.register(PostTableViewCell.self, forCellReuseIdentifier: "PostCell")
         tableView.rowHeight = UITableView.automaticDimension
         tableView.estimatedRowHeight = 300
         tableView.delegate = self
         return tableView
     } ()
    
    override func viewWillLayoutSubviews() {
        view.addSubview(self.profileHeader)
        profileHeader.backgroundColor = .lightGray
        let topConstraint = self.profileHeader.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 40)
        let leadingConstraint = self.profileHeader.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0)
        let trailingConstraint = self.profileHeader.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0)
        let bottomConstraint = self.profileHeader.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -80)
        
        view.addSubview(self.tableView)
        let topTableViewConstraint = self.tableView.topAnchor.constraint(equalTo: self.profileHeader.statusButton.bottomAnchor, constant: 16)
        let leadingTableViewConstraint = self.tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor)
        let trailingTableViewConstraint = self.tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        let bottomTableViewConstraint = self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -80)
        
        NSLayoutConstraint.activate([topConstraint, leadingConstraint, trailingConstraint, bottomConstraint,
                                     topTableViewConstraint, leadingTableViewConstraint, trailingTableViewConstraint, bottomTableViewConstraint
        ])
    }
    
    
    private func fetchPosts(completion: @escaping ([News.Post]) -> Void) {
        if let path = Bundle.main.path(forResource: "news", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
                let news = try self.jsonDecoder.decode(News.self, from: data)
                print("json data: \(news)")
                completion(news.posts)
            } catch let error {
                print("parse error: \(error.localizedDescription)")
            }
        } else {
            fatalError("Invalid filename/path.")
        }
    }
}

extension ProfileViewController: PhotosTableViewCellProtocol {
    
    func delegateButtonAction() {
        let photosViewController = PhotosViewController()
        self.navigationController?.pushViewController(photosViewController, animated: true)
    }
}


extension ProfileViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            
            return 0
        } else {
            
            return self.dataSource.count + 1
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            
            return 266
        } else {
            
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 160
        } else {
            return 700
        }
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoCell", for: indexPath) as? PhotosTableViewCell else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "DefaultCell", for: indexPath)

                return cell
            }

            cell.layer.shouldRasterize = true
            cell.layer.rasterizationScale = UIScreen.main.scale

            return cell

        } else {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as? PostTableViewCell else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DefaultCell", for: indexPath)

            return cell
        }

        let post = self.dataSource[indexPath.row - 1]
        let viewModel = PostTableViewCell.ViewModel(author: post.author,
                                                    description: post.description, image: post.image, likes: post.likes, views: post.views)
        cell.setup(with: viewModel)
        return cell
    }
    }
     
}
