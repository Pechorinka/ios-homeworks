//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by Tatyana Sidoryuk on 20.02.2022.
// ОНО

import UIKit

protocol ProfileHeaderViewProtocol: AnyObject {
    func didTapStatusButton(textFieldIsVisible: Bool, completion: @escaping () -> Void)
}

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
    
    private lazy var labelsStackView: UIStackView = {  // new
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var infoStackView: UIStackView = { // new
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private var buttonTopConstraint: NSLayoutConstraint? // new
    
    weak var delegate: ProfileHeaderViewProtocol? // new
    
    private lazy var image: UIImageView = {
        let imageView  = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        imageView.backgroundColor = .white
        imageView.clipsToBounds = true
        imageView.layer.borderWidth = 3
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.image = UIImage(named: "cat.png")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var statusButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Show status", for: .normal)
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
    
//    @objc func buttonTapped(sender:UIButton)
//    {
//        secondLabel.text = statusText
//    }
    
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
        text.isHidden = true
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
        
        self.addSubview(self.infoStackView)
        self.addSubview(self.statusButton)
        self.addSubview(self.textField)
        self.infoStackView.addArrangedSubview(self.image)
        self.infoStackView.addArrangedSubview(self.labelsStackView)
        self.labelsStackView.addArrangedSubview(self.myLabel)
        self.labelsStackView.addArrangedSubview(self.secondLabel)

        let topConstraint = self.infoStackView.topAnchor.constraint(equalTo: self.topAnchor)
        let leadingConstraint = self.infoStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20)
        let trailingConstraint = self.infoStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20)
        let imageTopConstraint = self.image.topAnchor.constraint(equalTo: self.infoStackView.topAnchor, constant: 16)
        let imageViewAspectRatio = self.image.heightAnchor.constraint(equalTo: self.image.widthAnchor, multiplier: 1.0)
        let imageLeftConstraint = self.image.leadingAnchor.constraint(equalTo: self.infoStackView.leadingAnchor)
        let imageRightConstraint = self.image.trailingAnchor.constraint(equalTo: self.infoStackView.leadingAnchor, constant: 100)
        let myLabelTopConstraint = self.myLabel.topAnchor.constraint(equalTo: self.labelsStackView.topAnchor, constant: 11)
        
        self.buttonTopConstraint = self.statusButton.topAnchor.constraint(equalTo: self.infoStackView.bottomAnchor, constant: 16)
        self.buttonTopConstraint?.priority = UILayoutPriority(rawValue: 999)
        let leadingButtonConstraint = self.statusButton.leadingAnchor.constraint(equalTo: self.infoStackView.leadingAnchor)
        let trailingButtonConstraint = self.statusButton.trailingAnchor.constraint(equalTo: self.infoStackView.trailingAnchor)
        let heightButtonConstraint = self.statusButton.heightAnchor.constraint(equalToConstant: 50)
        
        NSLayoutConstraint.activate([
            topConstraint, leadingConstraint, trailingConstraint,
            imageViewAspectRatio,
            self.buttonTopConstraint, leadingButtonConstraint,
            trailingButtonConstraint, heightButtonConstraint, imageLeftConstraint, imageTopConstraint, imageRightConstraint, myLabelTopConstraint
        ].compactMap({ $0 }))
        
        image.layer.cornerRadius = self.image.frame.height / 2
    }
    
    @objc private func buttonTapped() {
        if self.textField.isHidden {
            self.addSubview(self.textField)
            textField.isHidden = false
            statusButton.setTitle("Set status", for: .normal)
            self.buttonTopConstraint?.isActive = false // Необходимо деактивировать констрейнт, иначе будет конфликт констрейнтов, и Auto Layout не сможет однозначно определить фреймы textField'а.
            let topConstraint = self.textField.topAnchor.constraint(equalTo: self.infoStackView.bottomAnchor, constant: 10)
            let leadingConstraint = self.textField.leadingAnchor.constraint(equalTo: self.secondLabel.leadingAnchor)
            let trailingConstraint = self.textField.trailingAnchor.constraint(equalTo: self.infoStackView.trailingAnchor)
            let heightTextFieldConstraint = self.textField.heightAnchor.constraint(equalToConstant: 34)
   
            NSLayoutConstraint.activate([
                topConstraint, leadingConstraint, trailingConstraint, heightTextFieldConstraint
            ].compactMap({ $0 }))
            
            self.statusButton.topAnchor.constraint(equalTo: self.textField.bottomAnchor, constant: 20).isActive = true
            
            UIView.animate(withDuration: 1 / 2, delay: 0, options: .curveLinear, animations: {
                self.layoutIfNeeded()
            }, completion: nil
            )
            
        } else {
            secondLabel.text = statusText
            textField.isHidden = true
            self.textField.endEditing(true)
            self.buttonTopConstraint =  self.statusButton.topAnchor.constraint(equalTo: self.infoStackView.bottomAnchor, constant: 16)
            buttonTopConstraint?.isActive = true
            statusButton.setTitle("Show status", for: .normal)
            UIView.animate(withDuration: 1 / 2, delay: 0, options: .curveLinear, animations: {
                self.layoutIfNeeded()
            }, completion: nil
            )
        }
    }
}
