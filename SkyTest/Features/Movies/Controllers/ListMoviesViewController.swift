//
//  ListMoviesViewController.swift
//  SkyTest
//
//  Created by Renato Matos de Paula on 05/11/18.
//  Copyright © 2018 Renato Matos de Paula. All rights reserved.
//

import UIKit

struct ItemSection: CollectionViewSection {
    var model: MovieModel? = nil
    var padding: UIEdgeInsets = .zero
    var distanceBetweenItemsInSection: CGFloat = 10.0
    var collectionViewItems: [CollectionViewItem] = []    
    func numberOfItems() -> Int {
        return 2
    }
}

final class ListMoviesViewController: BaseViewController {
    let sectionInsets = UIEdgeInsets(top: 20.0, left: 20.0, bottom: 20.0, right: 20.0)
    let itemsPerRow: CGFloat = 2
    
    let coordinatorProtocol: MoviesCoordinatorProtocol
    let collectionView: CollectionView = {
        let collectionView = CollectionView()
        collectionView.accessibilityIdentifier = "listMoviesCollection"
        collectionView.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    var model: [MovieModel]?
    
    init(with coordinator: MoviesCoordinatorProtocol) {
        coordinatorProtocol = coordinator
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Filmes"
        self.view.backgroundColor = UIColor.gray
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.showLoading()
        
        self.coordinatorProtocol.getListMoviews(success: { (model) in
            self.model = model
            self.setupViews()
        }) { (error) in
            self.hideLoading()
            self.showMessage(message: error)
        }
    }
}

//MARK: View Code
extension ListMoviesViewController: ViewCodeProtocol {
    func configViews() {
        self.hideLoading()
        
        self.collectionView.register(cellType: MoviewCollectionViewCell.self)
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        
    }
    
    func buildViews() {
        self.view.addSubview(self.collectionView)
    }
    
    func configConstraints() {
        self.collectionView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        self.collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        self.collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        self.collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
    }
}
