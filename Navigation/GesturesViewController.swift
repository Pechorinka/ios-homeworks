//
//  GesturesViewController.swift
//  Navigation
//
//  Created by Tatyana Sidoryuk on 22.03.2022.
//

import UIKit

final class GesturesViewController: UIViewController {
    
    private lazy var myView: UIView = {
        let view  = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        view.clipsToBounds = true
        view.layer.borderWidth = 3
        view.layer.borderColor = UIColor.white.cgColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var mySecondView: UIView = {
        let view  = UIView()
        view.backgroundColor = .systemGray
        view.alpha = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var crossView: UIView = {
        let view  = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var cross: UIImageView = {
        let view  = UIImageView()
        view.image = UIImage(named: "cros.jpg")
        view.tintColor = .black
        view.alpha = 0
        view.isHidden = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    private lazy var image: UIImageView = {
        let imageView  = UIImageView(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
        imageView.image = UIImage(named: "cat.png")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let panGestureRecognizer = UIGestureRecognizer()
    
    private var widthConstraint: NSLayoutConstraint?
    private var heightConstraint: NSLayoutConstraint?
    private var centerXConstraint: NSLayoutConstraint?
    private var centerYConstraint: NSLayoutConstraint?
    private var topConstraint: NSLayoutConstraint?
    private var leadingConstraint: NSLayoutConstraint?
    private var imageWidthConstraint: NSLayoutConstraint?
    private var imageHeightConstraint: NSLayoutConstraint?
    private var crossWidthConstraint: NSLayoutConstraint?
    private var crossHeightConstraint: NSLayoutConstraint?
    private var crossTopConstraint: NSLayoutConstraint?
    private var crossTrailingtConstraint: NSLayoutConstraint?
    
    private var isExpanded = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        
        let pan1 = UIPanGestureRecognizer(target: self, action: #selector (handlePan))
        myView.addGestureRecognizer(pan1)
        
        let pan2 = UIPanGestureRecognizer(target: self, action: #selector (handlePan))
        crossView.addGestureRecognizer(pan2)
        
    }
    
    private func setupView() {
        self.view.backgroundColor = .white
        self.navigationController?.navigationBar.isHidden = true
        self.view.addSubview(self.myView)
        self.view.addSubview(mySecondView)
        self.view.bringSubviewToFront(self.myView)
        
        self.topConstraint = self.myView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 20)
        self.leadingConstraint = self.myView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20)
        self.widthConstraint = self.myView.widthAnchor.constraint(equalToConstant: 100)
        self.heightConstraint = self.myView.heightAnchor.constraint(equalToConstant: 100)
        
        self.imageWidthConstraint  = self.image.widthAnchor.constraint(equalToConstant: 100)
        self.imageHeightConstraint  = self.image.heightAnchor.constraint(equalToConstant: 100)
        
        let secondViewTopConstraint = self.mySecondView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 140)
        let secondViewLeadingConstraint = self.mySecondView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20)
        let secondViewTrailingConstraint = self.mySecondView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20)
        let secondViewBottomConstraint = self.mySecondView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -100)
        
        NSLayoutConstraint.activate([
            self.topConstraint, self.leadingConstraint, self.widthConstraint, self.heightConstraint, self.imageWidthConstraint, self.imageHeightConstraint, secondViewTopConstraint, secondViewBottomConstraint, secondViewLeadingConstraint, secondViewTrailingConstraint
        ].compactMap({$0}))
        
        myView.addSubview(image)
        self.view.addSubview(crossView)
        crossView.addSubview(cross)
        
        self.crossTopConstraint = self.crossView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 40)
        self.crossTrailingtConstraint = self.crossView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20)
        self.crossWidthConstraint = self.crossView.widthAnchor.constraint(equalToConstant:30)
        self.crossHeightConstraint = self.crossView.heightAnchor.constraint(equalToConstant:30)
        
        let cross2TopConstraint = self.cross.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 40)
        let cross2TrailingtConstraint = self.cross.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20)
        let cross2WidthConstraint = self.cross.widthAnchor.constraint(equalToConstant:30)
        let cross2HeightConstraint = self.cross.heightAnchor.constraint(equalToConstant:30)
        
        cross.isHidden = true
        
        NSLayoutConstraint.activate([
            self.crossWidthConstraint, self.crossTopConstraint, self.crossTrailingtConstraint, self.crossHeightConstraint, cross2TopConstraint, cross2WidthConstraint, cross2HeightConstraint, cross2TrailingtConstraint
        ].compactMap({$0}))
        
        myView.layer.cornerRadius = self.myView.frame.height / 2
    }
    
    @objc func handlePan (_ sender: UIPanGestureRecognizer) {

        switch sender.state {

        case .ended:
            if isExpanded == false {
            
            isExpanded.toggle()
            
            self.centerXConstraint = self.myView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
            self.centerYConstraint = self.myView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
            self.widthConstraint = self.myView.widthAnchor.constraint(equalTo: self.view.widthAnchor)
            self.heightConstraint = self.myView.heightAnchor.constraint(equalTo: self.view.widthAnchor)
            self.imageHeightConstraint = self.image.heightAnchor.constraint(equalTo: self.view.widthAnchor)
            self.imageWidthConstraint = self.image.widthAnchor.constraint(equalTo: self.view.widthAnchor)
            
            self.centerXConstraint?.isActive = true
            self.centerYConstraint?.isActive = true
            self.widthConstraint?.isActive = true
            self.heightConstraint?.isActive = true
            self.imageWidthConstraint?.isActive = true
            self.imageHeightConstraint?.isActive = true
            
            self.topConstraint?.isActive = false
            self.leadingConstraint?.isActive = false
                
            UIView.animate(withDuration: 1/2) {
                    self.mySecondView.alpha = 1/2
                    self.view.layoutIfNeeded()
                } completion: { _ in
                }
                
            UIView.animate(withDuration: 1/3, delay: 1/2) {
                self.cross.alpha = 1
                self.view.layoutIfNeeded()
            } completion: { _ in
            }
                
                
            } else {
                self.cross.isHidden = false
                
                let draggedView = sender.view!
                
                if draggedView === crossView {
                    isExpanded.toggle()
                    
                    self.centerXConstraint?.isActive = false
                    self.centerYConstraint?.isActive = false
                    self.imageWidthConstraint?.isActive = false
                    self.imageHeightConstraint?.isActive = false
                    self.topConstraint?.isActive = false
                    self.leadingConstraint?.isActive = false
                    self.widthConstraint?.isActive = false
                    self.heightConstraint?.isActive = false
                    
                    self.topConstraint = self.myView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 20)
                    self.leadingConstraint = self.myView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20)
                    self.widthConstraint = self.myView.widthAnchor.constraint(equalToConstant: 100)
                    self.heightConstraint = self.myView.heightAnchor.constraint(equalToConstant: 100)
                    
                    self.imageWidthConstraint  = self.image.widthAnchor.constraint(equalToConstant: 100)
                    self.imageHeightConstraint  = self.image.heightAnchor.constraint(equalToConstant: 100)
                    
                    NSLayoutConstraint.activate([
                        self.topConstraint, self.leadingConstraint, self.widthConstraint, self.heightConstraint, self.imageHeightConstraint, self.imageWidthConstraint
                    ].compactMap({$0}))
                    
                    UIView.animate(withDuration: 1/3) {
                        self.cross.alpha = 0
                        self.mySecondView.alpha = 0
                        self.view.layoutIfNeeded()
                    } completion: { _ in
                    }
                }
            }

        default:
            break
        }
    }
}
