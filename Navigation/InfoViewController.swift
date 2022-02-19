//
//  InfoViewController.swift
//  Navigation
//
//  Created by Tatyana Sidoryuk on 17.02.2022.
//

import UIKit

class InfoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemPink
    
    let alertButton = UIButton (frame: CGRect (x: 50, y: 250, width: 200, height: 50))
    alertButton.backgroundColor = .black
    alertButton.layer.cornerRadius = 12
    alertButton.layer.masksToBounds = true
    alertButton.center = self.view.center
    alertButton.setTitle ("Вывести алерт!", for: .normal)
    alertButton.addTarget(self, action: #selector (pressAlert), for: .touchUpInside)
    self.view.addSubview(alertButton)
    }
    
    @objc private func pressAlert() {
        let alert = UIAlertController (title: "Внимание", message: "Серьезно?", preferredStyle: .alert)
        let okButton = UIAlertAction (title: "Да", style: .default, handler: {action in print ("Да")} )
        let notOKButton = UIAlertAction (title: "Нет", style: .default, handler: {action in print ("Нет")})
        alert.addAction(okButton)
        alert.addAction(notOKButton)
        present (alert, animated: true, completion: nil)
    }
}
