import Reusable
import UIKit

protocol CollectionViewItem {
    var heightForItem: CGFloat { get }
    func dequeue(collectionView: UICollectionView, indexPath: IndexPath) -> CollectionViewItemCell
    func registerFor(collectionView: UICollectionView)
}
