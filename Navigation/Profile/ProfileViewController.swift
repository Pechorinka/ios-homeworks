//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Tatyana Sidoryuk on 17.02.2022.
//

import UIKit

final class ProfileViewController: UIViewController {
    
    lazy var profileHeader: ProfileHeaderView = {
        let view = ProfileHeaderView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    } ()
    
    override func viewDidLoad() {
         
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.navigationItem.title = "Профиль"
    }
    
    override func viewWillLayoutSubviews() {
        view.addSubview(self.profileHeader)
        profileHeader.backgroundColor = .lightGray
        let topConstraint = self.profileHeader.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 60)
        let leadingConstraint = self.profileHeader.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0)
        let trailingConstraint = self.profileHeader.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0)
        let bottomConstraint = self.profileHeader.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -50)
 //       let heighConstraint = self.profileHeader.heightAnchor.constraint (equalToConstant: 170)
        
        NSLayoutConstraint.activate([topConstraint, leadingConstraint, trailingConstraint, bottomConstraint])
    }
}
