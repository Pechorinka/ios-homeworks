//
//  SinglePostView.swift
//  Navigation
//
//  Created by Tatyana Sidoryuk on 07.05.2022.
//

import UIKit

class SinglePostView: UIView {
    
    private var dataSource: [News.Post] = []

    struct ViewModel: ViewModelProtocol {
        var author: String
        var description: String
        var image: String
        var likes: Int
        var views: Int
    }

    private lazy var backView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        return view
    }()

    private lazy var label: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.setContentCompressionResistancePriority(UILayoutPriority(999), for: .vertical)
        label.preferredMaxLayoutWidth = self.frame.size.width
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var myImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .black
        imageView.setContentCompressionResistancePriority(UILayoutPriority(250), for: .vertical)
        return imageView
    }()

    private lazy var label2: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.preferredMaxLayoutWidth = self.frame.size.width
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .systemGray
        label.setContentCompressionResistancePriority(UILayoutPriority(999), for: .vertical)
        label.setContentHuggingPriority(UILayoutPriority(1), for: .vertical)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.setContentCompressionResistancePriority(UILayoutPriority(999), for: .vertical)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private lazy var likes: UILabel = {
        let label = UILabel()
        label.text  = "Likes: "
        label.backgroundColor = .clear
        label.font = UIFont.systemFont(ofSize: 16)
        label.preferredMaxLayoutWidth = self.frame.size.width
        label.textColor = .black
        label.setContentHuggingPriority(UILayoutPriority(1), for: .horizontal)
        label.setContentCompressionResistancePriority(UILayoutPriority(500), for: .horizontal)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var views: UILabel = {
        let label = UILabel()
        label.text  = "Views: "
        label.backgroundColor = .clear
        label.font = UIFont.systemFont(ofSize: 16)
        label.preferredMaxLayoutWidth = self.frame.size.width
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setContentCompressionResistancePriority(UILayoutPriority(500), for: .vertical)
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
        self.backgroundColor = .white
        self.translatesAutoresizingMaskIntoConstraints = false
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        self.addSubview(self.backView)
        self.backView.addSubview(self.label)
        self.backView.addSubview(self.myImageView)
        self.backView.addSubview(self.label2)
        self.backView.addSubview(self.stackView)
        self.stackView.addArrangedSubview(self.likes)
        self.stackView.addArrangedSubview(self.views)
        setupConstraints()
    }

    private func setupConstraints() {
        let centerXConstraintBackView = self.backView.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        let centerYConstraintBackView = self.backView.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        let leadingConstraintBackView = self.backView.leadingAnchor.constraint(equalTo: self.leadingAnchor)
        let trailingConstraintBackView = self.backView.trailingAnchor.constraint(equalTo: self.trailingAnchor)

        let topConstraintAuthorLabel = self.label.topAnchor.constraint(equalTo: self.backView.topAnchor)
        let leadingConstraintAuthorLabel = self.label.leadingAnchor.constraint(equalTo: self.backView.leadingAnchor, constant: 16)
        let trailingConstraintAuthorLabel = self.label.trailingAnchor.constraint(equalTo: self.backView.trailingAnchor, constant: -16)

        let topConstraintPostImageView = self.myImageView.topAnchor.constraint(equalTo: self.label.bottomAnchor, constant: 4)
        let leadingConstraintPostImageView = self.myImageView.leadingAnchor.constraint(equalTo: self.backView.leadingAnchor)
        let trailingConstraintPostImageView = self.myImageView.trailingAnchor.constraint(equalTo: self.backView.trailingAnchor)
        let widthPostImageView = self.myImageView.heightAnchor.constraint(equalTo: self.backView.widthAnchor, multiplier: 1.0)

        let topConstraintDescriptionLabel = self.label2.topAnchor.constraint(equalTo: self.myImageView.bottomAnchor, constant: 16)
        let leadingConstraintDescriptionLabel = self.label2.leadingAnchor.constraint(equalTo: self.backView.leadingAnchor, constant: 16)
        let trailingConstraintDescriptionLabel = self.label2.trailingAnchor.constraint(equalTo: self.backView.trailingAnchor, constant: -16)

        let topConstraintLikeStackView = self.stackView.topAnchor.constraint(equalTo: self.label2.bottomAnchor)
        let leadingConstraintLikeStackView = self.stackView.leadingAnchor.constraint(equalTo: self.backView.leadingAnchor, constant: 16)
        let trailingConstraintLikeStackView = self.stackView.trailingAnchor.constraint(equalTo: self.backView.trailingAnchor, constant: -16)
        let bottomConstraintLikeStackView = self.stackView.bottomAnchor.constraint(equalTo: self.backView.bottomAnchor, constant: -16)

        NSLayoutConstraint.activate([ topConstraintAuthorLabel, topConstraintPostImageView, widthPostImageView, leadingConstraintAuthorLabel, trailingConstraintAuthorLabel, topConstraintDescriptionLabel, leadingConstraintDescriptionLabel, trailingConstraintDescriptionLabel, topConstraintLikeStackView, leadingConstraintLikeStackView, trailingConstraintLikeStackView, bottomConstraintLikeStackView, leadingConstraintPostImageView, trailingConstraintPostImageView, leadingConstraintBackView, trailingConstraintBackView, centerXConstraintBackView, centerYConstraintBackView
        ])
    }
}

extension SinglePostView: Setupable {
    func setup(with viewModel: ViewModelProtocol) {
        guard let viewModel = viewModel as? ViewModel else { return }
        self.label.text = viewModel.author
        self.myImageView.image = UIImage(named: viewModel.image)
        self.label2.text = viewModel.description
        self.likes.text = "Likes: " + String(viewModel.likes)
        self.views.text = "Views: " + String(thisViews)
    }
}
