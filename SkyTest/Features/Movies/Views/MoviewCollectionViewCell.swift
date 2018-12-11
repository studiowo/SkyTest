//
//  MoviewCollectionViewCell.swift
//  SkyTest
//
//  Created by Renato Matos de Paula on 05/11/18.
//  Copyright © 2018 Renato Matos de Paula. All rights reserved.
//

import UIKit

class MoviewCollectionViewCell: CollectionViewSelfSizingItemCell, ViewCodeProtocol {
    lazy var imageView: UIImageView = UIImageView()
    lazy var labelTitle: UILabel = UILabel()
    
    var model: MovieModel?
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.imageView.image = nil
        self.labelTitle.text = ""
    }
    
    //MARK: View Code
    func configViews() {
        guard let model = self.model else {
            return
        }
        
        self.labelTitle.translatesAutoresizingMaskIntoConstraints = false
        self.labelTitle.font = .systemFont(ofSize: 12)
        self.labelTitle.numberOfLines = 0
        self.labelTitle.textColor = .lightGray
        self.labelTitle.text = model.title
        
        self.imageView.translatesAutoresizingMaskIntoConstraints = false
        self.imageView.alpha = 0
        self.imageView.layer.cornerRadius = 4
        self.imageView.clipsToBounds = true
        self.imageView.imageFrom(url: model.cover_url)
    }
    
    func buildViews() {
        self.addSubview(self.imageView)
        self.addSubview(self.labelTitle)
    }
    
    func configConstraints() {
        self.imageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        self.imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        self.imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        
        self.labelTitle.topAnchor.constraint(equalTo: self.imageView.bottomAnchor, constant: 10).isActive = true
        self.labelTitle.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        self.labelTitle.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        self.labelTitle.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    }
}
