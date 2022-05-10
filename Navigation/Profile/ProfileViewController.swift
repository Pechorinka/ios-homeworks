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

var likedPosts = Set<Int>()
public var thisViews = 0

public var postNumber = 0

final class ProfileViewController: UIViewController {
    
    // серый фон для жестов
    private lazy var mySecondView: UIView = {
        let view = UIView()
        view.isHidden = true
        view.alpha = 0
        view.backgroundColor = .systemGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private lazy var myButton: UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "multiply.square")
        button.setBackgroundImage(image, for: .normal)
        button.isHidden = true
        button.alpha = 0
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    public lazy var imageCopy: UIImageView = {
        let imageView  = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        imageView.alpha = 0
        imageView.backgroundColor = .white
        imageView.clipsToBounds = true
        imageView.layer.borderWidth = 3
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.image = UIImage(named: "cat.png")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private var isExpanded = false
    
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
    
    private var crossWidthConstraint: NSLayoutConstraint?
    private var crossHeightConstraint: NSLayoutConstraint?
    private var crossTopConstraint: NSLayoutConstraint?
    private var crossTrailingtConstraint: NSLayoutConstraint?
    
    private var imageCopyTopConstraint: NSLayoutConstraint?
    private var imageCopyLeadingConstraint: NSLayoutConstraint?
    private var imageCopyWidthConstraint: NSLayoutConstraint?
    private var imageCopyHeightConstraint: NSLayoutConstraint?
    private var imageCopyCenterYConstraint: NSLayoutConstraint?
    private var imageCopyCenterXConstraint: NSLayoutConstraint?
    
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
        
        
        view.addSubview(mySecondView)
        // перекрывающий серый фон
        let secondViewTopConstraint = self.mySecondView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 40)
        let secondViewLeadingConstraint = self.mySecondView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor)
        let secondViewTrailingConstraint = self.mySecondView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        let secondViewBottomConstraint = self.mySecondView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -80)
        
        view.addSubview(imageCopy)
        
        // крестик
        view.addSubview(myButton)
        let crossTopConstraint = self.myButton.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 40)
        let crossTrailingtConstraint = self.myButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20)
        let crossWidthConstraint = self.myButton.widthAnchor.constraint(equalToConstant: 40)
        let crossHeightConstraint = self.myButton.heightAnchor.constraint(equalToConstant: 40)
        
        // копия фото

        self.imageCopyWidthConstraint = self.imageCopy.widthAnchor.constraint(equalToConstant: 100)
        self.imageCopyHeightConstraint = self.imageCopy.heightAnchor.constraint(equalToConstant: 100)
        
        
        NSLayoutConstraint.activate([topConstraint, leadingConstraint, trailingConstraint, bottomConstraint,
                                     topTableViewConstraint, leadingTableViewConstraint, trailingTableViewConstraint, bottomTableViewConstraint,
                                     secondViewTopConstraint, secondViewBottomConstraint, secondViewLeadingConstraint, secondViewTrailingConstraint,
                                     crossTopConstraint, crossWidthConstraint, crossHeightConstraint, crossTrailingtConstraint,
        ])
        
        self.imageCopyWidthConstraint?.isActive = true
        self.imageCopyHeightConstraint?.isActive = true
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture))
        profileHeader.addGestureRecognizer(tapGesture)
        myButton.addTarget(self, action: #selector(self.didTapButton), for: .touchUpInside)
    }
    
    @objc private func handleTapGesture() {
        self.mySecondView.isHidden = false
        self.myButton.isHidden = false
        self.isExpanded.toggle()
        profileHeader.image.alpha = 0
        self.imageCopy.alpha = 1
        
        
        self.imageCopyWidthConstraint = self.imageCopy.widthAnchor.constraint(equalTo: self.view.widthAnchor)
        self.imageCopyHeightConstraint = self.imageCopy.heightAnchor.constraint(equalTo: self.view.widthAnchor)
        self.imageCopyCenterXConstraint = self.imageCopy.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        self.imageCopyCenterYConstraint = self.imageCopy.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        
        self.imageCopyWidthConstraint!.isActive = true
        self.imageCopyHeightConstraint!.isActive = true
        imageCopyCenterYConstraint!.isActive = true
        imageCopyCenterXConstraint!.isActive = true
        
        
        imageCopy.layer.cornerRadius = self.imageCopy.frame.height / 2
        
        UIView.animate(withDuration: 0.5) { [self] in
            self.mySecondView.alpha = self.isExpanded ? 0.5 : 0
            self.view.layoutIfNeeded()
            
        } completion: { _ in
        }

        UIView.animate(withDuration: 0.3, delay: 0.5) {
            self.myButton.alpha = self.isExpanded ? 1 : 0
            self.view.layoutIfNeeded()

        } completion: { _ in
        }
    }
    
    @objc private func didTapButton() {
        self.mySecondView.isHidden = false
        self.myButton.isHidden = false
        self.isExpanded.toggle()
        profileHeader.image.alpha = 1
        
        imageCopy.alpha = 0
        

        UIView.animate(withDuration: 0.5) {
            self.mySecondView.alpha = self.isExpanded ? 0.5 : 0

        } completion: { _ in
        }

        UIView.animate(withDuration: 0.3, delay: 0.5) {
            self.myButton.alpha = self.isExpanded ? 1 : 0

        } completion: { _ in
        }

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

            cell.delegate = self
            cell.layer.shouldRasterize = true
            cell.layer.rasterizationScale = UIScreen.main.scale

            return cell

        } else {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as? PostTableViewCell else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DefaultCell", for: indexPath)

            return cell
        }

            cell.delegate = self
        let post = self.dataSource[indexPath.row - 1]
        let viewModel = PostTableViewCell.ViewModel(author: post.author,
                                                    description: post.description, image: post.image, likes: post.likes, views: post.views)
        cell.setup(with: viewModel)
        return cell
    }
    }
     
}

extension ProfileViewController: PostTableViewCellProtocol {
    func tapLikes(cell: PostTableViewCell) {
        guard let index = self.tableView.indexPath(for: cell)?.row else { return }
        if likedPosts.contains(index) {
            likedPosts.remove(index)
            let indexPath = IndexPath(row: index, section: 0)
            self.dataSource[indexPath.row - 1].likes -= 1
            self.tableView.reloadData()
            
        } else {
            likedPosts.insert(index)
            let indexPath = IndexPath(row: index, section: 0)
            self.dataSource[indexPath.row - 1].likes += 1
            self.tableView.reloadData()
        }
    }
    
    func tapPostImage(cell: PostTableViewCell) {
        
         guard let index = self.tableView.indexPath(for: cell)?.row else { return }
         postNumber = index
         let indexPath = IndexPath(row: index, section: 0)
         self.dataSource[indexPath.row - 1].views += 1
         thisViews = self.dataSource[indexPath.row - 1].views
         self.tableView.reloadData()
        
        let post = SinglePostViewController()
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.pushViewController(post, animated: true)
    }
}

