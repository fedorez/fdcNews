//
//  ShadowImageView.swift
//  fdcNews
//
//  Created by Denis Fedorets on 04.02.2022.
//

import UIKit

final class ShadowImageView: UIView {
    
    private lazy var imageView: UIImageView = {
        let myImageView = UIImageView()
        myImageView.translatesAutoresizingMaskIntoConstraints = false
        myImageView.contentMode = .scaleAspectFill
        myImageView.layer.cornerRadius = 20
        myImageView.clipsToBounds = true
        return myImageView
    }()
    
    private lazy var baseView: UIView = {
        let myView = UIView()
        myView.translatesAutoresizingMaskIntoConstraints = false
        myView.backgroundColor = .clear
        myView.layer.shadowColor = UIColor.black.cgColor
        myView.layer.shadowOffset = CGSize(width: 5, height: 5)
        myView.layer.shadowOpacity = 0.6
        myView.layer.shadowRadius = 10.0
        return myView
    }()

    var image: UIImage? {
        didSet {
            imageView.image = image
        }
    }
    
    init() {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        addSubview(baseView)
        baseView.addSubview(imageView)
        
        setupConstraints()
    }
    
    func setupConstraints() {
        [baseView, imageView].forEach{ (v) in
            NSLayoutConstraint.activate([
                v.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
                v.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
                v.topAnchor.constraint(equalTo: topAnchor, constant: 16),
                v.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            ])
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        baseView.layer.shadowPath = UIBezierPath(roundedRect: baseView.bounds, cornerRadius: 10).cgPath
        baseView.layer.shouldRasterize = true
        baseView.layer.rasterizationScale = UIScreen.main.scale
    }
    
}
