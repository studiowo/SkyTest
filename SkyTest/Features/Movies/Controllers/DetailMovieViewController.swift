//
//  DetailMovieViewController.swift
//  SkyTest
//
//  Created by Renato Matos de Paula on 05/11/18.
//  Copyright © 2018 Renato Matos de Paula. All rights reserved.
//

import UIKit

final class DetailMovieViewController: BaseViewController {
    lazy var labelTitle: UILabel = UILabel()
    lazy var labelDescription: UILabel = UILabel()
    lazy var imageBackground: UIImageView = UIImageView()
    
    let coordinatorProtocol: MoviesCoordinatorProtocol
    let model: MovieModel
    
    init(with coordinator: MoviesCoordinatorProtocol, movieModel: MovieModel) {
        model = movieModel
        coordinatorProtocol = coordinator
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = self.model.title
        
        self.view.accessibilityIdentifier = "detailMovieViewController"
        self.setupViews()
    }
}

//MARK: View Code
extension DetailMovieViewController: ViewCodeProtocol {
    func configViews() {
        self.view.backgroundColor = .black
        
        self.imageBackground.translatesAutoresizingMaskIntoConstraints = false
        self.imageBackground.contentMode = .scaleAspectFill
        self.imageBackground.alpha = 0
        self.imageBackground.imageFrom(url: self.model.cover_url, isShadow: true)
        
        self.labelTitle.translatesAutoresizingMaskIntoConstraints = false
        self.labelTitle.numberOfLines = 0
        self.labelTitle.font = .boldSystemFont(ofSize: 46)
        self.labelTitle.text = self.model.title
        self.labelTitle.textColor = .white
        self.labelTitle.textAlignment = .left
        
        self.labelDescription.translatesAutoresizingMaskIntoConstraints = false
        self.labelDescription.numberOfLines = 0
        self.labelDescription.font = .systemFont(ofSize: 14)
        self.labelDescription.text = self.model.overview
        self.labelDescription.textColor = .white
        self.labelDescription.textAlignment = .left
    }
    
    func buildViews() {
        self.view.addSubview(self.imageBackground)
        self.view.addSubview(self.labelTitle)
        self.view.addSubview(self.labelDescription)
    }
    
    func configConstraints() {
        self.imageBackground.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        self.imageBackground.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        self.imageBackground.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        self.imageBackground.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        
        self.labelDescription.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -20).isActive = true
        self.labelDescription.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20).isActive = true
        self.labelDescription.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20).isActive = true
        
        self.labelTitle.bottomAnchor.constraint(equalTo: self.labelDescription.topAnchor, constant: -10).isActive = true
        self.labelTitle.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20).isActive = true
        self.labelTitle.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20).isActive = true
    }
}
