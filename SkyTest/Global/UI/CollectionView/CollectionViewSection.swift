import UIKit

protocol CollectionViewSection {
    var padding: UIEdgeInsets { get }
    var distanceBetweenItemsInSection: CGFloat { get }
    var collectionViewItems: [CollectionViewItem] { get set }
    func numberOfItems() -> Int
}
