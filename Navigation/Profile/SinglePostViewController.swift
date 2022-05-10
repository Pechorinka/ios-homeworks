//
//  SinglePostViewController.swift
//  Navigation
//
//  Created by Tatyana Sidoryuk on 08.05.2022.
//

import UIKit

class SinglePostViewController: UIViewController {

    private var dataSource: [News.Post] = []
    
    lazy var singlePost: SinglePostView = {
        let view = SinglePostView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    } ()
    
    private lazy var jsonDecoder: JSONDecoder = {
        return JSONDecoder()
    }()
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.navigationItem.titleView?.center = self.view.center
        self.navigationItem.titleView?.backgroundColor = .white
        self.fetchPosts { [weak self] posts in
            self?.dataSource = posts
        }
    }
    override func viewWillLayoutSubviews() {
        view.addSubview(self.singlePost)
         let post = self.dataSource[postNumber - 1]
         let viewModel = SinglePostView.ViewModel(
             author: post.author, description: post.description, image: post.image, likes: post.likes, views: post.views)
         singlePost.setup(with: viewModel)
        
        let topConstraint = self.singlePost.topAnchor.constraint(equalTo: self.view.topAnchor)
        let leadingConstraint = self.singlePost.leadingAnchor.constraint(equalTo: self.view.leadingAnchor)
        let trailingConstraint = self.singlePost.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        let bottomConstraint = self.singlePost.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
   
        NSLayoutConstraint.activate([topConstraint, leadingConstraint, trailingConstraint, bottomConstraint
        ])
    }
}
