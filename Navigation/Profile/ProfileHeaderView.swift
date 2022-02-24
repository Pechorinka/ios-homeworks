//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by Tatyana Sidoryuk on 20.02.2022.
//

import UIKit

extension UITextField {

    enum PaddingSide {
        case left(CGFloat)
        case right(CGFloat)
        case both(CGFloat)
    }

    func addPadding(_ padding: PaddingSide) {

        self.leftViewMode = .always
        self.layer.masksToBounds = true


        switch padding {

        case .left(let spacing):
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: spacing, height: self.frame.height))
            self.leftView = paddingView
            self.rightViewMode = .always

        case .right(let spacing):
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: spacing, height: self.frame.height))
            self.rightView = paddingView
            self.rightViewMode = .always

        case .both(let spacing):
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: spacing, height: self.frame.height))
            // left
            self.leftView = paddingView
            self.leftViewMode = .always
            // right
            self.rightView = paddingView
            self.rightViewMode = .always
        }
    }
}


final class ProfileHeaderView: UIView {
    
    private var statusText: String = ""
    
    private lazy var image: UIImageView = {
        let imageView  = UIImageView(frame: CGRect(x: 16, y: 16, width: 100, height: 100))
        imageView.backgroundColor = .white
        imageView.clipsToBounds = true
        imageView.layer.borderWidth = 3
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.image = UIImage(named: "cat.png")
        return imageView
    }()
    
    private lazy var statusButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Set status", for: .normal)
        button.titleLabel?.textColor = .white
        button.backgroundColor = UIColor.systemBlue
        button.layer.cornerRadius = 4
        button.layer.shadowOffset.width = 4
        button.layer.shadowOffset.height = 4
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.7
        button.layer.shadowRadius = 4
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return button
    }()
    
    @objc func buttonTapped(sender:UIButton)
    {
        secondLabel.text = statusText
    }
    
    private lazy var myLabel: UILabel = {
      let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.text = "Bad cat"
        return label
    }()
    
    private lazy var secondLabel: UILabel = {
      let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .gray
        return label
    }()
    
    private lazy var textField: UITextField = {
      let text = UITextField()
        let padding: CGFloat = 10
        text.translatesAutoresizingMaskIntoConstraints = false
        text.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        text.textColor = .black
        text.layer.cornerRadius = 12
        text.backgroundColor = .white
        text.layer.borderWidth = 1
        text.layer.borderColor = UIColor.black.cgColor
        text.text = secondLabel.text
        text.addTarget(self, action: #selector(statusTextChanged), for: .editingChanged)
        text.addPadding(.both(10))
        return text
    }()
    
    
      @objc func statusTextChanged(_ textField: UITextField)
      {
          statusText = textField.text!
      }
    
    override init (frame: CGRect) {
        super.init(frame: frame)
        self.drawSelf()
    }
     
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func drawSelf() {
        
        self.addSubview(myLabel)
        self.addSubview(image)
        self.addSubview(statusButton)
        self.addSubview(secondLabel)
        self.addSubview(textField)
        
        myLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 27).isActive = true
        myLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        statusButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 132).isActive = true
        statusButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        statusButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16).isActive = true
        statusButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16).isActive = true
        
        secondLabel.bottomAnchor.constraint(equalTo: statusButton.topAnchor, constant: -60).isActive = true
        secondLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 150).isActive = true
        secondLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16).isActive = true
        
        textField.topAnchor.constraint(equalTo: secondLabel.bottomAnchor, constant: 10).isActive = true
        textField.leadingAnchor.constraint(equalTo: secondLabel.leadingAnchor).isActive = true
        textField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        textField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16).isActive = true
        
        image.layer.cornerRadius = self.image.frame.height / 2
        
    }
}
