//
//  ListMoviewsDataSourceDelegate.swift
//  SkyTest
//
//  Created by Renato Matos de Paula on 05/11/18.
//  Copyright © 2018 Renato Matos de Paula. All rights reserved.
//

import UIKit

//MARK: Data Source
extension ListMoviesViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.model?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let model = self.model, let cell = cell as? MoviewCollectionViewCell else {
            return
        }
        
        cell.model = model[indexPath.item]
        cell.accessibilityIdentifier = "listMovieCell_\(indexPath.item)"
        cell.setupViews()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: MoviewCollectionViewCell.self)
        return cell
    }
}

//MARK: Delegate
extension ListMoviesViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let model = self.model else {
            return
        }
        self.coordinatorProtocol.selectMovie(model: model[indexPath.item])
    }
}

//MARK: Layout Delegate
extension ListMoviesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let paddingSpace = self.sectionInsets.left * (self.itemsPerRow + 1)
        let availableWidth = self.view.frame.width - paddingSpace
        let widthPerItem = availableWidth / self.itemsPerRow
        
        return CGSize(width: widthPerItem, height: widthPerItem+100)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return self.sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return self.sectionInsets.left
    }
}
