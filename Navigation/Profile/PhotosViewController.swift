//
//  PhotosViewController.swift
//  Navigation
//
//  Created by Tatyana Sidoryuk on 15.03.2022.
//

import UIKit

class PhotosViewController: UIViewController {
    
    var largeImage = UIImage()

    // серый фон для жестов
    private lazy var grayView: UIView = {
        let view = UIView()
        view.alpha = 0
        view.backgroundColor = .systemGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
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
    
    public lazy var largeCopy: UIImageView = {
        let imageView  = UIImageView()
        imageView.backgroundColor = .white
        imageView.clipsToBounds = true
        imageView.layer.borderWidth = 3
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.image = largeImage
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
    }
    
    @objc private func pressedButton() {
        UIView.animate(withDuration: 0.5) {
            self.grayView.alpha = 0
        } completion: { _ in
        }
        UIView.animate(withDuration: 0.5) {
            self.navigationItem.rightBarButtonItems = nil
        } completion: { _ in
        }
        largeCopy.removeFromSuperview()
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        largeImage = UIImage(named: catsImages[indexPath.row])!
        
        view.addSubview(grayView)

        // перекрывающий серый фон
        let secondViewTopConstraint = self.grayView.topAnchor.constraint(equalTo: self.view.topAnchor)
        let secondViewLeadingConstraint = self.grayView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor)
        let secondViewTrailingConstraint = self.grayView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        let secondViewBottomConstraint = self.grayView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
   
        NSLayoutConstraint.activate([
                                     secondViewTopConstraint, secondViewBottomConstraint, secondViewLeadingConstraint, secondViewTrailingConstraint
        ])
        view.bringSubviewToFront(grayView)

        UIView.animate(withDuration: 0.5) {
            self.grayView.alpha = 0.7
        } completion: { _ in
        }
        UIView.animate(withDuration: 0.3, delay: 0.5) {
            self.navigationItem.rightBarButtonItems = [
                UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(self.pressedButton))
                    ]
        } completion: { _ in
        }
        

        largeCopy.image = largeImage
        largeCopy.reloadInputViews()
        view.addSubview(largeCopy)
        let largeCopyWidthConstraint = self.largeCopy.widthAnchor.constraint(equalTo: self.view.widthAnchor)
        let largeCopyHeightConstraint = self.largeCopy.heightAnchor.constraint(equalTo: self.view.widthAnchor)
        let largeCopyXConstraint = self.largeCopy.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        let largeCopyYConstraint = self.largeCopy.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        NSLayoutConstraint.activate([ largeCopyXConstraint, largeCopyYConstraint, largeCopyWidthConstraint, largeCopyHeightConstraint
        ])
        view.bringSubviewToFront(largeCopy)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
           return 1
       }
}
