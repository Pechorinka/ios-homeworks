//
//  PostViewController.swift
//  Navigation
//
//  Created by Tatyana Sidoryuk on 17.02.2022.
//

import UIKit

class PostViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemYellow
        
        self.navigationItem.rightBarButtonItems = [
                    UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareBtnTapped)),
                ]
        self.navigationItem.titleView?.center = self.view.center
        self.navigationItem.titleView?.backgroundColor = .white
    }
    @objc private func shareBtnTapped() {
          let newVC = InfoViewController()
      //    newVC.modalPresentationStyle = .fullScreen
          self.present(newVC, animated: true, completion: nil)
    }
}
