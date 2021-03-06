//
//  PhotosTableViewCell.swift
//  Navigation
//
//  Created by Tatyana Sidoryuk on 13.03.2022.
//

import Foundation
import UIKit

protocol PhotosTableViewCellProtocol: AnyObject {
    func delegateButtonAction()
}

class PhotosTableViewCell: UITableViewCell {
    
weak var delegate: PhotosTableViewCellProtocol?
    
    private lazy var backView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.setContentCompressionResistancePriority(UILayoutPriority(250), for: .vertical)
        return stackView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text  = "Photos"
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 24.0)
        label.setContentCompressionResistancePriority(UILayoutPriority(250), for: .horizontal)
        return label
    }()
    
    private lazy var transitionButton: UIButton = {
           let button = UIButton()
           let image = UIImage(named: "arrow")
           button.setBackgroundImage(image, for: .normal)
           button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
           button.translatesAutoresizingMaskIntoConstraints = false
           button.setContentCompressionResistancePriority(UILayoutPriority(250), for: .horizontal)
           return button
       }()
    
    
    @objc private func buttonAction() {
        delegate?.delegateButtonAction()
    }
    
    private lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 8
        return layout
    }()
    
    private lazy var photoCollectionView: UICollectionView = { 
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(PhotosCollectionViewCell.self, forCellWithReuseIdentifier: "PhotosCollection")
        stackView.setContentCompressionResistancePriority(UILayoutPriority(750), for: .vertical)
        return collectionView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        self.backgroundColor = .systemGray6
        self.contentView.addSubview(self.backView)
        self.backView.addSubview(self.stackView)
        self.stackView.addArrangedSubview(self.titleLabel)
        self.stackView.addArrangedSubview(self.transitionButton)
        self.backView.addSubview(photoCollectionView)
        setupConstraints()
    }
    
    private func setupConstraints() {
        let topConstraint = self.backView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0)
        let leadingConstraint = self.backView.leadingAnchor.constraint(equalTo: self.leadingAnchor)
        let trailingConstraint = self.backView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        let bottomConstraint = self.backView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0)
        
        let stackViewTopConstraint = self.stackView.topAnchor.constraint(equalTo: self.backView.topAnchor, constant: 12)
        let stackViewLeadingConstraint = self.stackView.leadingAnchor.constraint(equalTo: self.backView.leadingAnchor, constant: 12)
        let stackViewTrailingConstraint = self.stackView.trailingAnchor.constraint(equalTo: self.backView.trailingAnchor, constant: -12)
        
        let transitionButtonHeight = self.transitionButton.heightAnchor.constraint(equalTo: self.stackView.heightAnchor, multiplier: 1)
        let transitionButtonWidth = self.transitionButton.widthAnchor.constraint(equalTo: self.stackView.heightAnchor, multiplier: 1)
        
        let photoCollectionViewTopConstraint = self.photoCollectionView.topAnchor.constraint(equalTo: self.stackView.bottomAnchor)
        let photoCollectionViewLeadingConstraint = self.photoCollectionView.leadingAnchor.constraint(equalTo: self.backView.leadingAnchor, constant: 12)
        let photoCollectionViewTrailingConstraint = self.photoCollectionView.trailingAnchor.constraint(equalTo: self.backView.trailingAnchor, constant: -12)
        let photoCollectionViewConstraint = self.photoCollectionView.bottomAnchor.constraint(equalTo: self.backView.bottomAnchor, constant: -12)
        let photoCollectionViewHeight = self.photoCollectionView.heightAnchor.constraint(equalTo: self.contentView.widthAnchor, multiplier: 0.25)
        
        NSLayoutConstraint.activate([
            topConstraint, leadingConstraint, bottomConstraint, trailingConstraint,
            stackViewTopConstraint, stackViewLeadingConstraint, stackViewTrailingConstraint,
            photoCollectionViewTopConstraint, photoCollectionViewLeadingConstraint,
            photoCollectionViewTrailingConstraint, photoCollectionViewConstraint,
            photoCollectionViewHeight, transitionButtonHeight, transitionButtonWidth
        ])
    }
    
    private func itemSize(for width: CGFloat, with spacing: CGFloat) -> CGSize { // ?????????????? ????????????
        let needWidth = width - 2 * spacing
        let itemWidth = floor(needWidth / 4)
        return CGSize(width: itemWidth, height: itemWidth)
    }
}

extension PhotosTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return catsImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotosCollection", for: indexPath) as! PhotosCollectionViewCell
        DispatchQueue.main.async {
            let catImage = catsImages[indexPath.row]
            let viewModel = PhotosCollectionViewCell.ViewModel(image: catImage)
            cell.setup(with: viewModel)
        }
        return cell
    }
}

extension PhotosTableViewCell : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize { 
        let spacing = (collectionView.collectionViewLayout as? UICollectionViewFlowLayout)?.minimumInteritemSpacing
        return self.itemSize(for: collectionView.frame.width, with: spacing ?? 0)
    }
}

