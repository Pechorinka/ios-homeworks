//
//  PhotosViewController.swift
//  Navigation
//
//  Created by Tatyana Sidoryuk on 15.03.2022.
//

import UIKit

class PhotosViewController: UIViewController {

    private lazy var photoCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(PhotosCollectionViewCell.self, forCellWithReuseIdentifier: "PhotosCollection")
        collectionView.backgroundColor = .white
        return collectionView
    }()

    private lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 8
        layout.minimumLineSpacing = 8
        return layout
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
        self.navigationController?.navigationBar.isHidden = false
        self.navigationItem.title = "Photo Gallery"
    }
    
    private func setupCollectionView() { 
        self.view.addSubview(self.photoCollectionView)
        let topConstraint = self.photoCollectionView.topAnchor.constraint(equalTo: self.view.topAnchor)
        let leadingConstraint = self.photoCollectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor)
        let trailingConstraint = self.photoCollectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        let bottomConstraint = self.photoCollectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        
        NSLayoutConstraint.activate([
            topConstraint, leadingConstraint, trailingConstraint, bottomConstraint
        ])
    }
    
    private func itemSize(for width: CGFloat, with spacing: CGFloat) -> CGSize {
        let needWidth = width - 4 * spacing
        let itemWidth = floor(needWidth / 3)
        return CGSize(width: itemWidth, height: itemWidth)
    }
}

extension PhotosViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotosCollection", for: indexPath) as! PhotosCollectionViewCell
            DispatchQueue.main.async {
                let cat = catsImages[indexPath.row]
                let viewModel = PhotosCollectionViewCell.ViewModel(image: cat)
                cell.setup(with: viewModel)
            }
            return cell
        }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return catsImages.count
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let spacing = (collectionView.collectionViewLayout as? UICollectionViewFlowLayout)?.minimumLineSpacing
        return self.itemSize(for: collectionView.frame.width, with: spacing ?? 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
           return 1
       }
}
