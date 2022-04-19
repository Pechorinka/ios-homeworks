//
//  LogInViewController.swift
//  Navigation
//
//  Created by Tatyana Sidoryuk on 09.03.2022.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
 
    private lazy var scrollView: UIScrollView = {
            let scrollView = UIScrollView ()
            scrollView.backgroundColor = .white
            scrollView.translatesAutoresizingMaskIntoConstraints = false
            return scrollView
        } ()
    
    private lazy var stackView: UIStackView = {
            let stackView = UIStackView ()
            stackView.backgroundColor = .white
            stackView.translatesAutoresizingMaskIntoConstraints = false
            stackView.axis = .vertical
            stackView.distribution = .fillProportionally
            stackView.spacing = 16
            return stackView
        } ()
    
    private lazy var vkImage: UIImageView = {
        let imageView  = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        imageView.backgroundColor = .white
        imageView.clipsToBounds = true
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.image = UIImage(named: "logo.png")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var textField1: UITextField = {
       let text1 = UITextField()
        let padding: CGFloat = 10
        text1.translatesAutoresizingMaskIntoConstraints = false
        text1.textColor = .black
        text1.autocapitalizationType = .none
        text1.layer.borderColor = UIColor.lightGray.cgColor
        text1.layer.borderWidth = 0.5
        text1.layer.cornerRadius = 10
        text1.backgroundColor = .systemGray6
        text1.font = UIFont.systemFont(ofSize: 16)
        text1.clearButtonMode = .whileEditing
        text1.clearButtonMode = .unlessEditing
        text1.clearButtonMode = .always
        text1.addPadding(.both(10))
        return text1
    }()
    
    private lazy var textField2: UITextField = {
       let text2 = UITextField()
        let padding: CGFloat = 10
        text2.textColor = .black
        text2.autocapitalizationType = .none
        text2.layer.borderColor = UIColor.lightGray.cgColor
        text2.layer.borderWidth = 0.5
        text2.layer.cornerRadius = 10
        text2.backgroundColor = .systemGray6
        text2.font = UIFont.systemFont(ofSize: 16)
        text2.translatesAutoresizingMaskIntoConstraints = false
        text2.isSecureTextEntry = true
        text2.addPadding(.both(10))
        return text2
    }()
    
    private lazy var myButton: UIButton = {
        let image = UIImage(named: "blue_pixel.png")
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 4
        button.setBackgroundImage(image, for: UIControl.State.normal)
        button.setTitle("Log In", for: .normal)
        button.titleLabel?.textColor = .white
        button.backgroundColor = UIColor(named:"Color")
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
        if button.isSelected {
            button.alpha = 0.8 }
        else if  button.isHighlighted {
            button.alpha = 0.8
        }
        else if !button.isEnabled {
            button.alpha = 0.8
        } else { button.alpha = 1
        }
        
        return button
    }()
    
    @objc func buttonTapped(sender: UIButton)
    {
        if myButton.isSelected {
            myButton.alpha = 0.8
        } else if myButton.isHighlighted {
            myButton.alpha = 0.8
        } else if !myButton.isEnabled {
            myButton.alpha = 0.8
        } else {
            myButton.alpha = 1
        }
        
        let profile = ProfileViewController()
        self.navigationController?.pushViewController(profile, animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureSubviews()
        self.setupConstraints()
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
       view.addGestureRecognizer(tap)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(LoginViewController.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(LoginViewController.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let kbdSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            scrollView.contentOffset = CGPoint(x: 0, y: kbdSize.height * 0.1)
            scrollView.scrollIndicatorInsets = UIEdgeInsets(top:0, left:0, bottom: kbdSize.height, right: 0)
        }
    }

    @objc func keyboardWillHide(notification: NSNotification){
        scrollView.contentOffset = CGPoint.zero
    }

    
    private func configureSubviews () {
        self.navigationController?.navigationBar.isHidden = true
        self.view.addSubview(self.scrollView)
        scrollView.addSubview(vkImage)
        scrollView.addSubview(stackView)
        stackView.addArrangedSubview(textField1)
        stackView.addArrangedSubview(textField2)
        stackView.addArrangedSubview(myButton)
    }
    
    private func setupConstraints() {
        let scrollViewTopConstraint = self.scrollView.topAnchor.constraint(equalTo: self.view.topAnchor)
        let scrollViewRightConstraint = self.scrollView.rightAnchor.constraint(equalTo: self.view.rightAnchor)
        let scrollViewBottomConstraint = self.scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        let scrollViewLeftConstraint = self.scrollView.leftAnchor.constraint(equalTo: self.view.leftAnchor)
        
        let vkImageTopConstraint = self.vkImage.topAnchor.constraint(equalTo: self.scrollView.topAnchor, constant: 120)
        vkImageTopConstraint.priority = .defaultLow
        let vkImageCenterXConstraint = self.vkImage.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor)
        let vkImageHeightConstraint = self.vkImage.heightAnchor.constraint(equalToConstant: 100)
        let vkImageWidthConstraint = self.vkImage.widthAnchor.constraint(equalToConstant: 100)
        
        let stackViewCenterXConstraint = self.stackView.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor)
        let stackViewCenterYConstraint = self.stackView.centerYAnchor.constraint(equalTo: self.scrollView.centerYAnchor)
        let stackViewLeadingConstraint = self.stackView.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor, constant: 16)
        let stackViewTrailingConstraint = self.stackView.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor, constant: -16)
        
        let text1HeightConstraint = self.textField1.heightAnchor.constraint(equalToConstant: 50)
        let text2HeightConstraint = self.textField2.heightAnchor.constraint(equalToConstant: 50)
        let text2TopConstraint = self.textField2.topAnchor.constraint(equalTo: self.textField1.bottomAnchor)
        let buttonHeightConstraint = self.myButton.heightAnchor.constraint(equalToConstant: 50)
        let text1TopConstraint = self.textField1.topAnchor.constraint(greaterThanOrEqualTo: vkImage.bottomAnchor)
    
        
        NSLayoutConstraint.activate([scrollViewTopConstraint, scrollViewLeftConstraint, scrollViewRightConstraint, scrollViewBottomConstraint, vkImageTopConstraint, vkImageCenterXConstraint, vkImageHeightConstraint, vkImageWidthConstraint,
            stackViewLeadingConstraint, stackViewTrailingConstraint, stackViewCenterXConstraint, stackViewCenterYConstraint, text1HeightConstraint, text2HeightConstraint, buttonHeightConstraint, text2TopConstraint, text1TopConstraint
                                    ])

    }
}
