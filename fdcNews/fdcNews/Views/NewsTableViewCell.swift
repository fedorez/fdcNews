//
//  NewsTableViewCell.swift
//  fdcNews
//
//  Created by Denis Fedorets on 04.02.2022.
//

import UIKit

class NewsTableViewCell: UITableViewCell {
    
    var newsVM: NewsViewModel? {
        didSet {
            if let newsVM = newsVM {
                titleLabel.text = newsVM.title
                viewsLabel.text = newsVM.views
                NetworkManager.shared.getImage(urlString: newsVM.urlToImage){(data) in
                    guard let data = data else {
                        return
                    }
                    DispatchQueue.main.async {
                        self.newsImage.image = UIImage(data: data)
                    }
                }
            }
        }
    }
    
    var newsImageData: Data? {
        didSet {
            if let data = newsImageData {
                newsImage.image = UIImage(data: data)
            }
        }
    }
    
    private lazy var newsImage: ShadowImageView = {
        let myShadowImageView = ShadowImageView()
        myShadowImageView.translatesAutoresizingMaskIntoConstraints = false
        return myShadowImageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let myLabel = UILabel()
        myLabel.translatesAutoresizingMaskIntoConstraints = false
        myLabel.numberOfLines = 0
        return myLabel
    }()
    
    private lazy var viewsLabel: UILabel = {
        let myLabel = UILabel()
        myLabel.translatesAutoresizingMaskIntoConstraints = false
        myLabel.font = UIFont.boldSystemFont(ofSize: UIFont.smallSystemFontSize)
        myLabel.textAlignment = .right
        myLabel.textColor = .red
        return myLabel
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        addSubview(viewsLabel)
        addSubview(titleLabel)
        addSubview(newsImage)
        setupConstraints()
    }
    
    func setupConstraints() {
        //vews number
        NSLayoutConstraint.activate([
            viewsLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            viewsLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            viewsLabel.topAnchor.constraint(equalTo: topAnchor, constant: 4),
            viewsLabel.heightAnchor.constraint(equalToConstant: 10)
        ])
        //news image
        
        NSLayoutConstraint.activate([
            newsImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            newsImage.trailingAnchor.constraint(equalTo: trailingAnchor),
            newsImage.topAnchor.constraint(equalTo: viewsLabel.bottomAnchor, constant: 8),
            newsImage.heightAnchor.constraint(equalToConstant: 200)
        ])
         
        //news title
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            titleLabel.topAnchor.constraint(equalTo: newsImage.bottomAnchor, constant: 8 ),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
        ])
         
    }
    

}
