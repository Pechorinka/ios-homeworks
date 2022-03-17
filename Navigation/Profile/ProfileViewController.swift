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
         tableView.rowHeight = UITableView.automaticDimension
         tableView.estimatedRowHeight = 44
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
        let heightTableViewConstraint = self.tableView.heightAnchor.constraint(equalToConstant: 160)
        
        NSLayoutConstraint.activate([topConstraint, leadingConstraint, trailingConstraint, bottomConstraint,
                                     topTableViewConstraint, leadingTableViewConstraint, trailingTableViewConstraint, heightTableViewConstraint
        ])
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
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }

    func numberOfSections(in tableView: UITableView) -> Int { // кол-во секций
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoCell", for: indexPath) as? PhotosTableViewCell else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "DefaultCell", for: indexPath)
                return cell
            }
            cell.layer.shouldRasterize = true
            cell.layer.rasterizationScale = UIScreen.main.scale
            cell.delegate = self
            return cell
    }
}
