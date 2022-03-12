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

         let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))

        view.addGestureRecognizer(tap)
        
    }
    
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    override func viewWillLayoutSubviews() {
        view.addSubview(self.profileHeader)
        profileHeader.backgroundColor = .lightGray
        let topConstraint = self.profileHeader.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 70)
        let leadingConstraint = self.profileHeader.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0)
        let trailingConstraint = self.profileHeader.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0)
        let bottomConstraint = self.profileHeader.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -70)
  
        NSLayoutConstraint.activate([topConstraint, leadingConstraint, trailingConstraint, bottomConstraint])
    }
}
