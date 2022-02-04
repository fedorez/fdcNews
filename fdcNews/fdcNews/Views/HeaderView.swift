//
//  HeaderView.swift
//  fdcNews
//
//  Created by Denis Fedorets on 04.02.2022.
//

import UIKit

final class HeaderView: UIView {
    
    private var fontSize: CGFloat
    
    private lazy var headingLabel: UILabel = {
        let myLabel = UILabel()
        myLabel.translatesAutoresizingMaskIntoConstraints = false
        myLabel.text = "News"
        myLabel.font = UIFont.boldSystemFont(ofSize: fontSize)
        return myLabel
    }()
    
    private lazy var headerCircleImage: UIImageView = {
        let myImageView = UIImageView()
        myImageView.translatesAutoresizingMaskIntoConstraints = false
        myImageView.contentMode = .scaleAspectFit
        let config = UIImage.SymbolConfiguration(pointSize: fontSize, weight: .bold)
        myImageView.image = UIImage(systemName: "largecircle.fill.circle", withConfiguration: config)?.withRenderingMode(.alwaysOriginal)
        return myImageView
    }()
    
    private lazy var plusImage: UIImageView = {
        let myImageView = UIImageView()
        myImageView.translatesAutoresizingMaskIntoConstraints = false
        let config = UIImage.SymbolConfiguration(pointSize: fontSize, weight: .bold)
        myImageView.image = UIImage(systemName: "plus", withConfiguration: config)?.withRenderingMode(.alwaysOriginal)
        return myImageView
    }()
    
    private lazy var headerStackView: UIStackView = {
        let myStackView = UIStackView(arrangedSubviews: [headerCircleImage, headingLabel, plusImage])
        myStackView.translatesAutoresizingMaskIntoConstraints = false
        myStackView.axis = .horizontal
        return myStackView
    }()
    
    private lazy var subHeadLineLabel: UILabel = {
        let myLabel = UILabel()
        myLabel.translatesAutoresizingMaskIntoConstraints = false
        myLabel.text = "Top Headlines"
        myLabel.font = UIFont.boldSystemFont(ofSize: fontSize)
        myLabel.textColor = .gray
        return myLabel
    }()
    
    init(fontsize: CGFloat) {
        self.fontSize = fontsize
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        
        addSubview(headerStackView)
        addSubview(subHeadLineLabel)
        setupConstraints()
        
    }
    
    func setupConstraints() {
        //header
        NSLayoutConstraint.activate([
            headerStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            headerStackView.topAnchor.constraint(equalTo: topAnchor)
        ])
        
        //subheader
        NSLayoutConstraint.activate([
            subHeadLineLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            subHeadLineLabel.topAnchor.constraint(equalTo: headerStackView.bottomAnchor, constant: 8),
            subHeadLineLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
