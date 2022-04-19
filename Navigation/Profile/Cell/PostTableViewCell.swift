//
//  PostTableViewCell.swift
//  Navigation
//
//  Created by Tatyana Sidoryuk on 13.04.2022.
//

import Foundation

import UIKit

class PostTableViewCell: UITableViewCell {
    
    struct ViewModel: ViewModelProtocol {
        var author: String
        var description: String
        var image: String
        var likes: Int
        var views: Int
    }

    private lazy var myView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        return view
    } ()
    
    private lazy var myImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.backgroundColor = .black
        image.contentMode = .scaleAspectFit
        return image
    } ()
    

    private lazy var label: UILabel = { // author
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = .black
        label.setContentHuggingPriority(UILayoutPriority(1), for: .vertical)
        label.setContentCompressionResistancePriority(UILayoutPriority(100), for: .vertical)
        return label
    } ()
    
    private lazy var label2: UILabel = {
        let label = UILabel()
        label.textColor = .systemGray
        label.setContentCompressionResistancePriority(UILayoutPriority(999), for: .vertical)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.backgroundColor = .clear
        label.font = UIFont.systemFont(ofSize: 18)
        label.textAlignment = .left
        return label
    } ()
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.distribution = .fill
        stack.setContentCompressionResistancePriority(UILayoutPriority(1000), for: .vertical)
        return stack
    } ()
    
    private lazy var likes: UILabel = { // likes
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Likes: "
        label.backgroundColor = .clear
        label.font = UIFont.systemFont(ofSize: 16)
        label.preferredMaxLayoutWidth = self.frame.size.width
        label.textColor = .black
        label.setContentHuggingPriority(UILayoutPriority(1), for: .horizontal)
        label.setContentCompressionResistancePriority(UILayoutPriority(1000), for: .vertical)
        return label
    } ()
    
    private lazy var views: UILabel = { // views
        let views = UILabel()
        views.translatesAutoresizingMaskIntoConstraints = false
        views.text = "Views: "
        views.backgroundColor = .clear
        views.font = UIFont.systemFont(ofSize: 16)
        views.preferredMaxLayoutWidth = self.frame.size.width
        views.textColor = .black
        views.setContentCompressionResistancePriority(UILayoutPriority(1000), for: .vertical)
        return views
    } ()
    
    override init (style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.label.text = nil
        self.myImageView.image = nil
        self.label2.text = nil
        self.views.text = nil
        self.likes.text = nil
    }
    
    private func setupView () {
        self.contentView.backgroundColor = .white
        self.contentView.addSubview(self.myView)

        self.myView.addSubview(self.label)
        self.myView.addSubview(self.myImageView)
        self.myView.addSubview(self.label2)
        self.myView.addSubview(self.stackView)
        self.stackView.addArrangedSubview(self.likes)
        self.stackView.addArrangedSubview(self.views)
        
        let myViewTopConstraint = self.myView.topAnchor.constraint(equalTo: self.contentView.topAnchor)
        let myViewLeadingConstraint = self.myView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor)
        let myViewTrailingConstraint = self.myView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor)
        let myViewBottomConstraint = self.myView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor)
        
        let authorTopConstraint = self.label.topAnchor.constraint(equalTo: self.myView.topAnchor, constant: 16)
        let authorLeadingConstraint = self.label.leadingAnchor.constraint(equalTo: self.myView.leadingAnchor, constant: 16)
        let authorTrailingConstraint = self.label.trailingAnchor.constraint(equalTo: self.myView.trailingAnchor, constant: -16)
        let authorHeightConstraint = self.label.heightAnchor.constraint(equalToConstant: 50)
        
        let topImageConstraint = self.myImageView.topAnchor.constraint(equalTo: self.label.bottomAnchor, constant: 12)
        let leadingImageConstraint = self.myImageView.leadingAnchor.constraint(equalTo: self.myView.leadingAnchor)
        let trailingImageConstraint = self.myImageView.trailingAnchor.constraint(equalTo: self.myView.trailingAnchor)
        let heightImageConstraint = self.myImageView.heightAnchor.constraint(equalTo: self.myView.widthAnchor)
        
        let topLabel2Constraint = self.label2.topAnchor.constraint(equalTo: self.myImageView.bottomAnchor, constant: 16)
        let leadingLabel2Constraint = self.label2.leadingAnchor.constraint(equalTo: self.myView.leadingAnchor, constant: 16)
        let trailingLabel2Constraint = self.label2.trailingAnchor.constraint(equalTo: self.myView.trailingAnchor, constant: -16)

        
        let topStackConstraint = self.stackView.topAnchor.constraint(equalTo: self.label2.bottomAnchor, constant: 16)
        let leadingStackConstraint = self.stackView.leadingAnchor.constraint(equalTo: self.myView.leadingAnchor, constant: 16)
        let trailingStackConstraint = self.stackView.trailingAnchor.constraint(equalTo: self.myView.trailingAnchor, constant: -16)
        let bottomStackConstraint = self.stackView.bottomAnchor.constraint(equalTo: self.myView.bottomAnchor, constant: -16)
        
        NSLayoutConstraint.activate([
            myViewTopConstraint, myViewLeadingConstraint, myViewTrailingConstraint, myViewBottomConstraint,
            authorTopConstraint, authorLeadingConstraint, authorTrailingConstraint, authorHeightConstraint,
            topImageConstraint, leadingImageConstraint, trailingImageConstraint, heightImageConstraint,
            topLabel2Constraint, leadingLabel2Constraint, trailingLabel2Constraint,
            topStackConstraint, leadingStackConstraint, trailingStackConstraint, bottomStackConstraint
        ])
    }
}

extension PostTableViewCell: Setupable {
    func setup (with viewModel: ViewModelProtocol) {
        guard let viewModel = viewModel as? ViewModel else { return }
        
        self.label.text = viewModel.author
        self.myImageView.image = UIImage(named: viewModel.image)
        self.label2.text = viewModel.description
        self.likes.text = "Likes: " + String (viewModel.likes)
        self.views.text = "Views: " + String (viewModel.views)
    }
}
