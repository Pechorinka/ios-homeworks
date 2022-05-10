//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by Tatyana Sidoryuk on 20.02.2022.


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

final class ProfileHeaderView: UIView, PhotosTableViewCellProtocol {
    
    func delegateButtonAction() {
        print ("Clicked on arrow")
        }
    
    private var statusText: String = ""

    lazy var photosTableViewCell: PhotosTableViewCell = {
        let view2 = PhotosTableViewCell(frame: .zero)
        view2.delegate = self
        view2.translatesAutoresizingMaskIntoConstraints = false
        return view2
    } ()
    
    lazy var myCollection: UICollectionView = {
        let view = UICollectionView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var labelsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    public lazy var infoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    var buttonTopConstraint: NSLayoutConstraint? // new
    var imageLeftConstraint: NSLayoutConstraint?
    var imageRightConstraint: NSLayoutConstraint?
    
    public lazy var image: UIImageView = {
        let imageView  = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        imageView.backgroundColor = .white
        imageView.clipsToBounds = true
        imageView.layer.borderWidth = 3
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.image = UIImage(named: "cat.png")
        imageView.translatesAutoresizingMaskIntoConstraints = false
 
        return imageView
    }()
    
    public lazy var statusButton: UIButton = {
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
    
    // Жесты
    
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
    
    private let tapGestureRecognizer = UITapGestureRecognizer()
    public var topImageConstraint: NSLayoutConstraint?
    public var leftImageConstraint: NSLayoutConstraint?
    public var widthImageConstraint: NSLayoutConstraint?
    public var heightImageConstraint: NSLayoutConstraint?
    private var isExpanded = false
    
     
    // жесты - конец
    
      @objc func statusTextChanged(_ textField: UITextField)
      {
          statusText = textField.text!
          if statusText.count == 0 {
              textField.backgroundColor = .red
          } else {
              textField.backgroundColor = .white
          }
      }
    
    override init (frame: CGRect) {
        super.init(frame: frame)
        self.drawSelf()
    }
    


    @objc private func didTapButton() {
        self.mySecondView.isHidden = false
        self.bringSubviewToFront(mySecondView)
        self.myButton.isHidden = false
        self.isExpanded.toggle()
        self.heightImageConstraint?.constant = self.isExpanded ? self.bounds.height : 140
        self.widthImageConstraint?.constant = self.isExpanded ? self.bounds.width : 140
        NSLayoutConstraint.activate([ self.topImageConstraint, self.leftImageConstraint
        ].compactMap( {$0} ))
        UIView.animate(withDuration: 0.5) {
            self.mySecondView.alpha = self.isExpanded ? 0.5 : 0
            self.layoutIfNeeded()

        } completion: { _ in
        }

        UIView.animate(withDuration: 0.3, delay: 0.5) {
            self.myButton.alpha = self.isExpanded ? 1 : 0
            self.layoutIfNeeded()

        } completion: { _ in
        }

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func drawSelf() {
        
        self.addSubview(self.infoStackView)
        self.addSubview(self.statusButton)
     //   self.addSubview(self.textField)
        self.addSubview(self.mySecondView) //  серый фон
        self.addSubview(self.myButton) // кнопка с крестиком
        
        self.infoStackView.addArrangedSubview(self.image)
        self.infoStackView.addArrangedSubview(self.labelsStackView)
        
        self.labelsStackView.addArrangedSubview(self.myLabel)
        self.labelsStackView.addArrangedSubview(self.secondLabel)
        self.labelsStackView.addArrangedSubview(self.textField)

        let topConstraint = self.infoStackView.topAnchor.constraint(equalTo: self.topAnchor)
        let leadingConstraint = self.infoStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20)
        let trailingConstraint = self.infoStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20)
        let imageTopConstraint = self.image.topAnchor.constraint(equalTo: self.infoStackView.topAnchor, constant: 16)
        let imageViewAspectRatio = self.image.heightAnchor.constraint(equalTo: self.image.widthAnchor, multiplier: 1.0)
        self.imageLeftConstraint = self.image.leadingAnchor.constraint(equalTo: self.infoStackView.leadingAnchor)
        self.imageRightConstraint = self.image.trailingAnchor.constraint(equalTo: self.infoStackView.leadingAnchor, constant: 100)
        let myLabelTopConstraint = self.myLabel.topAnchor.constraint(equalTo: self.labelsStackView.topAnchor, constant: 0)
        
        self.buttonTopConstraint = self.statusButton.topAnchor.constraint(equalTo: self.infoStackView.bottomAnchor, constant: 16)
        self.buttonTopConstraint?.priority = UILayoutPriority(rawValue: 999)
        let leadingButtonConstraint = self.statusButton.leadingAnchor.constraint(equalTo: self.infoStackView.leadingAnchor)
        let trailingButtonConstraint = self.statusButton.trailingAnchor.constraint(equalTo: self.infoStackView.trailingAnchor)
        let heightButtonConstraint = self.statusButton.heightAnchor.constraint(equalToConstant: 40)
        
        let topTextFieldConstraint = self.textField.topAnchor.constraint(equalTo: self.secondLabel.bottomAnchor, constant: 20)
        let leadingTextFieldConstraint = self.textField.leadingAnchor.constraint(equalTo: self.secondLabel.leadingAnchor)
        let trailingTextFieldConstraint = self.textField.trailingAnchor.constraint(equalTo: self.infoStackView.trailingAnchor)

        
        NSLayoutConstraint.activate([
            topConstraint, leadingConstraint, trailingConstraint,
            imageViewAspectRatio,
            self.buttonTopConstraint, leadingButtonConstraint,
            trailingButtonConstraint, heightButtonConstraint, imageLeftConstraint, imageTopConstraint, imageRightConstraint, myLabelTopConstraint, topTextFieldConstraint, leadingTextFieldConstraint, trailingTextFieldConstraint,
        ].compactMap({ $0 }))
        
        image.layer.cornerRadius = self.image.frame.height / 2
    }
    
    @objc private func buttonTapped() {
            if statusText == "" {
                textField.backgroundColor = .red
            }
            else {
                secondLabel.text = statusText
                self.textField.endEditing(true)
                statusButton.setTitle("Set status", for: .normal)
            }
    }
}

extension UIView {
    func findViewController() -> UIViewController? {
        if let nextResponder = self.next as? UIViewController {
            return nextResponder
        } else if let nextResponder = self.next as? UIView {
            return nextResponder.findViewController()
        } else {
            return nil
        }
    }
}
