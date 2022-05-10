//
//  LargeCell.swift
//  Navigation
//
//  Created by Tatyana Sidoryuk on 08.05.2022.
//

import UIKit

protocol LargeCellDelegate: AnyObject {
    func pressedButton(view: LargeCell)
}

class LargeCell: UIView {
    weak var delegate: LargeCellDelegate?
    var pressButtonCancel = UITapGestureRecognizer()

    lazy var imageLargeCell: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        image.backgroundColor = .black
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    lazy var buttonCancel: UIImageView = {
        let button = UIImageView()
        button.image = UIImage(systemName: "multiply.square")
        button.tintColor = .white
        button.alpha = 0
        button.isUserInteractionEnabled = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        drawSelf()
        setupGesture()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func drawSelf() {
        self.addSubview(imageLargeCell)
        self.addSubview(buttonCancel)

        NSLayoutConstraint.activate([
            imageLargeCell.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            imageLargeCell.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            imageLargeCell.widthAnchor.constraint(equalTo: self.widthAnchor),
            imageLargeCell.heightAnchor.constraint(equalTo: self.widthAnchor),
            buttonCancel.topAnchor.constraint(equalTo: self.topAnchor, constant: 110),
            buttonCancel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            buttonCancel.widthAnchor.constraint(equalToConstant: 30),
            buttonCancel.heightAnchor.constraint(equalToConstant: 30)
        ])
    }

    private func setupGesture() {
        pressButtonCancel.addTarget(self, action: #selector(pressedButton(_:)))
        buttonCancel.addGestureRecognizer(pressButtonCancel)
    }

    @objc func pressedButton(_ gestureRecognizer: UITapGestureRecognizer) {
        delegate?.pressedButton(view: self)
    }
}
